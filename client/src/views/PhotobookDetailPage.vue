<script setup>
import { imgUrlFor } from "@/utils/utils"
const serverUrl = import.meta.env.VITE_SERVER_URL
</script>
<template>
  <div class="my-16">
    <div class="flex w-9/12 mx-auto">
      <div class="flex-shrink-0 w-5/12">
        <img :src="imgUrlFor(serverUrl, photobook.cover)" alt="book" class="rounded-md w-full h-[24rem] object-cover" />
      </div>
      <div class="ml-8 -mt-2">
        <h2 class="text-5xl font-bold text-gray-800">
          {{photobook.name}}
        </h2>
        <p class="text-sm text-gray-500 mt-2">
          Lorem ipsum dolor, sit amet consectetur adipisicing elit. Natus assumenda esse excepturi.
        </p>
        <h3 class="text-xl mt-3 font-bold text-gray-800">
          Art station
        </h3>
      </div>
    </div>
    <div class="w-9/12 mx-auto mt-32">
      <carousel :items-to-show="3" wrapAround="true">
        <slide v-for="page in pages" :key="page" style="padding: 1rem">
          <div class="w-full relative">
            <img :src="imgUrlFor(serverUrl, page.image)" alt="book" class="rounded-md w-full h-[24rem] object-cover" />
          </div>
          <div class="absolute w-1/2 bottom-12 left-12">
            <p class="text-white text-left">{{page.content}}</p>
          </div>
        </slide>

        <template #addons>
          <navigation />
          <pagination />
        </template>
      </carousel>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel'

export default {
  components: {
    Carousel,
    Slide,
    Pagination,
    Navigation,
  },
  async mounted() {
    const res = await axios.get(`/api/photobooks/${this.id}`)
    this.photobook = res.data

    this.pages = (await axios.get(`/api/photobooks/${this.id}/pages`)).data
    console.log("this", this.pages);
  },
  data: () => ({
    photobook: [],
    pages: []
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