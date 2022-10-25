const knex = require('../database/knex');
class PhotopageService {
    constructor() {
        this.photobooks = knex('photopages');
    }

    #getPhotobook(payload) {
        const photobook = { ...payload };
        const contactProperties = ["content", "image", "photobook_id"];

        Object.keys(photobook).forEach(function (key) {
            if (contactProperties.indexOf(key) < 0) {
                delete photobook[key]
            }
        })

        return photobook;
    }

    async create(payload) {
        const photobook = this.#getPhotobook(payload);
        const [id] = await this.photobooks.insert(photobook);
        return { id, ...photobook };
    }

    async all() {
        return await this.photobooks.select('*');
    }

    async findByName(name) {
        return await this.photobooks
            .where('name', 'like', `%${name}%`)
            .select('*')
    }

    async findById(id) {
        return await this.photobooks
            .where('id', id)
            .select('*')
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
            .where('owner', userId)
            .select('*')
    }
}
module.exports = PhotopageService;