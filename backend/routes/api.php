<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\CartController;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// API routes for authentication
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

// API routes for products
Route::get('/products', [ProductController::class, 'index']);
Route::get('/products/{id}', [ProductController::class, 'show']);

// Cart API routes
Route::get('/cart', [CartController::class, 'index'])->middleware('auth:sanctum');
Route::post('/cart/add/{id}', [CartController::class, 'add'])->middleware('auth:sanctum');
Route::post('/cart/remove/{id}', [CartController::class, 'remove'])->middleware('auth:sanctum');
Route::post('/cart/clear', [CartController::class, 'clear'])->middleware('auth:sanctum');
