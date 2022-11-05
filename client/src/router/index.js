import { createRouter, createWebHistory } from "vue-router";
import HomeView from "@/views/HomeView.vue";
import SignUpView from "@/views/SignUpView.vue";
import LoginView from "@/views/LoginView.vue";
import AlbumsView from "@/views/AlbumsView.vue";
import PhotobooksView from "@/views/PhotobooksView.vue";
import AlbumDetailPage from "@/views/AlbumDetailPage.vue";
import PhotobookDetailPageVue from "@/views/PhotobookDetailPage.vue";
import EditPhotobookViewVue from "@/views/EditPhotobookView.vue";
import EditAlbumViewVue from "@/views/EditAlbumView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/signup",
      name: "signup",
      component: SignUpView,
    },
    {
      path: "/signin",
      name: "signin",
      component: LoginView,
    },
    {
      path: "/albums/:id",
      name: "album-detail",
      component: AlbumDetailPage,
    },
    {
      path: "/albums/:id/edit",
      name: "album-edit",
      component: EditAlbumViewVue,
    },
    {
      path: "/albums",
      name: "albums",
      component: AlbumsView,
    },
    {
      path: "/photobooks",
      name: "photobooks",
      component: PhotobooksView,
    },
    {
      path: "/photobooks/:id",
      name: "photobook-detail",
      component: PhotobookDetailPageVue,
    },
    {
      path: "/photobooks/:id/edit",
      name: "photobook-edit",
      component: EditPhotobookViewVue,
    },
  ],
});

export default router;
