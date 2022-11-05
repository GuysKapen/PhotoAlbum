<template>
  <div class="w-4/12 mx-auto p-16 border mt-12 shadow-md">
    <h1 class="text-2xl font-bold text-gray-800 text-center">Sign Up</h1>
    <form class="flex flex-col justify-center mt-8" @submit.prevent="signup">
      <div class="">
        <label class="block text-sm font-medium text-gray-700"> Name </label>
        <input class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Name..." type="text" v-model="name" />
      </div>
      <div class="flex flex-col mt-2">
        <label class="block text-sm font-medium text-gray-700"> Password </label>
        <input class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Password..." type="password" v-model="password" />
      </div>
      <div class="flex flex-col mt-2">
        <label class="block text-sm font-medium text-gray-700"> Email </label>
        <input class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Email..." type="email" v-model="email" />
      </div>
      <!-- eslint-disable -->
      <button class="bg-indigo-600 py-3 px-8 mx-auto rounded-md text-white font-black text-sm my-4">
        Sign Up
      </button>
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