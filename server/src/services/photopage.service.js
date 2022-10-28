const knex = require('../database/knex');
class PhotopageService {
    constructor() {
        this.photopages = knex('photopages');
    }

    #getPhotopage(payload) {
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
        const photobook = this.#getPhotopage(payload);
        const [id] = await this.photopages.insert(photobook);
        return { id, ...photobook };
    }

    async all() {
        return await this.photopages.select('*');
    }

    async findByName(name) {
        return await this.photopages
            .where('name', 'like', `%${name}%`)
            .select('*')
    }

    async findById(id) {
        return await this.photopages
            .where('id', id)
            .select('*')
            .first();
    }

    async update(id, payload) {
        const photopage = this.#getPhotopage(payload);
        return await this.photopages.where('id', id).update(photopage);
    }

    async delete(id) {
        return await this.photopages.where('id', id).del();
    }

    async findAllFavorite() {
        return await this.photopages.where('favorite', 1).select('*');
    }

    async deleteAll() {
        return await this.photopages.del();
    }

    async findOfBook(bookId) {
        return await this.photopages
            .where('photobook_id', bookId)
            .select('*');
    }

    async deleteOfBook(bookdId, keepIds = []) {
        return await this.photopages
            .where('photobook_id', -1)
            .del();
    }

}
module.exports = PhotopageService;
