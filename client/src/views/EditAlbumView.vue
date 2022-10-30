<template>
  <div class="px-12 flex flex-row-reverse">
    <div class="w-5/12 my-8 mx-auto" v-if="album">
      <h3 class="text-2xl text-gray-700 font-bold mt-4">Edit photobook</h3>
      <AlbumForm @submit:album="update" :album="album" />
    </div>
  </div>
</template>

<script>
import { useAlbumStore } from "@/stores/albums"
import AlbumForm from "@/components/AlbumForm.vue";
import { photobookService } from '@/services/photobook.service';

export default {
  async mounted() {
    const albumStore = useAlbumStore();
    this.album = await albumStore.getAlbum(this.$route.params.id);
  },
  data: () => ({ album: null }),
  components: { AlbumForm },
  methods: {
    
  },
};
</script>