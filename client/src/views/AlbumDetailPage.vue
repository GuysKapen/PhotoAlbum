<script setup>
import { imgUrlFor } from "@/utils/utils"
const serverUrl = import.meta.env.VITE_SERVER_URL
</script>
<template>
  <div v-if="album" class="px-8">
    <h3 class="text-2xl text-gray-700 font-bold mt-4">{{album.name}}</h3>
    <div class="mx-auto w-8/12 my-16">
      <vue-flex-waterfall class="mx-auto w-full" :col="5" :col-spacing="15" :break-at="4" :break-by-container="true"
        style="align-content: center;">
        <div class="mb-4 w-1/5" v-for="(photobook, index) in photobooks" :key="index">
          <div class="flex flex-col">
            <router-link :to="{'name': 'photobook-detail', params: {id: photobook.id}}">
              <div class="flex-shrink-0">
                <img :src="imgUrlFor(serverUrl, photobook.cover)" alt="book" class="rounded-md w-full h-auto" />
              </div>
            </router-link>
            <div class="">
              <h3 class="text-gray-800 font-medium text-base">{{ photobook.name }}</h3>
            </div>
          </div>
        </div>
      </vue-flex-waterfall>
    </div>
  </div>
</template>

<script>
import { useAlbumStore } from "@/stores/albums"
import { VueFlexWaterfall } from 'vue-flex-waterfall';

export default {
  components: { VueFlexWaterfall },
  async mounted() {
    this.album = (await useAlbumStore().getAlbum(this.id))

    this.photobooks = (await useAlbumStore().getPhotobooks(this.id))
  },
  data: () => ({
    photobooks: [],
    album: null,
  }),
  methods: {
    async onFileChange(file) {

    },
    async getPhotos() {

    },
  },
  computed: {
    id() {
      return this.$route.params.id;
    },
  },
};
</script>

<style  scoped>
amplify-s3-image {
  --width: 75%;
}
</style>