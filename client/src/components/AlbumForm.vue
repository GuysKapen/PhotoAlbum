<template>

    <Form :validation-schema="albumFormSchema" @submit="submitForm">
        <div class="flex flex-col m-auto mt-8">
            <div>
                <label class="block text-sm font-medium text-gray-700"> Name </label>
                <Field name="name" type="text" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md" v-model="newAlbum.name" placeholder="Name ..." />
                <ErrorMessage name="name" class="text-sm text-red-800" />
            </div>

            <div class="mt-4">
                <label class="block text-sm font-medium text-gray-700">
                    Cover photo
                </label>
                <div class="
              mt-1
              flex
              justify-center
              px-6
              pt-5
              pb-6
              border-2 border-gray-300 border-dashed
              rounded-md
            ">
                    <div class="space-y-1 text-center">
                        <svg class="mx-auto h-12 w-12 text-gray-400" stroke="currentColor" fill="none"
                            viewBox="0 0 48 48" aria-hidden="true">
                            <path
                                d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        <div class="flex text-sm text-gray-600">
                            <label for="cover" class="
                    relative
                    cursor-pointer
                    bg-white
                    rounded-md
                    font-medium
                    text-indigo-600
                    hover:text-indigo-500
                    focus-within:outline-none
                    focus-within:ring-2
                    focus-within:ring-offset-2
                    focus-within:ring-indigo-500
                  ">
                                <span>Upload a file</span>
                                <input id="cover" name="cover" type="file" class="sr-only"
                                    v-on:change="onImageSelected($event)" />
                            </label>
                            <p class="pl-1">or drag and drop</p>
                        </div>
                        <p class="text-xs text-gray-500">PNG, JPG, GIF up to 10MB</p>
                    </div>
                </div>
            </div>
            <button type="submit" class="bg-indigo-600 py-3 rounded-md text-white font-black text-sm my-4">
                Save
            </button>
        </div>
        <div class="text-red-500">{{ error }}</div>
    </Form>
</template>

<script>
import { useAuthStore } from "@/stores/auth/auth";
import { imgUrlFor } from "@/utils/utils";
const serverUrl = import.meta.env.VITE_SERVER_URL;

import * as yup from 'yup';
import { Form, Field, ErrorMessage } from 'vee-validate';
export default {
    props: {
        album: { type: Object }
    },
    data() {
        const albumFormSchema = yup.object().shape({
            name: yup
                .string()
                .required('Name can not be empty.')
                .min(2, 'Name must have at least 2 characters.')
                .max(50, 'Name can not longer than 50 characters.'),
        });
        return {
            newAlbum: {
                ...this.album, owner: useAuthStore().user.id
            },
            error: "",
            serverUrl,
            imgUrlFor,
            albumFormSchema
        }
    },
    methods: {
        onImageSelected(e) {
            const selectedFile = e.target.files[0];
            // uploading asset to sanity
            if (
                selectedFile.type === "image/png" ||
                selectedFile.type === "image/svg" ||
                selectedFile.type === "image/jpeg" ||
                selectedFile.type === "image/gif" ||
                selectedFile.type === "image/tiff"
            ) {
                this.newAlbum.cover = selectedFile;
            } else {
                console.log("Wrong file type");
            }
        },
        submitForm() {
            this.$emit('submit:album', { ...this.newAlbum })
            this.newAlbum.cover = null;
        }
    },
    components: { Form, Field, ErrorMessage }
}
</script>

<style lang="scss" scoped>

</style>