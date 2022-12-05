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
import { useAuthStore } from "@/stores/auth/auth"
import { createToast } from "mosha-vue-toastify";

function isAuth() {
  const authStore = useAuthStore();
  if (authStore.token == null || authStore.user == null) {
    createToast("Please login to continue", { type: "info" });
    return { name: 'signin' };
  }
  return true;
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
      meta: {
        title: 'Photobook | Home',
        metaTags: [
          {
            name: 'description',
            content: 'The home page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The home page of photobook.'
          }
        ]
      }
    },
    {
      path: "/signup",
      name: "signup",
      component: SignUpView,
      meta: {
        title: 'Photobook | Signup',
        metaTags: [
          {
            name: 'description',
            content: 'The signup page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The signup page of photobook.'
          }
        ]
      }
    },
    {
      path: "/signin",
      name: "signin",
      component: LoginView,
      meta: {
        title: 'Photobook | Signin',
        metaTags: [
          {
            name: 'description',
            content: 'The sign in page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The signin page of photobook.'
          }
        ]
      }
    },
    {
      path: "/albums/:id",
      name: "album-detail",
      beforeEnter: [isAuth],
      component: AlbumDetailPage,
      meta: {
        title: 'Photobook | Album',
        metaTags: [
          {
            name: 'description',
            content: 'The album page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The album page of photobook.'
          }
        ]
      }
    },
    {
      path: "/albums/:id/edit",
      name: "album-edit",
      beforeEnter: [isAuth],
      component: EditAlbumViewVue,
      meta: {
        title: 'Photobook | Edit Album',
        metaTags: [
          {
            name: 'description',
            content: 'The edit album page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The edit album page of photobook.'
          }
        ]
      }
    },
    {
      path: "/albums",
      name: "albums",
      beforeEnter: [isAuth],
      component: AlbumsView,
      meta: {
        title: 'Photobook | Albums',
        metaTags: [
          {
            name: 'description',
            content: 'The albums page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The albums page of photobook.'
          }
        ]
      }
    },
    {
      path: "/photobooks",
      name: "photobooks",
      beforeEnter: [isAuth],
      component: PhotobooksView,
      meta: {
        title: 'Photobook | Photobooks',
        metaTags: [
          {
            name: 'description',
            content: 'The photobooks page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The photobooks page of photobook.'
          }
        ]
      }
    },
    {
      path: "/photobooks/:id",
      name: "photobook-detail",
      component: PhotobookDetailPageVue,
      meta: {
        title: 'Photobook | Detail',
        metaTags: [
          {
            name: 'description',
            content: 'The photobook page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The photobook page of photobook.'
          }
        ]
      }
    },
    {
      path: "/photobooks/:id/edit",
      name: "photobook-edit",
      beforeEnter: [isAuth],
      component: EditPhotobookViewVue,
      meta: {
        title: 'Photobook | Edit',
        metaTags: [
          {
            name: 'description',
            content: 'The edit photobook page of photobook.'
          },
          {
            property: 'og:description',
            content: 'The edit photobook page of photobook.'
          }
        ]
      }
    },
  ],
});

// This callback runs before every route change, including on page load.
router.beforeEach((to, from, next) => {
  // This goes through the matched routes from last to first, finding the closest route with a title.
  // e.g., if we have `/some/deep/nested/route` and `/some`, `/deep`, and `/nested` have titles,
  // `/nested`'s will be chosen.
  const nearestWithTitle = to.matched.slice().reverse().find(r => r.meta && r.meta.title);

  // Find the nearest route element with meta tags.
  const nearestWithMeta = to.matched.slice().reverse().find(r => r.meta && r.meta.metaTags);

  const previousNearestWithMeta = from.matched.slice().reverse().find(r => r.meta && r.meta.metaTags);

  // If a route with a title was found, set the document (page) title to that value.
  if (nearestWithTitle) {
    document.title = nearestWithTitle.meta.title;
  } else if (previousNearestWithMeta) {
    document.title = previousNearestWithMeta.meta.title;
  }

  // Remove any stale meta tags from the document using the key attribute we set below.
  Array.from(document.querySelectorAll('[data-vue-router-controlled]')).map(el => el.parentNode.removeChild(el));

  // Skip rendering meta tags if there are none.
  if (!nearestWithMeta) return next();

  // Turn the meta tag definitions into actual elements in the head.
  nearestWithMeta.meta.metaTags.map(tagDef => {
    const tag = document.createElement('meta');

    Object.keys(tagDef).forEach(key => {
      tag.setAttribute(key, tagDef[key]);
    });

    // We use this to track which meta tags we create so we don't interfere with other ones.
    tag.setAttribute('data-vue-router-controlled', '');

    return tag;
  })
    // Add the meta tags to the document head.
    .forEach(tag => document.head.appendChild(tag));

  next();
});

export default router;
