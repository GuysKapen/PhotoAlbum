<template>
  <div class="px-12 flex flex-row-reverse">
    <div class="w-5/12 my-8 mx-auto" v-if="album">
      <h3 class="text-2xl text-gray-700 font-bold mt-4">Edit album</h3>
      <AlbumForm @submit:album="update" :album="album" />
    </div>
  </div>
</template>

<script>
import { useAlbumStore } from "@/stores/albums"
import { useAuthStore } from "@/stores/auth/auth"
import AlbumForm from "@/components/AlbumForm.vue";
import { createToast } from 'mosha-vue-toastify';
import { mapState } from "pinia";
import axios from 'axios';

export default {
  async mounted() {
    const albumStore = useAlbumStore();
    this.album = await albumStore.getAlbum(this.$route.params.id);
  },
  data: () => ({ album: null }),
  components: { AlbumForm },
  methods: {
    async update(album) {
      const albumStore = useAlbumStore();
      if (album.cover != null) {
        const form = new FormData();
        form.append("image", album.cover);
        let res = await axios.post(`/api/uploads/image`, form, {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${this.token}`,
            "x-access-token": this.token,
          },
        });
        album.cover = res.data?.data?.name || album.cover;
      }

      try {
        await albumStore.update(this.$route.params.id, album)
        createToast("Succeed update album", { type: 'success' })
      }
      catch (error) {
        console.error("Update album", error);
      }
    },
  },
  computed: {
    ...mapState(useAuthStore, ["user"]),
    ...mapState(useAuthStore, ["token"]),
  },
};
</script>