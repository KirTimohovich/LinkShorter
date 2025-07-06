<template>
  <div class="app-container">
    <div class="background"></div>
    <div class="content">
      <div class="card">
        <div class="title">Сервис сокращения ссылок</div>
        <form class="shorten-form" @submit.prevent="shortenUrl">
          <div class="input-group">
            <input
              v-model="url"
              class="url-input"
              type="text"
              placeholder="Вставьте длинную ссылку..."
              autocomplete="off"
            />
            <button class="submit-btn" :disabled="isLoading">
              <i class="fa-solid fa-link fa-fw"></i>
              {{ isLoading ? 'Сокращение...' : 'Сократить' }}
            </button>
          </div>
        </form>
        <transition name="fade">
          <div v-if="error" class="error-box">
            <i class="fa-solid fa-circle-exclamation"></i>
            <span>{{ error }}</span>
          </div>
        </transition>
        <transition name="fade">
          <div v-if="shortUrl" class="result-box">
            <div class="result-content">
              <div class="result-text">Ваша короткая ссылка:</div>
              <a :href="shortUrl" target="_blank" class="result-link">{{ shortUrl }}</a>
            </div>
            <button class="copy-btn" @click="copyToClipboard(shortUrl)">
              <i class="fa-solid fa-copy"></i> Копировать
            </button>
          </div>
        </transition>
        <div class="links-header" v-if="links.length">
          <span class="links-title">Ваши ссылки</span>
          <button class="clear-btn" @click="clearLinks">
            <i class="fa-solid fa-trash"></i> Очистить все
          </button>
        </div>
        <transition-group name="list-fade" tag="div" class="links-list" v-if="links.length">
          <div v-for="link in links" :key="link.id" class="link-item">
            <div class="link-row">
              <a
                :href="link.original_url"
                class="original-link"
                target="_blank"
                :title="link.original_url"
              >
                {{ link.original_url }}
              </a>
              <button class="short-link-btn" @click="copyToClipboard(fullShortUrl(link.short_url))">
                <i class="fa-solid fa-copy"></i>
                <span class="short-link-text">{{ link.short_url }}</span>
              </button>
            </div>
            <div class="link-row link-meta">
              <span class="clicks-count"><i class="fa-solid fa-mouse-pointer"></i> {{ link.clicks }}</span>
            </div>
          </div>
        </transition-group>
      </div>
      <transition name="fade">
        <div v-if="showCopiedToast" class="toast-notification">
          <i class="fa-solid fa-check-circle"></i>
          <span>Ссылка скопирована!</span>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      url: '',
      shortUrl: '',
      error: '',
      isLoading: false,
      links: [],
      showCopiedToast: false
    };
  },
  mounted() {
    this.fetchLinks();
  },
  methods: {
    async shortenUrl() {
      if (!this.url.trim()) {
        this.error = 'Пожалуйста, введите URL';
        return;
      }
      this.isLoading = true;
      this.error = '';
      this.shortUrl = '';
      try {
        const response = await axios.post('/shorten', { url: this.url });
        this.shortUrl = response.data.shortUrl;
        this.url = '';
        this.fetchLinks();
      } catch (error) {
        if (error.response) {
          if (error.response.status === 419) {
            this.error = 'Ошибка CSRF токена. Обновите страницу.';
          } else if (error.response.status === 401) {
            this.error = 'Необходима авторизация. Войдите в систему.';
            window.location.href = '/login';
          } else if (error.response.status === 422) {
            const errors = error.response.data.errors;
            if (errors && errors.url) {
              this.error = errors.url[0];
            } else {
              this.error = 'Неверный формат URL';
            }
          } else {
            this.error = 'Произошла ошибка при сокращении ссылки';
          }
        } else {
          this.error = 'Ошибка сети. Проверьте подключение к интернету.';
        }
      } finally {
        this.isLoading = false;
      }
    },
    async fetchLinks() {
      try {
        const response = await axios.get('/links');
        this.links = response.data;
      } catch (e) {
        this.links = [];
      }
    },
    async clearLinks() {
      if (!confirm('Вы уверены, что хотите удалить все ссылки?')) return;
      try {
        await axios.delete('/links');
        this.links = [];
      } catch (e) {
        this.error = 'Не удалось очистить список ссылок';
      }
    },
    async copyToClipboard(text) {
      try {
        await navigator.clipboard.writeText(text);
        this.showCopiedToast = true;
        setTimeout(() => (this.showCopiedToast = false), 2000);
      } catch (err) {
        alert('Не удалось скопировать ссылку');
      }
    },
    fullShortUrl(short) {
      return `${window.location.origin}/${short}`;
    }
  }
};
</script>

