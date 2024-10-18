<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    /**
     * Display the admin dashboard.
     */
    public function index()
    {
        $products = Product::all();
        $users = User::all();
        return view('admin.dashboard', compact('products', 'users'));
    }

    /**
     * Show the form to create a new product.
     */
    public function createProduct()
    {
        return view('admin.create-product');
    }

    /**
     * Store a newly created product.
     */
    public function storeProduct(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'description' => 'required',
            'price' => 'required|numeric',
            'stock' => 'required|integer',
            'image' => 'required|image',
        ]);

        $imagePath = $request->file('image')->store('products', 'public');

        Product::create([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'stock' => $request->stock,
            'image' => $imagePath,
        ]);

        return redirect()->route('admin.dashboard')->with('success', 'Product added successfully.');
    }

    /**
     * Delete a product.
     */
    public function deleteProduct($id)
    {
        Product::findOrFail($id)->delete();
        return redirect()->back()->with('success', 'Product deleted successfully.');
    }

    /**
     * View all users.
     */
    public function viewUsers()
    {
        $users = User::all();
        return view('admin.view-users', compact('users'));
    }
}
