import { defineStore } from "pinia";
import { photobookService } from "@/services/photobook.service";

export const usePhotobookStore = defineStore({
    id: "photobook",
    state: () => ({
        photobooks: []
    }),
    actions: {
        async getPhotbook(id) {
            return (await photobookService.get(id))
        },
        async getPhotobooks() {
            const books = await photobookService.getMany()
            this.photobooks = books
            return books
        },
        addPhotobook(photobook) {
            this.photobooks = [...this.photobooks, photobook]
        },
    }
});
