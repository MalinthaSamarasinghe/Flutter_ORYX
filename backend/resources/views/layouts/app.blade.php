<!-- resources/views/layouts/app.blade.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'ORYX - Makeup for Every Beauty')</title>
    <link rel="icon" href="{{ asset('images/logo.webp') }}">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        html {
            font-family: 'Inter', sans-serif;
        }
        /* Enable dark mode by default */
        html {
            color-scheme: dark;
        }
    </style>
    <script>
        // Enable dark mode with Tailwind's dark variant
        tailwind.config = {
            darkMode: 'class',
        };
    </script>
</head>
<body class="dark bg-gray-900 text-gray-100 antialiased min-h-screen flex flex-col">

<!-- Navbar Component -->

<!-- Page Content -->
<main class="flex-grow">
    @yield('content')
</main>

<!-- Footer -->
<footer class="py-8 bg-gray-900 text-gray-400 text-center">
    <p>&copy; 2024 ORYX. All rights reserved.</p>
</footer>

</body>
</html>
