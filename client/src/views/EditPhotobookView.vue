<template>
  <div class="px-12 flex flex-row-reverse">
    <div class="w-5/12 my-8 mx-auto" v-if="photobook">
      <h3 class="text-2xl text-gray-700 font-bold mt-4">Edit photobook</h3>
      <PhotobookForm @submit:photobook="updatePhotobook" :photobook="photobook" />
    </div>
  </div>
</template>

<script>
import { usePhotobookStore } from "@/stores/photobooks"
import PhotobookForm from "@/components/PhotobookForm.vue";
import { createToast } from 'mosha-vue-toastify';
import { useAuthStore } from "@/stores/auth/auth";
import { mapState } from "pinia";
import axios from 'axios';

export default {
  async mounted() {
    const photobookStore = usePhotobookStore();
    const photobook = await photobookStore.getPhotbook(this.$route.params.id);
    const pages = await photobookStore.getPages(this.$route.params.id)

    this.photobook = { ...photobook, pages }
  },
  data: () => ({ photobook: null }),
  components: { PhotobookForm },
  methods: {
    async updatePhotobook(photobook) {
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
        photobook.cover = res.data?.data?.name || photobook.cover;
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
          
          page.image = res.data?.data?.name || page.image;
        }
      }

      try {
        let res = await photobookStore.update(this.$route.params.id, photobook)
        createToast("Succeed update photobook", { type: 'success' })
      }
      catch (error) {
        console.error("Create photobook", error);
      }
    },
  },
  computed: {
    ...mapState(useAuthStore, ["user"]),
    ...mapState(useAuthStore, ["token"]),
  },
};
</script>