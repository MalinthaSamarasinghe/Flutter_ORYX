<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * Display all product on the home page.
     */
    public function index()
    {
        // Fetch all product for the home page
        $products = Product::all();

        // Return the 'home' view with the product
        return view('home', compact('products'));
    }

    /**
     * Display the welcome page with 3 random product.
     */
    public function welcome()
    {
        // Fetch 3 random product for the welcome page
        $products = Product::inRandomOrder()->take(3)->get();

        // Return the 'welcome' view with the product
        return view('welcome', compact('products'));
    }
    public function show($id)
    {
        // Fetch the current product
        $product = Product::findOrFail($id);

        // Fetch 3 random products (excluding the current product)
        $moreProducts = Product::where('id', '!=', $product->id)
            ->inRandomOrder()
            ->take(3)
            ->get();

        // Return the individual product view with both the current product and the random products
        return view('product.show', compact('product', 'moreProducts'));
    }

}
