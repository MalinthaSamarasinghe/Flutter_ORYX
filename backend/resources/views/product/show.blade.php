<!-- resources/views/product/show.blade.php -->
@extends('layouts.app')

@section('title', $product->name)

@section('content')
    <x-navbar></x-navbar>
    <div class="container mx-auto px-4 py-12">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
            <!-- Product Image -->
            <div class="flex justify-center">
                <img src="{{ asset('storage/' . $product->image) }}" alt="{{ $product->name }}" class="w-full h-96 object-cover rounded-lg shadow-lg">
            </div>

            <!-- Product Details -->
            <div class="flex flex-col justify-between">
                <!-- Product Name and Description -->
                <div>
                    <h1 class="text-4xl font-extrabold text-gray-100 mb-4">{{ $product->name }}</h1>
                    <p class="text-gray-400 mb-6">{{ $product->description }}</p>

                    <!-- Price -->
                    <p class="text-green-400 font-semibold text-2xl mb-2">${{ number_format($product->price, 2) }}</p>

                    <!-- Stock Information -->
                    <p class="text-sm text-gray-500 mb-6">In Stock: {{ $product->stock }}</p>

                    <!-- Hardcoded Product Rating -->
                    <div class="flex items-center mb-6">
                        <span class="text-yellow-400 text-xl">&#9733;</span>
                        <span class="text-yellow-400 text-xl">&#9733;</span>
                        <span class="text-yellow-400 text-xl">&#9733;</span>
                        <span class="text-yellow-400 text-xl">&#9733;</span>
                        <span class="text-gray-400 text-xl">&#9733;</span>
                        <p class="ml-2 text-sm text-gray-400">(4/5 Ratings)</p>
                    </div>
                </div>

                <!-- Add to Cart Button -->
                <div>
                    <form action="{{ route('cart.add', $product->id) }}" method="POST">
                        @csrf
                        <button class="w-full md:w-auto px-6 py-3 bg-pink-500 text-white font-semibold rounded-lg hover:bg-pink-600 transition focus:outline-none focus:ring-2 focus:ring-pink-400">
                            Add to Cart
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- More Products Section -->
        <div class="mt-12">
            <h2 class="text-3xl font-bold text-gray-100 mb-6">More Products</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                @forelse($moreProducts as $moreProduct)
                    <x-product-card :product="$moreProduct" />
                @empty
                    <p class="text-gray-400 col-span-full">No more products available.</p>
                @endforelse
            </div>
        </div>
    </div>
@endsection
