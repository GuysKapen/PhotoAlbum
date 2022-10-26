<script setup>
import { imgUrlFor } from "@/utils/utils"
const serverUrl = import.meta.env.VITE_SERVER_URL
</script>
<template>
  <div class="mx-auto w-9/12 my-16">
    <vue-flex-waterfall class="w-9/12 mx-auto" :col="4" :col-spacing="15" :break-at="4"
      :break-by-container="true" style="align-content: center;">
      <div class="mb-4 w-1/3" v-for="(photobook, index) in photobooks" :key="index">
        <div class="flex flex-col">
          <div class="flex-shrink-0">
            <img :src="imgUrlFor(serverUrl, photobook.cover)" alt="book" class="rounded-md w-full h-auto" />
          </div>
          <div class="">
            <h3 class="text-gray-800 font-medium text-base">{{ photobook.name }}</h3>
            <p class="text-gray-600 text-sm">{{photobook.owner}}</p>
          </div>
        </div>
      </div>
    </vue-flex-waterfall>
  </div>
</template>

<script>
import { VueFlexWaterfall } from 'vue-flex-waterfall';

import axios from 'axios';
export default {
  components: {
    VueFlexWaterfall,
  },
  data: () => ({ photobooks: [] }),
  async mounted() {
    const res = await axios.get(`/api/photobooks`)
    this.photobooks = res.data
  }
}
</script>
