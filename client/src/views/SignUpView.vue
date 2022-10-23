<template>
  <div>
    <form class="flex flex-col items-center" @submit.prevent="signup">
      <div class="flex flex-col user">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="userName">Name</label>
        <input class="
            shadow
            appearance-none
            border
            rounded
            w-full
            py-2
            px-3
            text-gray-700
            leading-tight
            focus:outline-none focus:shadow-outline
          " type="text" v-model="name" id="userName" />
      </div>
      <div class="flex flex-col mt-2">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="password">Password</label>
        <input class="
            shadow
            appearance-none
            border
            rounded
            w-full
            py-2
            px-3
            text-gray-700
            mb-3
            leading-tight
            focus:outline-none focus:shadow-outline
          " type="password" id="password" v-model="password" />
      </div>
      <div class="flex flex-col mt-2">
        <label class="block text-gray-700 text-sm font-bold" for="email">Email</label>
        <input class="
            shadow
            appearance-none
            border
            rounded
            w-full
            py-2
            px-3
            text-gray-700
            mb-3
            leading-tight
            focus:outline-none focus:shadow-outline
          " type="email" id="email" v-model="email" />
      </div>
      <!-- eslint-disable -->
      <button class="btn-blue">Sign Up</button>
    </form>
    <div v-if="error" class="text-red-600">{{ error.message }}</div>
  </div>
</template>

<script>

import { mapActions } from "pinia";
import { useAuthStore } from "@/stores/auth/auth";
export default {
  data() {
    return {
      name: "",
      password: "",
      email: "",
      error: "",
    };
  },

  methods: {
    ...mapActions(useAuthStore, { signupVue: "signup" }),
    async signup() {
      try {
        await this.signupVue({
          name: this.name,
          email: this.email,
          password: this.password,
        });
        this.$router.push("/albums");
      } catch (error) {
        this.error = error;
      }
    },
  },
};
</script>