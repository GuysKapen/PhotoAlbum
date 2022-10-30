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
        }
    }
});
