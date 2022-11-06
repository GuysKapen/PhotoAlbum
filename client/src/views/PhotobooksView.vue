<template>
  <div class="px-12 flex flex-row-reverse">
    <div class="w-3/12 my-8">
      <h3 class="text-2xl text-gray-700 font-bold mt-4">Add photobook</h3>
      <PhotobookForm @submit:photobook="createPhotobook" />
    </div>
    <div class="my-8 flex-grow pr-12">
      <h5 class="mt-4 text-2xl font-bold text-gray-700">All photobooks</h5>
      <div class="grid grid-cols-3 gap-12 mt-8 w-12/12 mx-auto">
        <div v-for="(photobook, idx) in photobooks" :key="idx"
          :to="{ name: 'album-detail', params: { id: photobook.id } }">
          <div class="flex">
            <div class="flex-shrink-0">
              <img :src="imgUrlFor(serverUrl, photobook.cover)" alt="book" class="rounded-md w-[8.5rem] h-[11rem]" />
            </div>
            <div class="ml-4 flex flex-col justify-between">
              <div>
                <h3 class="text-gray-800 text-base">{{ photobook.name }}</h3>
                <p class="text-gray-400 text-sm font-light">Pages: {{ photobook.pages }}</p>
                <div class="mt-4 flex items-center justify-between">
                  <router-link :to="{ name: 'photobook-edit', params: { id: photobook.id } }">
                    <span class="material-symbols-outlined text-sm text-gray-500 hover:text-indigo-500">
                      edit
                    </span>
                  </router-link>
                  <span @click="deletePhotobook(photobook.id)"
                    class="material-symbols-outlined text-sm cursor-pointer text-gray-500 hover:text-indigo-500">
                    delete
                  </span>
                  <span @click="toggleFavorite(photobook.id)"
                    class="material-icons cursor-pointer text-sm text-gray-500 hover:text-indigo-500">
                    {{ photobook.favorite ? 'favorite' : 'favorite_border' }}
                  </span>
                </div>
              </div>
              <router-link :to="{ name: 'photobook-detail', params: { id: photobook.id } }">
                <div class="
                  rounded-full
                  text-white
                  bg-indigo-600
                  text-sm
                  px-6
                  py-2
                ">
                  View
                </div>
              </router-link>
            </div>
          </div>
        </div>
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
import PhotobookForm from "@/components/PhotobookForm.vue";
const serverUrl = import.meta.env.VITE_SERVER_URL;
import { photobookService } from '@/services/photobook.service';
import { createToast } from 'mosha-vue-toastify';

export default {
  async mounted() {
    const photobookStore = usePhotobookStore();
    photobookStore.getPhotobooks();
  },
  data: () => ({
    serverUrl,
    imgUrlFor,
  }),
  components: { PhotobookForm },
  methods: {
    async createPhotobook(photobook) {
      const photobookStore = usePhotobookStore();
      if (photobook.cover != null) {
        const form = new FormData();
        form.append("image", photobook.cover);
        let res = await axios.post(`/api/users/${this.user.id}/uploads/image`, form, {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${this.token}`,
            "x-access-token": this.token,
          },
        });
        photobook.cover = res.data.data.name;
      }
      for (let index = 0; index < photobook.pages?.length ?? 0; index++) {
        const page = photobook.pages[index];
        if (page.image != null) {
          const form = new FormData();
          form.append("image", page.image);
          let res = await axios.post(`/api/users/${this.user.id}/uploads/image`, form, {
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${this.token}`,
              "x-access-token": this.token,
            },
          });
          page.image = res.data.data.name;
        }
      }

      try {
        let res = await photobookService.create(photobook)
        photobookStore.addPhotobook(res);
        createToast("Succeed add photobook", { type: "success" })
      }
      catch (error) {
        console.error("Create photobook", error);
      }
    },
    async deletePhotobook(id) {
      if (!confirm("Are you sure delete this photobook?"))
        return;

      const photobookStore = usePhotobookStore();
      try {
        await photobookService.delete(id)
        photobookStore.removePhotobook(id);
        createToast("Succeed delete photobook", { type: "success" })
      }
      catch (error) {
        console.error("Remove photobook", error);
      }
    },
    async toggleFavorite(id) {
      const photobookStore = usePhotobookStore();
      try {
        await photobookService.toggleFavorite(id)
        photobookStore.updateFavorite(id);
      }
      catch (error) {
        console.error("Remove photobook", error);
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