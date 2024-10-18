<?php

namespace App\Http\Controllers\Api;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CartController extends Controller
{
    /**
     * View the cart items.
     */
    public function index()
    {
        $cart = session()->get('cart', []); // Retrieve cart from session

        $totalPrice = array_reduce($cart, function($carry, $item) {
            return $carry + ($item['price'] * $item['quantity']);
        }, 0);

        return response()->json([
            'cart' => $cart,
            'totalPrice' => $totalPrice
        ], 200);
    }

    /**
     * Add a product to the cart.
     */
    public function add(Request $request, $id)
    {
        $product = Product::findOrFail($id); // Find product by ID

        // Get cart from session, or create an empty array if not present
        $cart = session()->get('cart', []);

        // Check if product already in cart, then update quantity
        if (isset($cart[$id])) {
            $cart[$id]['quantity']++;
        } else {
            // Add product to cart
            $cart[$id] = [
                "name" => $product->name,
                "quantity" => 1,
                "price" => $product->price,
                "image" => $product->image
            ];
        }

        // Save cart back to session
        session()->put('cart', $cart);

        return response()->json([
            'message' => 'Product added to cart successfully!',
            'cart' => $cart
        ], 200);
    }

    /**
     * Remove a product from the cart.
     */
    public function remove($id)
    {
        $cart = session()->get('cart', []);

        if (isset($cart[$id])) {
            unset($cart[$id]);
            session()->put('cart', $cart);
        }

        return response()->json([
            'message' => 'Product removed from cart!',
            'cart' => $cart
        ], 200);
    }

    /**
     * Clear the entire cart.
     */
    public function clear()
    {
        session()->forget('cart');

        return response()->json([
            'message' => 'Cart cleared successfully!',
        ], 200);
    }
}
