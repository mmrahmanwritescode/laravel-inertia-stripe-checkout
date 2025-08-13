<template>
    <AppLayout>
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Success Icon -->
                    <div class="text-center mb-4">
                        <div class="d-inline-flex align-items-center justify-content-center bg-success bg-opacity-10 rounded-circle mb-3" style="width: 64px; height: 64px;">
                            <i class="fas fa-check text-success" style="font-size: 2rem;"></i>
                        </div>
                        <h1 class="display-6 text-dark mb-3">Order Confirmed!</h1>
                        <p class="text-muted mb-4">Thank you for your order. Your order has been placed successfully.</p>
                    </div>
                    
                    <!-- Order Details -->
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title h5 mb-4">Order Details</h2>
                            
                            <div class="row g-4 mb-4">
                                <div class="col-md-6">
                                    <h6 class="fw-bold text-dark mb-2">Order Information</h6>
                                    <p class="text-muted small mb-1">Order #: {{ order.purchase_order_id }}</p>
                                    <p class="text-muted small mb-1">Status: {{ formatStatus(order.status) }}</p>
                                    <p class="text-muted small mb-1">Order Type: {{ formatOrderType(order.order_type) }}</p>
                                    <p class="text-muted small mb-1">Date: {{ formatDate(order.created_at) }}</p>
                                </div>
                                
                                <div class="col-md-6">
                                    <h6 class="fw-bold text-dark mb-2">Customer Information</h6>
                                    <p class="text-muted small mb-1">{{ order.user.first_name }} {{ order.user.last_name }}</p>
                                    <p class="text-muted small mb-1">{{ order.user.email }}</p>
                                    <p class="text-muted small mb-1">{{ order.user.phone }}</p>
                                    <p v-if="order.order_type === 'delivery' && order.address" class="text-muted small mb-1">
                                        {{ order.address }}, {{ order.post_code }}
                                    </p>
                                </div>
                            </div>
                            
                            <!-- Order Items -->
                            <div class="mb-4">
                                <h6 class="fw-bold text-dark mb-3">Order Items</h6>
                                <div class="list-group list-group-flush">
                                    <div v-for="item in order.order_items" :key="item.id" class="list-group-item d-flex justify-content-between align-items-center px-0 border-bottom pb-3">
                                        <div>
                                            <div class="fw-medium">{{ item.food_item.name }}</div>
                                            <div class="text-muted small">Qty: {{ item.quantity }} × ${{ item.price }}</div>
                                        </div>
                                        <div class="text-end">
                                            <div class="fw-medium">${{ (item.price * item.quantity).toFixed(2) }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Total -->
                            <div class="border-top pt-3">
                                <div class="row mb-2">
                                    <div class="col">
                                        <span class="text-muted">Subtotal</span>
                                    </div>
                                    <div class="col-auto">
                                        <span>${{ parseFloat(order.price).toFixed(2) }}</span>
                                    </div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col">
                                        <span class="text-muted">Shipping</span>
                                    </div>
                                    <div class="col-auto">
                                        <span v-if="order.shipping_cost > 0">${{ parseFloat(order.shipping_cost).toFixed(2) }}</span>
                                        <span v-else class="text-success">Free</span>
                                    </div>
                                </div>
                                <div class="row border-top pt-2">
                                    <div class="col">
                                        <span class="fw-bold fs-5">Total</span>
                                    </div>
                                    <div class="col-auto">
                                        <span class="fw-bold fs-5">${{ (parseFloat(order.price) + parseFloat(order.shipping_cost)).toFixed(2) }}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Payment Information -->
                            <div v-if="order.payment_method === 'stripe'" class="mt-4 pt-4 border-top">
                                <h6 class="fw-bold text-dark mb-2">Payment Information</h6>
                                <p class="text-muted small mb-1">Payment Method: Credit Card</p>
                                <p class="text-muted small mb-1">Transaction ID: {{ order.transaction_id }}</p>
                            </div>
                            
                            <!-- Notes -->
                            <div v-if="order.notes" class="mt-4 pt-4 border-top">
                                <h6 class="fw-bold text-dark mb-2">Order Notes</h6>
                                <p class="text-muted small">{{ order.notes }}</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="text-center mt-4">
                        <div class="d-flex gap-3 justify-content-center">
                            <Link href="/" class="btn btn-primary px-4 py-2">
                                Continue Shopping
                            </Link>
                            <Link href="/orders" class="btn btn-outline-secondary px-4 py-2">
                                View All Orders
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import AppLayout from '@/Components/Layout/AppLayout.vue'

defineProps({
    order: Object
})

const formatStatus = (status) => {
    return status.split('_').map(word => 
        word.charAt(0).toUpperCase() + word.slice(1)
    ).join(' ')
}

const formatOrderType = (type) => {
    const types = {
        delivery: 'Delivery',
        takeaway: 'Takeaway',
        pay_on_spot: 'Pay on Spot'
    }
    return types[type] || type
}

const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString()
}
</script>
