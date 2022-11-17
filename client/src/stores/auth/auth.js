import { defineStore } from "pinia";
import axios from 'axios'

export const useAuthStore = defineStore({
    id: "auth",
    persist: true,
    state: () => ({
        user: null,
        token: null,
    }),
    actions: {
        async logout() {
            this.user = null
        },

        async login({ email, password }) {
            try {
                // Sign in here
                const res = await axios.post("/api/authenticate", { email: email, password: password })
                this.user = res.data["user"]
                this.token = res.data["token"]

                return Promise.resolve("Success")
            } catch (error) {
                console.log(error);
                return Promise.reject(error)
            }
        },

        async signup({ name, password, email }) {
            try {
                const res = await axios.post("/api/register", { name: name, email: email, password: password })
                this.user = res.data["user"]

                await this.login({ email, password });
                return Promise.resolve()
            } catch (error) {
                console.log(error);
                return Promise.reject(error)
            }
        }
    },
});
