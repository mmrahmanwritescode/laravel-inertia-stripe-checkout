<?php

namespace App\Services;

use Stripe\StripeClient;
use Illuminate\Support\Facades\Config;

class StripeService
{
    protected $stripe;

    public function __construct()
    {
        $this->stripe = new StripeClient(Config::get('stripe.stripe_secret_key'));
    }

    public function create_payment_intent($total_price): array
    {
        $response = ['api' => '', 'error' => ''];
        $itemPriceCents = round($total_price * 100);

        try {
            $paymentIntent = $this->stripe->paymentIntents->create([
                'amount' => $itemPriceCents,
                'currency' => 'USD',
                'description' => 'Order Payment #' . now()->format('YmdHis'),
                'payment_method_types' => ['card']
            ]);
            
            $response['api'] = [
                'id' => $paymentIntent->id,
                'clientSecret' => $paymentIntent->client_secret
            ];
        } catch (\Exception $e) {
            $response['error'] = $e->getMessage();
        }
        
        return $response;
    }

    public function create_customer($payment_intent_id, $email, $name): array
    {
        $response = ['api' => '', 'error' => ''];

        try {
            $paymentIntent = $this->stripe->paymentIntents->retrieve($payment_intent_id);
            $customer_id = $paymentIntent->customer ?? null;

            if (!$customer_id) {
                $customer = $this->stripe->customers->create([
                    'name' => $name, 
                    'email' => $email
                ]);
                $customer_id = $customer->id;
            }

            $this->stripe->paymentIntents->update($payment_intent_id, [
                'customer' => $customer_id
            ]);
            
            $response['api'] = [
                'id' => $payment_intent_id, 
                'customer_id' => $customer_id
            ];
        } catch (\Exception $e) {
            $response['error'] = $e->getMessage();
        }

        return $response;
    }

    public function payment_insert($payment_intent, $customer_id): array
    {
        $response = ['paymentStatus' => false, 'error' => '', 'transactionID' => ''];

        try {
            $customer = $this->stripe->customers->retrieve($customer_id);
            if ($payment_intent["status"] == 'succeeded') {
                $response['paymentStatus'] = true;
                $response['transactionID'] = $payment_intent["id"];
            }
        } catch (\Exception $e) {
            $response['error'] = $e->getMessage();
        }

        return $response;
    }

    public function refund($chargeId, $amount = null): array
    {
        $response = [
            'refundStatus' => false,
            'refundID' => '',
            'api_error' => ''
        ];

        try {
            $refund = $this->stripe->refunds->create([
                'payment_intent' => $chargeId,
                'amount' => $amount ? $amount * 100 : null,
            ]);
            
            if ($refund->status == 'succeeded') {
                $response['refundID'] = $refund->id;
                $response['refundStatus'] = $refund->status;
            }
        } catch (\Exception $e) {
            $response['api_error'] = $e->getMessage();
        }

        return $response;
    }
}
