<?php

use App\Http\Controllers\CartController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\StripeWebhookController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// Cart Routes
Route::get('/', [CartController::class, 'index'])->name('cart.index');
Route::post('/cart/add-samples', [CartController::class, 'addSamples'])->name('cart.add-samples');
Route::post('/cart/add-item', [CartController::class, 'addItem'])->name('cart.add-item');
Route::post('/cart/update', [CartController::class, 'updateQuantity'])->name('cart.update');
Route::delete('/cart/remove/{itemId}', [CartController::class, 'removeItem'])->name('cart.remove');
Route::post('/clear-cart', [CartController::class, 'clearCart'])->name('cart.clear');

// Checkout Routes
Route::get('/checkout', [CheckoutController::class, 'index'])->name('checkout.show');
Route::post('/checkout/payment-intent', [CheckoutController::class, 'createPaymentIntent'])->name('checkout.payment-intent');
Route::post('/checkout/create-customer', [CheckoutController::class, 'createCustomerAndOrder'])->name('checkout.create-customer');
Route::post('/checkout/store', [CheckoutController::class, 'store'])->name('checkout.store');
Route::post('/checkout/payment-status', [CheckoutController::class, 'handlePaymentStatus'])->name('checkout.payment-status');

// Order Routes
Route::get('/orders', [OrderController::class, 'index'])->name('orders.index');
Route::get('/orders/confirmed/{purchaseOrderId}', [OrderController::class, 'confirm'])->name('orders.confirm');

// Stripe Webhook Route (exclude from CSRF protection)
Route::post('/stripe/webhook', [StripeWebhookController::class, 'handle'])
    ->name('stripe.webhook')
    ->withoutMiddleware(['web']);
