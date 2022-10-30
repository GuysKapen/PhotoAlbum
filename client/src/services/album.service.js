import axios from 'axios';
import { useAuthStore } from "@/stores/auth/auth";
class AlbumService {
    constructor() {
        this.baseUrl = `/api/albums`;
        this.api = axios.create({
            headers: {
                'Content-Type': 'application/json',
                Accept: 'application/json',
            },
        });
        this.api.interceptors.request.use(function (config) {
            const token = useAuthStore().token;
            config.headers.Authorization = token
            config.headers["x-access-token"] = token
            return config;
        });
    }
    async getMany() {
        return (await this.api.get(this.baseUrl)).data;
    }
    async create(contact) {
        return (await this.api.post(this.baseUrl, contact)).data;
    }
    async deleteMany() {
        return (await this.api.delete(this.baseUrl)).data;
    }
    async get(id) {
        return (await this.api.get(`${this.baseUrl}/${id}`)).data;
    }
    async update(id, contact) {
        return (await this.api.put(`${this.baseUrl}/${id}`, contact)).data;
    }
    async delete(id) {
        return (await this.api.delete(`${this.baseUrl}/${id}`)).data;
    }
    async getPhotobooks(id) {
        return (await this.api.get(`${this.baseUrl}/${id}/photobooks`)).data;
    }
    async toggleFavorite(id) {
        return (await this.api.put(`${this.baseUrl}/${id}/favorite`)).data;
    }
}
export const albumService = new AlbumService();