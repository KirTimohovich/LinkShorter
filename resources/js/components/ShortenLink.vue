<template>
    <div>
        <h1>Сокращение ссылки</h1>
        <input v-model="url" placeholder="Введите длинную ссылку" />
        <button @click="shortenUrl">Сократить</button>
        <p v-if="shortUrl">Короткая ссылка: <a :href="shortUrl">{{ shortUrl }}</a></p>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            url: '',
            shortUrl: ''
        };
    },
    methods: {
        async shortenUrl() {
            try {
                const response = await axios.post('/api/shorten', { url: this.url });
                this.shortUrl = `${window.location.origin}/${response.data.short_url}`;
            } catch (error) {
                console.error('Ошибка:', error.response.data); // Выводим данные ошибки
                alert('Не удалось сократить ссылку. Проверьте правильность URL.');
            }
        }
    }
};
</script>

