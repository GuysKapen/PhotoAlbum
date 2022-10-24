import { defineStore } from "pinia";
import axios from 'axios'

import { useAuthStore } from "@/stores/auth/auth";

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
            const authStore = useAuthStore()
            const res = await axios.get(`/api/users/${authStore.user.id}/photobooks`, { params: { token: authStore.token } })
            this.photobooks = res.data
            return res.data
        },
        addPhotobook(photobook) {
            this.photobooks = [...this.photobooks, photobook]
        },
    },
});
