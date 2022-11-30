<template>
    <Form :validation-schema="formSchema" :submit="submitForm">
        <div class="flex flex-col m-auto mt-8">
            <div>
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
            " placeholder="Name..." type="text" v-model="newPhotobook.name" />
                <ErrorMessage name="name" class="text-sm text-red-800" />
            </div>

            <div class="mt-4">
                <label class="block text-sm font-medium text-gray-700"> Description </label>
                <Field name="description" as="textarea" class="
                    mt-1
                    focus:ring-indigo-500 focus:border-indigo-500
                    block
                    w-full
                    shadow-sm
                    sm:text-sm
                    border-gray-300
                    rounded-md
                    " rows="4" placeholder="Description..." type="text" v-model="newPhotobook.description" />
                <ErrorMessage name="description" class="text-sm text-red-800" />
            </div>

            <div class="field">
                <div class="control flex flex-col flex-wrap mt-2 justify-start">
                    <label class="block font-semibold text-sm mt-2 w-4/12" for="input1">Album</label>
                    <div class="mt-2">

                        <div class="relative flex w-full">
                            <select v-model="newPhotobook.album" id="select-album" name="album"
                                placeholder="Select album..." autocomplete="off"
                                class="block w-full rounded-sm cursor-pointer focus:outline-none">
                                <option value="-1" selected="selected">No album</option>
                                <option v-for="(album, idx) in albums" :key="idx" :value="album.id">
                                    {{ album.name }}</option>
                            </select>
                        </div>

                        <span class="text-xs italic">The album of the book</span>
                    </div>
                </div>

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
            <label class="block text-sm font-medium text-gray-700 mt-4"> Pages </label>
            <div class="mt-2 ml-4" v-for="(page, idx) in newPhotobook.pages" :key="idx">
                <div class="my-2 flex justify-between">
                    <p class="text-gray-700 text-sm">Page {{ idx + 1 }}</p>
                    <button @click="page['collapse'] = !page['collapse']">
                        <span class="material-symbols-outlined mr-2 mt-[0.1rem]">
                            {{ page['collapse'] ? 'arrow_drop_down' : 'arrow_drop_up' }}
                        </span>
                    </button>
                </div>
                <div v-if="!page['collapse']">
                    <div class="">
                        <label class="block text-sm font-medium text-gray-700"> Content </label>
                        <input class="
              mt-1
              focus:ring-indigo-500 focus:border-indigo-500
              block
              w-full
              shadow-sm
              sm:text-sm
              border-gray-300
              rounded-md
            " placeholder="Name..." type="text" v-model="page.content" />
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
                                    <label :for="`cover-${idx}`" class="
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
                                        <input :id="`cover-${idx}`" :name="`cover-${idx}`" type="file" class="sr-only"
                                            v-on:change="onPageImageSelected($event, idx)" />
                                    </label>
                                    <p class="pl-1">or drag and drop</p>
                                </div>
                                <p class="text-xs text-gray-500">PNG, JPG, GIF up to 10MB</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="text-indigo-600 flex items-center mt-2">
                <button type="button" class="text-sm flex items-center leading-3" @click="addPage">
                    <span class="material-symbols-outlined text-sm mr-2 mt-[0.1rem]">
                        add
                    </span>
                    Add new page
                </button>
            </div>
            <button class="bg-indigo-600 py-3 rounded-md text-white font-black text-sm my-4">
                Save
            </button>
        </div>
        <div class="text-red-500">{{ error }}</div>
    </Form>
</template>

<script>
import { useAuthStore } from "@/stores/auth/auth";
import { imgUrlFor } from "@/utils/utils";
import axios from 'axios';
import TomSelect from 'tom-select'
const serverUrl = import.meta.env.VITE_SERVER_URL;

import * as yup from 'yup';
import { Form, Field, ErrorMessage } from 'vee-validate';
export default {
    props: {
        photobook: { type: Object }
    },
    data() {
        const formSchema = yup.object().shape({
            name: yup
                .string()
                .required('Name can not be empty.')
                .min(2, 'Name must have at least 2 characters.')
                .max(50, 'Name can not longer than 50 characters.'),
            description: yup
                .string()
                .required('Description can not be empty.')
                .min(8, 'Description must have at least 8 characters.')
        });
        return {
            newPhotobook: {
                ...this.photobook, owner: useAuthStore().user.id, album: -1
            },
            error: "",
            serverUrl,
            imgUrlFor,
            albums: [],
            formSchema
        }
    },
    async mounted() {
        this.albums = (await axios.get("/api/public/albums")).data
        setTimeout(function () {
            new TomSelect('#select-album', {});
        }, 0)
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
                this.newPhotobook.cover = selectedFile;
            } else {
                console.log("Wrong file type");
            }
        },
        onPageImageSelected(e, idx) {
            const selectedFile = e.target.files[0];
            // uploading asset to sanity
            if (
                selectedFile.type === "image/png" ||
                selectedFile.type === "image/svg" ||
                selectedFile.type === "image/jpeg" ||
                selectedFile.type === "image/gif" ||
                selectedFile.type === "image/tiff"
            ) {
                this.newPhotobook.pages[idx].image = selectedFile;
            } else {
                console.log("Wrong file type");
            }
        },
        submitForm() {
            this.$emit('submit:photobook', { ...this.newPhotobook })
            this.newPhotobook.cover = null;
            this.newPhotobook.name = null;
            this.newPhotobook.description = null;
            this.newPhotobook.album = null;
            this.newPhotobook.pages = [];
        },
        addPage() {
            this.newPhotobook.pages = [...(this.newPhotobook.pages ?? []), { image: null, content: null, collapse: false }]
        }
    },
    components: { Form, Field, ErrorMessage }
}
</script>

<style lang="scss" scoped>

</style>