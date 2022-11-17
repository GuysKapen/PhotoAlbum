<template>
  <div class="w-4/12 mx-auto p-16 border mt-12 shadow-md">
    <h1 class="text-2xl font-bold text-gray-800 text-center">Sign In</h1>
    <Form :validation-schema="formSchema" class="flex flex-col justify-center" @submit="login">
      <div>
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
      <div class="flex flex-col mt-4">
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
            " placeholder="Password" type="password" v-model="password" />
        <ErrorMessage name="password" class="text-sm text-red-800" />
      </div>
      <!-- eslint-disable -->
      <button class="bg-indigo-600 py-3 px-8 mx-auto rounded-md text-white font-black text-sm my-4">
        Sign In
      </button>
    </form>
    <div class="text-red-600 text-sm">{{ error.message }}</div>
  </div>
</template>
<script>
import { mapActions, mapState } from "pinia";
import { useAuthStore } from "@/stores/auth/auth";
import * as yup from 'yup';
import { Form, Field, ErrorMessage } from 'vee-validate';
import { createToast } from 'mosha-vue-toastify';
export default {
  data() {
    const formSchema = yup.object().shape({
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
    return ({
      email: "",
      password: "",
      email: "",
      error: "",
      formSchema
    })
  },
  computed: {
    // gives access to this.count inside the component
    // same as reading from store.count
    ...mapState(useAuthStore, ["user"]),
    // same as above but registers it as this.myOwnName
  },
  methods: {
    ...mapActions(useAuthStore, { loginVue: "login" }),
    async login() {
      try {
        const user = await this.loginVue({
          email: this.email,
          password: this.password,
        });
        createToast(`Welcome back ${user.name}`, { type: "success" })
        this.$router.push("/");
      } catch (error) {
        this.error = error;
      }
    },
  },
  components: { Form, Field, ErrorMessage }
};
</script>
