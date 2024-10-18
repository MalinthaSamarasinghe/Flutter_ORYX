<!-- resources/views/components/product-card.blade.php -->
<div class="bg-gray-800 p-6 rounded-lg shadow-lg hover:scale-105 transform transition-all">
    <img src="{{ asset('storage/' . $product->image) }}" alt="{{ $product->name }}" class="w-full h-48 object-cover mb-4 rounded">
    <h3 class="text-xl font-bold text-gray-100">{{ $product->name }}</h3>

    <!-- Truncate the product description to show only a few lines -->
    <p class="text-gray-400 mt-2 line-clamp-3">
        {{ $product->description }}
    </p>

    <p class="text-green-400 font-semibold mt-4">${{ number_format($product->price, 2) }}</p>
    <p class="text-sm text-gray-500">In Stock: {{ $product->stock }}</p>
    <a href="{{ route('product.show', $product->id) }}" class="text-pink-500 hover:text-pink-600">View Product</a>
</div>
