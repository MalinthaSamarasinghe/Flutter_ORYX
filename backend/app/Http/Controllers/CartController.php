<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class CartController extends Controller
{
    /**
     * Display the cart items.
     */
    public function index()
    {
        $cart = session()->get('cart', []); // Retrieve cart from session
        $totalPrice = array_reduce($cart, function($carry, $item) {
            return $carry + ($item['price'] * $item['quantity']);
        }, 0);

        return view('cart.index', compact('cart', 'totalPrice'));
    }

    /**
     * Add product to cart.
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

        session()->put('cart', $cart); // Save cart back to session

        return redirect()->back()->with('success', 'Product added to cart!');
    }

    /**
     * Remove product from cart.
     */
    public function remove($id)
    {
        $cart = session()->get('cart', []);

        if (isset($cart[$id])) {
            unset($cart[$id]);
            session()->put('cart', $cart);
        }

        return redirect()->back()->with('success', 'Product removed from cart!');
    }

    /**
     * Clear the entire cart.
     */
    public function clear()
    {
        session()->forget('cart');

        return redirect()->back()->with('success', 'Cart cleared successfully!');
    }
}
