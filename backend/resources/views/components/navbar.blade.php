<!-- resources/views/components/navbar.blade.php -->
<nav class="w-full bg-gray-800 p-6 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <!-- Left: Brand Name -->
        <a href="{{ url('/home') }}" class="text-3xl font-bold text-pink-500">ORYX</a>

        <!-- Right: Dropdown for User's name and Cart -->
        <div class="relative flex items-center space-x-4">
            @auth
                <!-- Dropdown Trigger (User's name) -->
                <div class="relative">
                    <button onclick="toggleDropdown()" class="flex items-center text-lg text-gray-300 focus:outline-none">
                        Hello, {{ Auth::user()->name }}
                        <svg class="ml-2 h-5 w-5 text-gray-300" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
                        </svg>
                    </button>

                    <!-- Dropdown Menu -->
                    <div id="dropdownMenu" class="hidden absolute right-0 mt-2 w-48 bg-gray-700 text-white rounded-lg shadow-lg">
                        <a href="{{ url('/cart') }}" class="block px-4 py-2 hover:bg-gray-600">View Cart</a>

                        @if(Auth::user()->role === 'admin')
                            <!-- Admin Panel Link -->
                            <a href="{{ url('/admin') }}" class="block px-4 py-2 hover:bg-gray-600">Admin Panel</a>
                        @endif

                        <form action="{{ route('logout') }}" method="POST" class="block">
                            @csrf
                            <button type="submit" class="w-full text-left px-4 py-2 hover:bg-gray-600">Logout</button>
                        </form>
                    </div>
                </div>
            @else
                <a href="{{ route('login') }}" class="px-6 py-3 bg-gray-700 text-white rounded-lg font-semibold hover:bg-gray-600 transition">Log in</a>
                <a href="{{ route('register') }}" class="px-6 py-3 bg-pink-500 text-white rounded-lg font-semibold hover:bg-pink-600 transition">Register</a>
            @endauth
        </div>
    </div>
</nav>

<script>
    // Toggle dropdown menu visibility
    function toggleDropdown() {
        var dropdown = document.getElementById('dropdownMenu');
        dropdown.classList.toggle('hidden');
    }

    // Close dropdown if clicked outside
    window.onclick = function(event) {
        if (!event.target.matches('.flex.items-center')) {
            var dropdown = document.getElementById('dropdownMenu');
            if (!dropdown.classList.contains('hidden')) {
                dropdown.classList.add('hidden');
            }
        }
    }
</script>
