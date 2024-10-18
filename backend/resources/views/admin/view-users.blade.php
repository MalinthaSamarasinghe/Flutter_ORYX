<!-- resources/views/admin/view-users.blade.php -->
@extends('layouts.app')

@section('title', 'View Users')

@section('content')
    <div class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-bold text-gray-100 mb-8">Users</h1>

        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
            <ul>
                @foreach($users as $user)
                    <li class="text-gray-100">{{ $user->name }} - {{ $user->email }} ({{ ucfirst($user->role) }})</li>
                @endforeach
            </ul>
        </div>
    </div>
@endsection
