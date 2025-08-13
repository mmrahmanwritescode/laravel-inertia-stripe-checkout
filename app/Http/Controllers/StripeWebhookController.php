<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;
use Stripe\Webhook;
use Stripe\Exception\SignatureVerificationException;
use Illuminate\Support\Facades\Config;

class StripeWebhookController extends Controller
{
    /**
     * Handle Stripe webhook events
     */
    public function handle(Request $request)
    {
        $payload = $request->getContent();
        $sigHeader = $request->header('Stripe-Signature');
        $endpointSecret = Config::get('stripe.webhook_secret');

        try {
            // Verify webhook signature
            $event = Webhook::constructEvent($payload, $sigHeader, $endpointSecret);
        } catch (\UnexpectedValueException $e) {
            Log::error('Invalid payload in Stripe webhook', ['error' => $e->getMessage()]);
            return response('Invalid payload', 400);
        } catch (SignatureVerificationException $e) {
            Log::error('Invalid signature in Stripe webhook', ['error' => $e->getMessage()]);
            return response('Invalid signature', 400);
        }

        Log::info('Stripe webhook received', [
            'event_type' => $event->type,
            'event_id' => $event->id
        ]);

        // Handle the event
        switch ($event->type) {
            case 'payment_intent.succeeded':
                $this->handlePaymentIntentSucceeded($event);
                break;
            
            case 'payment_intent.payment_failed':
                $this->handlePaymentIntentFailed($event);
                break;
                
            case 'payment_intent.canceled':
                $this->handlePaymentIntentCanceled($event);
                break;
                
            default:
                Log::info('Unhandled webhook event type', ['type' => $event->type]);
        }

        return response('Webhook handled', 200);
    }

    /**
     * Handle successful payment intent
     */
    private function handlePaymentIntentSucceeded($event)
    {
        $paymentIntent = $event->data->object;
        
        Log::info('Payment succeeded', [
            'payment_intent_id' => $paymentIntent->id,
            'amount' => $paymentIntent->amount,
            'currency' => $paymentIntent->currency
        ]);

        // Find and update the order
        $order = Order::where('payment_intent_id', $paymentIntent->id)->first();
        
        if ($order) {
            $order->update([
                'status' => 'confirmed',
                'transaction_id' => $paymentIntent->id
            ]);
            
            Log::info('Order updated after successful payment', [
                'order_id' => $order->id,
                'purchase_order_id' => $order->purchase_order_id
            ]);
            
            // Here you could send confirmation emails, notifications, etc.
            // $this->sendOrderConfirmation($order);
        } else {
            Log::warning('No order found for payment intent', [
                'payment_intent_id' => $paymentIntent->id
            ]);
        }
    }

    /**
     * Handle failed payment intent
     */
    private function handlePaymentIntentFailed($event)
    {
        $paymentIntent = $event->data->object;
        
        Log::warning('Payment failed', [
            'payment_intent_id' => $paymentIntent->id,
            'last_payment_error' => $paymentIntent->last_payment_error
        ]);

        // Find and update the order
        $order = Order::where('payment_intent_id', $paymentIntent->id)->first();
        
        if ($order) {
            $order->update([
                'status' => 'cancelled',
            ]);
            
            Log::info('Order cancelled after failed payment', [
                'order_id' => $order->id,
                'purchase_order_id' => $order->purchase_order_id
            ]);
        }
    }

    /**
     * Handle canceled payment intent
     */
    private function handlePaymentIntentCanceled($event)
    {
        $paymentIntent = $event->data->object;
        
        Log::info('Payment canceled', [
            'payment_intent_id' => $paymentIntent->id
        ]);

        // Find and update the order
        $order = Order::where('payment_intent_id', $paymentIntent->id)->first();
        
        if ($order) {
            $order->update([
                'status' => 'cancelled',
            ]);
            
            Log::info('Order cancelled after payment cancellation', [
                'order_id' => $order->id,
                'purchase_order_id' => $order->purchase_order_id
            ]);
        }
    }

    /**
     * Send order confirmation (placeholder)
     */
    private function sendOrderConfirmation(Order $order)
    {
        // Implement your notification logic here
        // For example: send email, SMS, push notification, etc.
        
        Log::info('Order confirmation sent', [
            'order_id' => $order->id,
            'user_email' => $order->user->email
        ]);
    }
}
