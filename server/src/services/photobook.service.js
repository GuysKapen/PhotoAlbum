const knex = require('../database/knex');
class PhotobookService {
    constructor() {
        this.photobooks = knex('photobooks');
    }

    #getPhotobook(payload) {
        const photobook = { ...payload };
        const contactProperties = ["name", "description", "cover", "owner", "favorite"];

        Object.keys(photobook).forEach(function (key) {
            if (contactProperties.indexOf(key) < 0) {
                delete photobook[key]
            }
        })

        return photobook;
    }

    async create(payload) {
        const photobook = this.#getPhotobook(payload);
        const [{id}] = await this.photobooks.insert(photobook).returning('id');
        return { id, ...photobook };
    }

    async all() {
        return await this.photobooks.join('users', 'users.id', 'photobooks.owner')
            .select('photobooks.*', 'users.name as owner');
    }

    async findByName(name) {
        return await this.photobooks
            .where('name', 'like', `%${name}%`)
            .select('*')
    }

    async findById(id) {
        return await this.photobooks
            .join('users', 'users.id', 'photobooks.owner')
            .where('photobooks.id', id)
            .select('photobooks.*', 'users.name as owner')
            .first()
    }

    async update(id, payload) {
        const photobook = this.#getPhotobook(payload);
        return await this.photobooks.where('id', id).update(photobook)
    }

    async delete(id) {
        return await this.photobooks.where('id', id).del()
    }

    async findAllFavorite() {
        return await this.photobooks.where('favorite', 1).select('*')
    }

    async deleteAll() {
        return await this.photobooks.del();
    }

    async findOfUser(userId) {
        return await this.photobooks
            .leftJoin("photopages", "photopages.photobook_id", "photobooks.id")
            .where('owner', userId)
            .groupBy('photobooks.id')
            .count('photopages.id as pages')
            .select('photobooks.*')
    }

    async toggleFavorite(id) {
        return await this.photobooks.where('id', id).update({ favorite: knex.raw('not favorite') })
    }
}
module.exports = PhotobookService;
