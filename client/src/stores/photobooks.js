import { defineStore } from "pinia";
import axios from 'axios'

import { useAuthStore } from "@/stores/auth/auth";
import { photobookService } from "@/services/photobook.service";

export const usePhotobookStore = defineStore({
    id: "photobook",
    state: () => ({
        photobooks: []
    }),
    actions: {
        async getPhotbook(id) {
            const res = await axios.get(`/api/users/${this.user.id}/albums/${albumId}`, { params: { token: this.token } })
            return res.data
        },
        async getPhotobooks() {
            const books = await photobookService.getMany()
            this.photobooks = books
            return books
        },
        addPhotobook(photobook) {
            this.photobooks = [...this.photobooks, photobook]
        },
    },
});
