import axios from 'axios';
import { useAuthStore } from "@/stores/auth/auth";
class PhotobookService {
    constructor() {
        this.baseUrl = `/api/photobooks`;
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
    async update(id, model) {
        return (await this.api.put(`${this.baseUrl}/${id}`, model)).data;
    }
    async delete(id) {
        return (await this.api.delete(`${this.baseUrl}/${id}`)).data;
    }
    async getPages(id) {
        return (await this.api.get(`${this.baseUrl}/${id}/pages`)).data;
    }
    async toggleFavorite(id) {
        return (await this.api.put(`${this.baseUrl}/${id}/favorite`)).data;
    }
}
export const photobookService = new PhotobookService();