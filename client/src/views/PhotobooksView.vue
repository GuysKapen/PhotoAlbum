<template>
  <div class="px-12 flex flex-row-reverse">
    <div class="w-3/12 my-8">
      <h3 class="text-2xl text-gray-700 font-bold mt-4">Add photobook</h3>
      <div class="flex flex-col m-auto mt-8">
        <div>
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
              <svg class="mx-auto h-12 w-12 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48"
                aria-hidden="true">
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
                  <input id="cover" name="cover" type="file" class="sr-only" v-on:change="onImageSelected($event)" />
                </label>
                <p class="pl-1">or drag and drop</p>
              </div>
              <p class="text-xs text-gray-500">PNG, JPG, GIF up to 10MB</p>
            </div>
          </div>
        </div>
        <label class="block text-sm font-medium text-gray-700 mt-4"> Pages </label>
        <div class="mt-2 ml-4" v-for="(page, idx) in pages" :key="idx">
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
                <svg class="mx-auto h-12 w-12 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48"
                  aria-hidden="true">
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
        <div class="text-indigo-600 flex items-center mt-2">
          <button class="text-sm flex items-center leading-3">
            <span class="material-symbols-outlined text-sm mr-2 mt-[0.1rem]">
              add
            </span>
            Add new page
          </button>
        </div>
        <button class="bg-indigo-600 py-3 rounded-md text-white font-black text-sm my-4" @click="createPhotobook()">
          Create Photobook
        </button>
      </div>
      <div class="text-red-500">{{ error }}</div>
    </div>
    <div class="my-8 flex-grow pr-12">
      <h5 class="mt-4 text-2xl font-bold text-gray-700">All photobooks</h5>
      <div class="grid grid-cols-3 gap-12 mt-8 w-12/12 mx-auto">
        <router-link v-for="(photobook, idx) in photobooks" :key="idx"
          :to="{ name: 'album-detail', params: { id: photobook.id } }">
          <div class="flex">
            <div class="flex-shrink-0">
              <img :src="imgUrlFor(serverUrl, photobook.cover)" alt="book" class="rounded-md w-[8.5rem] h-[11rem]" />
            </div>
            <div class="ml-4">
              <div>
                <span class="material-symbols-outlined text-sm text-yellow-500">
                  star
                </span>
                <span class="material-symbols-outlined text-sm text-yellow-500">
                  star
                </span>
                <span class="material-symbols-outlined text-sm text-yellow-500">
                  star
                </span>
                <span class="material-symbols-outlined text-sm text-yellow-500">
                  star
                </span>
                <span class="material-symbols-outlined text-sm text-yellow-500">
                  star
                </span>
              </div>
              <h3 class="text-gray-800 text-base">{{ photobook.name }}</h3>
              <p class="text-gray-400 text-sm mt-2 font-light">Karin Slugher</p>
              <div class="
                  rounded-full
                  border border-yellow-600
                  text-yellow-600
                  inline-block
                  px-4
                  py-1
                  mt-8
                ">
                View
              </div>
            </div>
          </div>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "pinia";
import { useAuthStore } from "@/stores/auth/auth";
import { usePhotobookStore } from "@/stores/photobooks"
import axios from "axios";
import { imgUrlFor } from "@/utils/utils";
const serverUrl = import.meta.env.VITE_SERVER_URL;

export default {
  async mounted() {
    const photobookStore = usePhotobookStore();
    photobookStore.getPhotobooks();
  },
  data: () => ({
    name: "",
    error: "",
    image: null,
    cover: null,
    serverUrl,
    imgUrlFor,
    pages: [{ content: null, image: null }]
  }),
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
        this.image = selectedFile;
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
        this.pages[idx].image = selectedFile;
      } else {
        console.log("Wrong file type");
      }
    },
    async createPhotobook() {
      const photobookStore = usePhotobookStore();

      this.error = "";
      if (!this.name) {
        this.error = "Please enter an album name";
        return;
      }
      if (this.image != null) {
        const form = new FormData();
        form.append("image", this.image);
        let res = await axios.post(
          `/api/users/${this.user.id}/uploads/image`,
          form,
          {
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${this.token}`,
              "x-access-token": this.token,
            },
          }
        );
        this.cover = res.data.data.name;
      }

      for (let index = 0; index < this.pages.length; index++) {
        const page = this.pages[index];

        if (page.image != null) {
          const form = new FormData();
          form.append("image", page.image);
          let res = await axios.post(
            `/api/users/${this.user.id}/uploads/image`,
            form,
            {
              headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${this.token}`,
                "x-access-token": this.token,
              },
            }
          );
          page.image = res.data.data.name;
        }
      }

      const newModel = {
        name: this.name,
        owner: this.user.id,
        cover: this.cover,
        pages: this.pages
      };

      try {
        axios
          .post(`/api/users/${this.user.id}/photobooks`, newModel, {
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${this.token}`,
              "x-access-token": this.token,
            },
          })
          .then((res) => {
            photobookStore.addPhotobook(res.data);
            this.cover = null;
            this.name = null;
            this.pages = []
          });
      } catch (error) {
        console.error("Create photobook", error);
      }
    },
  },
  computed: {
    ...mapState(useAuthStore, ["user"]),
    ...mapState(useAuthStore, ["token"]),
    ...mapState(usePhotobookStore, ["photobooks"]),
  },
};
</script>