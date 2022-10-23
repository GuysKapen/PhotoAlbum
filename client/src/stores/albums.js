import { defineStore } from "pinia";
import axios from 'axios'

import { useAuthStore } from "@/stores/auth/auth";

export const useAlbumStore = defineStore({
    id: "album",
    state: () => ({
        albums: [],
    }),
    actions: {
        async getAlbum(albumId) {
            const res = await axios.get(`/api/users/${this.user.id}/albums/${albumId}`, { params: { token: this.token } })
            return res.data
        },
        async getAlbumsData() {
            const authStore = useAuthStore()
            const res = await axios.get(`/api/users/${authStore.user.id}/albums`, { params: { token: authStore.token } })
            this.albums = res.data
            return res.data
        },
        addAlbum(album) {
            this.albums = [...this.albums, album]
        },
    },
});
