<template>
  <div class="w-4/12 mx-auto p-16 border mt-12 shadow-md">
    <h1 class="text-2xl font-bold text-gray-800 text-center">Sign Up</h1>
    <Form :validation-schema="formSchema" class="flex flex-col justify-center mt-8" @submit="signup">
      <div class="">
        <label class="block text-sm font-medium text-gray-700"> Name </label>
        <Field name="name" class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Name..." type="text" v-model="name" />
        <ErrorMessage name="name" class="text-sm text-red-800" />
      </div>
      <div class="flex flex-col mt-2">
        <label class="block text-sm font-medium text-gray-700"> Email </label>
        <Field name="email" class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Email..." type="email" v-model="email" />
        <ErrorMessage name="email" class="text-sm text-red-800" />
      </div>
      <div class="flex flex-col mt-2">
        <label class="block text-sm font-medium text-gray-700"> Password </label>
        <Field name="password" class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Password..." type="password" v-model="password" />
        <ErrorMessage name="password" class="text-sm text-red-800" />
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
import * as yup from 'yup';
import { Form, Field, ErrorMessage } from 'vee-validate';
import { createToast } from 'mosha-vue-toastify';
export default {
  data() {
    const formSchema = yup.object().shape({
      name: yup
        .string()
        .required('Name can not be empty.')
        .min(2, 'Name must have at least 2 characters.')
        .max(50, 'Name can not longer than 50 characters.'),
      email: yup
        .string()
        .required('Email can not be empty.')
        .email('Not valid email')
        .max(50, 'Email can not longer than 50 characters.'),
      password: yup
        .string()
        .required('Password can not be empty.')
        .min(6, 'Password must have at least 6 characters.'),
    });
    return {
      name: "",
      password: "",
      email: "",
      error: "",
      formSchema
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
        createToast(`Succeed signup. Welcome ${this.name}`, { type: "success" })
        this.$router.push("/albums");
      } catch (error) {
        this.error = error;
      }
    },
  },
  components: { Form, Field, ErrorMessage }
};
</script>