<template>
    <div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full space-y-8">
            <div>
                <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                    Войти в аккаунт
                </h2>
            </div>
            <form class="mt-8 space-y-6" @submit.prevent="login">
                <div class="rounded-md shadow-sm -space-y-px">
                    <div>
                        <label for="email" class="sr-only">Email</label>
                        <input id="email" name="email" type="email" required
                               v-model="form.email"
                               class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                               placeholder="Email">
                    </div>
                    <div>
                        <label for="password" class="sr-only">Пароль</label>
                        <input id="password" name="password" type="password" required
                               v-model="form.password"
                               class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                               placeholder="Пароль">
                    </div>
                </div>

                <div>
                    <button type="submit"
                            class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Войти
                    </button>
                </div>

                <div class="text-center">
                    <router-link to="/register" class="text-indigo-600 hover:text-indigo-500">
                        Нет аккаунта? Зарегистрироваться
                    </router-link>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: 'LoginForm',
    data() {
        return {
            form: {
                email: '',
                password: ''
            }
        }
    },
    methods: {
        async login() {
            try {
                const response = await axios.post('/login', this.form);
                // Laravel автоматически перенаправляет после успешного входа
                localStorage.setItem('auth', 'true');
                this.$router.push('/home');
            } catch (error) {
                console.error('Ошибка входа:', error);
                if (error.response && error.response.data && error.response.data.errors) {
                    // Тут ошибки валидации
                    const errors = error.response.data.errors;
                    const errorMessages = Object.values(errors).flat().join('\n');
                    alert('Ошибки валидации:\n' + errorMessages);
                } else {
                    alert('Ошибка входа. Проверьте email и пароль.');
                }
            }
        }
    }
}
</script>
