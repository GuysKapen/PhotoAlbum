const knex = require('../database/knex');
class AlbumService {
    constructor() {
        this.albumPhotobook = knex('album_photobook');
    }

    #getPhotobook(payload) {
        const album = { ...payload };
        const albumProperties = ["album_id", "photobook_id"];

        Object.keys(album).forEach(function (key) {
            if (albumProperties.indexOf(key) < 0) {
                delete album[key]
            }
        })

        return album;
    }

    async create(payload) {
        const album = this.#getPhotobook(payload);
        const [id] = await this.albumPhotobook.insert(album);
        return { id, ...album };
    }

    async all() {
        return await this.albumPhotobook.select('*');
    }

    async findByName(name) {
        return await this.albumPhotobook
            .where('name', 'like', `%${name}%`)
            .select('*')
    }

    async findById(id) {
        return await this.albumPhotobook
            .where('id', id)
            .select('*')
            .first()
    }

    async update(id, payload) {
        const album = this.#getPhotobook(payload);
        return await this.albumPhotobook.where('id', id).update(album)
    }

    async deleteofAlbum(id) {
        return await this.albumPhotobook.where('id', id).del()
    }

    async deleteOfBook(id) {
        return await this.albumPhotobook.where('photobook_id', id).del()
    }

    async findAllFavorite() {
        return await this.albumPhotobook.where('favorite', 1).select('*')
    }

    async deleteAll() {
        return await this.albumPhotobook.del();
    }

    async findOfUser(userId) {
        return await this.albumPhotobook
            .where('owner', userId)
            .select('*')
    }

    async findOfAlbum(albumdId) {
        return await this.albumPhotobook
            .join('photobooks', 'photobooks.id', 'album_photobook.photobook_id')
            .where('album_photobook.album_id', albumdId)
            .select('photobooks.*');
    }
}
module.exports = AlbumService;
