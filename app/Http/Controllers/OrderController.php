<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use Inertia\Response;

class OrderController extends Controller
{
    public function index(): Response
    {
        $orders = Order::with(['orderItems.foodItem','user'])
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($order) {
                // Ensure total is calculated
                $order->total = $order->total;
                return $order;
            }); 
            
        // Debug: let's see what the first order looks like
        // if ($orders->isNotEmpty()) {
        //     Log::info('Order structure:', $orders->first()->toArray());
        // }

        return Inertia::render('Orders/Index', [
            'orders' => $orders
        ]);
    }

    public function confirm($purchaseOrderId): Response
    {
        if (empty($purchaseOrderId)) {
            abort(404);
        }
        clearCart();
        $order = Order::with(['orderItems.foodItem', 'user'])
            ->where('purchase_order_id', $purchaseOrderId)
            ->firstOrFail();

        return Inertia::render('Orders/Confirmed', [
            'order' => $order
        ]);
    }
}
