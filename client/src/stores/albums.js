import { defineStore } from "pinia";
import { albumService } from "@/services/album.service";

export const useAlbumStore = defineStore({
    id: "album",
    state: () => ({
        albums: []
    }),
    actions: {
        async getAlbum(id) {
            return (await albumService.get(id))
        },
        async getAlbums() {
            const albums = await albumService.getMany()
            this.albums = albums
            return albums
        },
        async getPhotobooks(id) {
            const albums = await albumService.getPhotobooks(id)
            return albums
        },
        addAlbum(album) {
            this.albums = [...this.albums, album]
        },
        async delete(id) {
            await albumService.delete(id)
            this.albums = this.albums.filter(el => el["id"] != id)
        },
        async toggleFavorite(id) {
            await albumService.toggleFavorite(id)
            this.albums = this.albums.map(el => (el["id"] === id) ? (Object.assign(el, { favorite: !el.favorite })) : el)
        },
        async update(id, album) {
            await albumService.update(id, album)
            this.albums = this.albums.map(el => (el["id"] === id) ? album : el)
        }
    }
});
