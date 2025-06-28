<template>
    <div class="app-container">
        <div class="background"></div>
        <div class="content">
            <div class="card">
                <h1 class="title">Сокращение URL</h1>

                <form @submit.prevent="shortenUrl" class="url-form">
                    <div class="input-group">
                        <input
                            v-model="url"
                            class="url-input"
                            placeholder="Введите длинную ссылку"
                            required
                        />
                        <button type="submit" class="submit-btn">
                            <span>Сократить</span>
                            <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </form>

                <div v-if="shortUrl" class="result-box">
                    <div class="result-content">
                        <p class="result-text">Ваша короткая ссылка:</p>
                        <a :href="shortUrl" target="_blank" class="result-link">{{ shortUrl }}</a>
                    </div>
                    <button @click="copyToClipboard(shortUrl.split('/').pop())" class="copy-btn">
                        <i class="far fa-copy"></i>
                        <span>Копировать</span>
                    </button>
                </div>

                <div v-if="error" class="error-box">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>{{ error }}</span>
                </div>

                <div class="links-header">
                    <h2>Список сокращенных ссылок</h2>
                    <button @click="clearLinks" class="clear-btn" type="button">
                        <i class="fas fa-trash-alt"></i>
                        <span>Очистить</span>
                    </button>
                </div>

                <div class="links-list">
                    <div
                        v-for="link in links"
                        :key="link.short_url"
                        class="link-item"
                    >
                        <a
                            :href="link.original_url"
                            target="_blank"
                            class="original-link"
                            :title="link.original_url"
                        >
                            {{ truncateUrl(link.original_url) }}
                        </a>
                        <button
                            @click="copyToClipboard(link.short_url)"
                            class="short-link-btn"
                        >
                            <span class="short-link-text">{{ link.short_url }}</span>
                            <i class="far fa-copy"></i>
                        </button>
                    </div>
                </div>

                <transition name="fade">
                    <div v-if="showCopiedToast" class="toast-notification">
                        <i class="fas fa-check-circle"></i>
                        <span>Ссылка скопирована в буфер</span>
                    </div>
                </transition>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import { ref, onMounted } from 'vue';

export default {
    name: 'App',
    setup() {
        const url = ref('');
        const shortUrl = ref('');
        const error = ref('');
        const links = ref([]);
        const showCopiedToast = ref(false);

        const truncateUrl = (url) => url.length > 40
            ? `${url.substring(0, 20)}...${url.substring(url.length - 15)}`
            : url;

        const copyToClipboard = async (text) => {
            try {
                await navigator.clipboard.writeText(`${window.location.origin}/${text}`);
                showCopiedToast.value = true;
                setTimeout(() => showCopiedToast.value = false, 2000);
            } catch {
                error.value = 'Не удалось скопировать ссылку';
            }
        };

        const shortenUrl = async () => {
            try {
                const response = await axios.post('/shorten', { url: url.value });
                shortUrl.value = response.data.shortUrl;
                error.value = '';
                fetchLinks();
            } catch {
                error.value = 'Не удалось сократить ссылку. Проверьте URL.';
                shortUrl.value = '';
            }
        };

        const fetchLinks = async () => {
            try {
                const { data } = await axios.get('/links');
                links.value = data;
            } catch (e) {
                console.error('Ошибка получения ссылок:', e);
            }
        };

        const clearLinks = async () => {
            try {
                await axios.delete('/links');
                links.value = [];
            } catch (e) {
                error.value = 'Не удалось очистить список ссылок';
                console.error('Ошибка удаления ссылок:', e);
            }
        };

        onMounted(fetchLinks);

        return {
            url, shortUrl, error, links, showCopiedToast,
            truncateUrl, copyToClipboard, shortenUrl, clearLinks
        };
    },
};
</script>


