import { createRouter, createWebHistory } from 'vue-router';
import ShortenLink from '../components/ShortenLink.vue';

const routes = [
    {
        path: '/',
        component: ShortenLink,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
