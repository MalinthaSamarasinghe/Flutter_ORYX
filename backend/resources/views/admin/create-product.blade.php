<!-- resources/views/admin/create-product.blade.php -->
@extends('layouts.app')

@section('title', 'Add New Product')

@section('content')
    <x-navbar></x-navbar>
    <div class="container mx-auto px-4 py-12">
        <div class="max-w-2xl mx-auto bg-gray-800 p-8 rounded-lg shadow-lg">
            <h1 class="text-4xl font-extrabold text-gray-100 mb-8 text-center">Add New Product</h1>

            <form action="{{ route('admin.products.store') }}" method="POST" enctype="multipart/form-data">
                @csrf

                <!-- Product Name -->
                <div class="mb-6">
                    <label for="name" class="block text-sm font-medium text-gray-400 mb-2">Product Name</label>
                    <input type="text" id="name" name="name" class="w-full p-3 bg-gray-700 text-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 transition" placeholder="Enter product name" required>
                </div>

                <!-- Product Description -->
                <div class="mb-6">
                    <label for="description" class="block text-sm font-medium text-gray-400 mb-2">Description</label>
                    <textarea id="description" name="description" rows="5" class="w-full p-3 bg-gray-700 text-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 transition" placeholder="Enter product description" required></textarea>
                </div>

                <!-- Price -->
                <div class="mb-6">
                    <label for="price" class="block text-sm font-medium text-gray-400 mb-2">Price ($)</label>
                    <input type="number" step="0.01" id="price" name="price" class="w-full p-3 bg-gray-700 text-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 transition" placeholder="Enter product price" required>
                </div>

                <!-- Stock -->
                <div class="mb-6">
                    <label for="stock" class="block text-sm font-medium text-gray-400 mb-2">Stock Quantity</label>
                    <input type="number" id="stock" name="stock" class="w-full p-3 bg-gray-700 text-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 transition" placeholder="Enter stock quantity" required>
                </div>

                <!-- Product Image -->
                <div class="mb-6">
                    <label for="image" class="block text-sm font-medium text-gray-400 mb-2">Product Image</label>
                    <input type="file" id="image" name="image" class="w-full p-3 bg-gray-700 text-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-pink-500 transition" required>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="px-6 py-3 bg-pink-500 text-white font-semibold rounded-lg hover:bg-pink-600 transition focus:outline-none focus:ring-2 focus:ring-pink-400">
                        Add Product
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
