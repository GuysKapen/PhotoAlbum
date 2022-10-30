const knex = require('../database/knex');
class AlbumService {
    constructor() {
        this.albums = knex('albums');
    }

    #getAlbum(payload) {
        const album = { ...payload };
        const albumProperties = ["name", "cover", "owner", "favorite"];

        Object.keys(album).forEach(function (key) {
            if (albumProperties.indexOf(key) < 0) {
                delete album[key]
            }
        })

        return album;
    }

    async create(payload) {
        const album = this.#getAlbum(payload);
        const [id] = await this.albums.insert(album);
        return { id, ...album };
    }

    async all() {
        console.log("sjfksjkfs");
        return await this.albums.select('*');
    }

    async findByName(name) {
        return await this.albums
            .where('name', 'like', `%${name}%`)
            .select('*')
    }

    async findById(id) {
        return await this.albums
            .where('id', id)
            .select('*')
            .first()
    }

    async update(id, payload) {
        const album = this.#getAlbum(payload);
        return await this.albums.where('id', id).update(album)
    }

    async delete(id) {
        return await this.albums.where('id', id).del()
    }

    async findAllFavorite() {
        return await this.albums.where('favorite', 1).select('*')
    }

    async deleteAll() {
        return await this.albums.del();
    }

    async findOfUser(userId) {
        return await this.albums
            .where('owner', userId)
            .select('*')
    }

    async toggleFavorite(id) {
        return await this.albums.where('id', id).update({ favorite: knex.raw('not favorite') })
    }
}
module.exports = AlbumService;
