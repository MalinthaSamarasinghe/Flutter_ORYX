<!-- resources/views/auth/register.blade.php -->
@extends('layouts.app')

@section('title', 'Register')

@section('content')
    <div class="flex justify-center items-center min-h-screen">
        <div class="w-full max-w-md p-8 bg-gray-800 rounded-2xl shadow-xl">
            <h2 class="text-3xl font-extrabold text-gray-100 text-center mb-6">Register</h2>
            <form action="{{ route('register') }}" method="POST">
                @csrf
                <div class="mb-6">
                    <label for="name" class="block text-sm font-medium text-gray-300 mb-2">Name</label>
                    <input type="text" name="name" class="w-full p-3 border border-gray-700 bg-gray-700 text-gray-300 rounded-lg" required>
                </div>
                <div class="mb-6">
                    <label for="email" class="block text-sm font-medium text-gray-300 mb-2">Email</label>
                    <input type="email" name="email" class="w-full p-3 border border-gray-700 bg-gray-700 text-gray-300 rounded-lg" required>
                </div>
                <div class="mb-6">
                    <label for="password" class="block text-sm font-medium text-gray-300 mb-2">Password</label>
                    <input type="password" name="password" class="w-full p-3 border border-gray-700 bg-gray-700 text-gray-300 rounded-lg" required>
                </div>
                <div class="mb-6">
                    <label for="password_confirmation" class="block text-sm font-medium text-gray-300 mb-2">Confirm Password</label>
                    <input type="password" name="password_confirmation" class="w-full p-3 border border-gray-700 bg-gray-700 text-gray-300 rounded-lg" required>
                </div>
                <button type="submit" class="w-full p-3 bg-pink-500 text-white font-semibold rounded-lg hover:bg-pink-600">Register</button>
            </form>

            @if ($errors->any())
                <div class="mt-6 p-4 bg-red-900 text-red-400 rounded-lg">
                    <ul class="list-disc pl-5 space-y-1">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <div class="mt-6 text-center">
                <p class="text-sm text-gray-400">Already have an account? <a href="{{ route('login') }}" class="text-pink-500 hover:text-pink-400">Login</a></p>
            </div>
        </div>
    </div>
@endsection
