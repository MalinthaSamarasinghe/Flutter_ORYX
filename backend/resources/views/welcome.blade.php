<!-- resources/views/welcome.blade.php -->
@extends('layouts.app')

@section('title', 'Welcome')

@section('content')
    <header class="relative">
        <div class="absolute inset-0 bg-black opacity-50 z-0"></div>
        <img src="{{ asset('images/banner.webp') }}" alt="ORYX Banner" class="w-full h-screen object-cover z-0">
        <div class="absolute inset-0 flex flex-col justify-center items-center text-center z-10">
            <h1 class="text-6xl font-extrabold text-white mb-4">Welcome to ORYX</h1>
            <p class="text-lg text-gray-200 mb-8">Beauty that Empowers Every Woman</p>

            <!-- Display Login and Register Buttons -->
            <div class="space-x-4">
                @if (Route::has('login'))
                    @auth
                        <!-- If logged in, show the Home button -->
                        <a href="{{ url('/home') }}" class="px-6 py-3 bg-pink-500 text-white rounded-lg font-semibold text-lg hover:bg-pink-600 transition">Home</a>
                    @else
                        <!-- If not logged in, show Login and Register buttons -->
                        <a href="{{ route('login') }}" class="px-6 py-3 bg-gray-700 text-white rounded-lg font-semibold text-lg hover:bg-gray-600 transition">Log in</a>

                        @if (Route::has('register'))
                            <a href="{{ route('register') }}" class="px-6 py-3 bg-pink-500 text-white rounded-lg font-semibold text-lg hover:bg-pink-600 transition">Register</a>
                        @endif
                    @endauth
                @endif
            </div>
        </div>
    </header>

    <!-- Best-Selling Products Section -->
    <section id="products" class="py-16 px-6 bg-gray-900">
        <div class="max-w-6xl mx-auto text-center">
            <h2 class="text-4xl font-bold mb-8">Our Best-Selling Products</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                @forelse($products as $product)
                    <x-product-card :product="$product" />
                @empty
                    <p class="text-gray-400 col-span-full">No products available.</p>
                @endforelse
            </div>
        </div>
    </section>
@endsection
