<!-- resources/views/cart/index.blade.php -->
@extends('layouts.app')

@section('title', 'Your Cart')

@section('content')
    <x-navbar></x-navbar>
    <div class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-extrabold text-gray-100 mb-8">Shopping Cart</h1>

        <!-- Display success messages -->
        @if(session('success'))
            <div class="mb-6 p-4 bg-green-500 text-white rounded-lg">
                {{ session('success') }}
            </div>
        @endif

        @if(count($cart) > 0)
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Cart Items List -->
                <div class="lg:col-span-2 space-y-6">
                    @foreach($cart as $id => $item)
                        <div class="bg-gray-800 p-6 rounded-lg shadow-lg flex flex-col lg:flex-row lg:space-x-6">
                            <img src="{{ asset('storage/' . $item['image']) }}" alt="{{ $item['name'] }}" class="w-full lg:w-48 h-48 object-cover mb-4 lg:mb-0 rounded">
                            <div class="flex-1">
                                <h3 class="text-2xl font-bold text-gray-100">{{ $item['name'] }}</h3>
                                <p class="text-green-400 font-semibold mt-4">${{ number_format($item['price'], 2) }}</p>
                                <p class="text-sm text-gray-500 mt-2">Quantity: {{ $item['quantity'] }}</p>

                                <!-- Remove from cart button -->
                                <form action="{{ route('cart.remove', $id) }}" method="POST" class="mt-4">
                                    @csrf
                                    <button type="submit" class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600 transition">
                                        Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                    @endforeach
                </div>

                <!-- Cart Summary -->
                <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
                    <h2 class="text-2xl font-bold text-gray-100 mb-4">Order Summary</h2>
                    <div class="flex justify-between items-center mb-4">
                        <p class="text-gray-400">Subtotal</p>
                        <p class="text-gray-100">${{ number_format($totalPrice, 2) }}</p>
                    </div>
                    <div class="flex justify-between items-center mb-4">
                        <p class="text-gray-400">Shipping</p>
                        <p class="text-gray-100">$10.00</p> <!-- Example shipping fee -->
                    </div>
                    <div class="flex justify-between items-center border-t border-gray-700 pt-4">
                        <p class="text-xl font-bold text-gray-100">Total</p>
                        <p class="text-2xl font-bold text-green-400">${{ number_format($totalPrice + 10, 2) }}</p> <!-- Total with shipping -->
                    </div>

                    <!-- Checkout and Clear Cart Buttons -->
                    <div class="mt-6 space-y-4">
                        <form  method="POST">
                            @csrf
                            <button type="submit" class="w-full px-6 py-3 bg-blue-500 text-white font-semibold rounded-lg hover:bg-blue-600 transition">
                                Proceed to Checkout
                            </button>
                        </form>
                        <form action="{{ route('cart.clear') }}" method="POST">
                            @csrf
                            <button type="submit" class="w-full px-6 py-3 bg-pink-500 text-white font-semibold rounded-lg hover:bg-pink-600 transition">
                                Clear Cart
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        @else
            <div class="text-center">
                <p class="text-gray-400 text-lg">Your cart is empty.</p>
                <a href="{{ route('home') }}" class="inline-block mt-6 px-6 py-3 bg-pink-500 text-white font-semibold rounded-lg hover:bg-pink-600 transition">
                    Continue Shopping
                </a>
            </div>
        @endif
    </div>
@endsection
