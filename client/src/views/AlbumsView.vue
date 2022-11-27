<template>
  <div class="px-12 flex flex-row-reverse">
    <div class="w-3/12 my-8">
      <h3 class="text-2xl text-gray-700 font-bold mt-4">Add Album</h3>
      <album-form-vue @submit:album="createAlbum" />
    </div>
    <div class="my-8 flex-grow pr-12">
      <h5 class="mt-4 text-2xl font-bold text-gray-700">All albums</h5>
      <div class="grid grid-cols-3 gap-12 mt-8 w-12/12 mx-auto">
        <div v-for="(album, idx) in filteredAlbums" :key="idx">
          <div class="flex">
            <div class="flex-shrink-0" v-if="album.cover">
              <img :src="imgUrlFor(serverUrl, album.cover)" alt="book" class="rounded-md w-[8.5rem] h-[11rem]" />
            </div>
            <div class="ml-4 flex flex-col justify-between">
              <div class="">
                <router-link :to="{ name: 'album-detail', params: { id: album.id } }">
                  <h3 class="text-gray-800 hover:text-indigo-800 text-base">{{ album.name }}</h3>
                </router-link>
                <div class="mt-4 flex items-center justify-between">
                  <router-link :to="{ name: 'album-edit', params: { id: album.id } }">
                    <span class="material-symbols-outlined text-sm text-gray-500 hover:text-indigo-500">
                      edit
                    </span>
                  </router-link>
                  <span @click="deleteAlbum(album.id)"
                    class="material-symbols-outlined text-sm cursor-pointer text-gray-500 hover:text-indigo-500">
                    delete
                  </span>
                  <span @click="toggleFavorite(album.id)"
                    class="material-icons cursor-pointer text-sm text-gray-500 hover:text-indigo-500">
                    {{ album.favorite ? 'favorite' : 'favorite_border' }}
                  </span>
                </div>
              </div>
              <router-link :to="{ name: 'album-detail', params: { id: album.id } }">
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
import { useAlbumStore } from "@/stores/albums"
import { usePhotobookStore } from "@/stores/photobooks"
import axios from "axios";
import { imgUrlFor } from "@/utils/utils";
import AlbumFormVue from '@/components/AlbumForm.vue';
import { createToast } from 'mosha-vue-toastify';
const serverUrl = import.meta.env.VITE_SERVER_URL;

export default {
  async mounted() {
    const albumStore = useAlbumStore();
    albumStore.getAlbums();
  },
  components: { AlbumFormVue },
  data: () => ({
    serverUrl,
    imgUrlFor,
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
    async createAlbum(album) {
      const albumStore = useAlbumStore();
      if (album.cover != null) {
        const form = new FormData();
        form.append("image", album.cover);
        let res = await axios.post(
          `/api/uploads/image`,
          form,
          {
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${this.token}`,
              "x-access-token": this.token,
            },
          }
        );
        album.cover = res.data.data.name;
      }

      try {
        axios
          .post(`/api/albums`, album, {
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${this.token}`,
              "x-access-token": this.token,
            },
          })
          .then((res) => {
            albumStore.addAlbum(res.data);
            createToast("Succeed add album", { type: "success" })
          });
      } catch (error) {
        console.error("Create album", error);
      }
    },

    async deleteAlbum(id) {
      if (!confirm("Are you sure delete this album?"))
        return;
      const albumStore = useAlbumStore();
      try {
        await albumStore.delete(id)
        createToast("Succeed delete album", { type: "success" })
      }
      catch (error) {
        console.error("Remove photobook", error);
      }
    },
    async toggleFavorite(id) {
      const albumStore = useAlbumStore();
      try {
        await albumStore.toggleFavorite(id)
      }
      catch (error) {
        console.error("Remove photobook", error);
      }
    },
    albumAsString(album) {
      const { name } = album;
      return [name].join('').toLowerCase();
    },
  },
  computed: {
    ...mapState(useAuthStore, ["user"]),
    ...mapState(useAuthStore, ["token"]),
    ...mapState(useAlbumStore, ["albums"]),
    filteredAlbums() {
      const searchText = this.$route.query["q"]?.toLowerCase()
      if (!searchText) return this.albums;
      return this.albums.filter((album) =>
        this.albumAsString(album).includes(searchText)
      );
    },
  },
};
</script>