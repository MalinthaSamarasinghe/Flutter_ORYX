<!-- resources/views/home.blade.php -->
@extends('layouts.app')

@section('title', 'Home')

@section('content')
    <x-navbar />
    <div class="container mx-auto px-4 py-10">
        <h2 class="text-4xl font-semibold text-gray-100 mb-6 text-center">Our Products</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            @forelse($products as $product)
                <x-product-card :product="$product" />
            @empty
                <p class="text-gray-400 text-center col-span-full">No products available.</p>
            @endforelse
        </div>
    </div>
@endsection
