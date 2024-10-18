<!-- resources/views/admin/dashboard.blade.php -->
@extends('layouts.app')

@section('title', 'Admin Dashboard')

@section('content')
    <x-navbar />
    <div class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-bold text-gray-100 mb-8">Admin Dashboard</h1>

        <!-- Success Message -->
        @if(session('success'))
            <div class="mb-4 p-4 bg-green-500 text-white rounded-lg">
                {{ session('success') }}
            </div>
        @endif

        <!-- Products Section -->
        <div class="mb-8">
            <h2 class="text-3xl font-bold text-gray-100 mb-4">Products</h2>
            <a href="{{ route('admin.products.create') }}" class="bg-pink-500 text-white px-4 py-2 rounded-lg mb-4 inline-block">Add New Product</a>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                @foreach($products as $product)
                    <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
                        <img src="{{ asset('storage/' . $product->image) }}" alt="{{ $product->name }}" class="w-full h-48 object-cover mb-4 rounded">
                        <h3 class="text-xl font-bold text-gray-100">{{ $product->name }}</h3>

                        <!-- Truncate the product description to only show a few lines -->
                        <p class="text-gray-400 mt-2 line-clamp-3">{{ $product->description }}</p>

                        <p class="text-green-400 font-semibold mt-4">${{ number_format($product->price, 2) }}</p>
                        <form action="{{ route('admin.products.delete', $product->id) }}" method="POST" class="mt-4">
                            @csrf
                            <button type="submit" class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600">Delete</button>
                        </form>
                    </div>
                @endforeach
            </div>
        </div>

        <!-- Users Section -->
        <div>
            <h2 class="text-3xl font-bold text-gray-100 mb-4">Users</h2>
            <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
                <ul>
                    @foreach($users as $user)
                        <li class="text-gray-100">{{ $user->name }} - {{ $user->email }} ({{ ucfirst($user->role) }})</li>
                    @endforeach
                </ul>
            </div>
        </div>
    </div>
@endsection
