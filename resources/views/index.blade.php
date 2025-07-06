<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Сокращение URL</title>

    <!-- Custom Styles -->
    <link rel="stylesheet" href="{{ asset('css/url-shortener.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          onerror="this.onerror=null;loadFontAwesome()">

    <!-- Если не прогрузятся шрифты -->
    <script>
        function loadFontAwesome() {
            const fa = document.createElement('link');
            fa.rel = 'stylesheet';
            fa.href = 'https://use.fontawesome.com/releases/v6.4.2/css/all.css';
            document.head.appendChild(fa);
        }
    </script>

    @vite(['resources/sass/app.scss', 'resources/js/app.js'])
</head>
<body>
<div id="app"></div>

<!-- Если не прогрузятся иконки -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (!document.querySelector('.fa-copy')) {
            console.warn('FontAwesome не загрузился, включаем fallback');
            const style = document.createElement('style');
            style.textContent = `
                .fa-copy:before { content: "📋"; font-family: sans-serif; }
                .fa-trash-alt:before { content: "🗑"; font-family: sans-serif; }
                .fa-arrow-right:before { content: "→"; font-family: sans-serif; }
                .fa-check-circle:before { content: "✓"; font-family: sans-serif; }
                .fa-exclamation-circle:before { content: "!"; font-family: sans-serif; }
            `;
            document.head.appendChild(style);
        }
    });
</script>
</body>
</html>
