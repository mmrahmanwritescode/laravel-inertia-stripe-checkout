<template>
    <AppLayout>
        <div>
            <h1 class="h2 fw-bold text-dark mb-4">Checkout</h1>
            
            <!-- Show error if provided -->
            <div v-if="error" class="alert alert-danger mb-4">
                {{ error }}
            </div>
            
            <div v-if="cartData.items.length === 0" class="text-center py-5">
                <p class="text-muted fs-5">Your cart is empty</p>
                <Link href="/" class="btn btn-primary btn-lg mt-3">
                    Continue Shopping
                </Link>
            </div>
            
            <div v-else class="row g-5">
                <!-- Checkout Form -->
                <div class="col-lg-7">
                    <CheckoutForm 
                        :form="form"
                        :processing="processing"
                        @submit="handleSubmit"
                        @order-type-changed="handleOrderTypeChange"
                    />
                </div>
                
                <!-- Order Summary & Payment -->
                <div class="col-lg-5">
                    <OrderSummary 
                        :cartData="cartData"
                        :shipping-cost="shippingCost"
                    />
                    
                    <!-- Payment Form (only show if not pay on spot) -->
                    <div v-if="form.order_type !== 'pay_on_spot'" class="mt-4">
                        <PaymentForm 
                            ref="paymentFormRef"
                            :stripe="stripe"
                            :payment-intent-id="paymentIntentId"
                            :client-secret="clientSecret"
                            :processing="processing"
                            @process-payment="handleStripePayment"
                            @payment-error="handlePaymentError"
                        />
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { useForm, Link, router } from '@inertiajs/vue3'
import AppLayout from '@/Components/Layout/AppLayout.vue'
import CheckoutForm from '@/Components/Checkout/CheckoutForm.vue'
import PaymentForm from '@/Components/Checkout/PaymentForm.vue'
import OrderSummary from '@/Components/Checkout/OrderSummary.vue'

const props = defineProps({
    cartData: Object,
    stripe: Object,
    paymentIntent: Object,
    customerData: Object,
    error: String
})

const paymentFormRef = ref(null)
const paymentIntentId = ref(null)
const clientSecret = ref(null)
const processing = ref(false)

const form = useForm({
    first_name: '',
    last_name: '',
    email: '',
    phone: '',
    address: '',
    post_code: '',
    notes: '',
    shipping_cost: 5.00,
    order_type: 'delivery'
})

const shippingCost = computed(() => {
    return form.order_type === 'takeaway' ? 0 : 5.00
})

watch(() => form.order_type, (newType) => {
    form.shipping_cost = newType === 'takeaway' ? 0 : 5.00
})

// Create payment intent when component mounts (if not pay on spot)
onMounted(async () => {
    console.log('Component mounted, order type:', form.order_type)
    console.log('Props received:', {
        cartData: props.cartData,
        stripe: props.stripe,
        paymentIntent: props.paymentIntent,
        customerData: props.customerData,
        error: props.error
    })
    
    // Only create payment intent if cart has items and order type requires payment
    if (props.cartData.items.length > 0 && form.order_type !== 'pay_on_spot' && !paymentIntentId.value) {
        console.log('Creating payment intent on mount...')
        await createPaymentIntentForUI()
    }
})

// Watch for order type changes
watch(() => form.order_type, async (newType, oldType) => {
    console.log('Order type changed:', { oldType, newType })
    
    if (newType === 'pay_on_spot') {
        // Clear payment intent if switching to pay on spot
        console.log('Clearing payment intent for pay on spot')
        paymentIntentId.value = null
        clientSecret.value = null
    } else if (oldType === 'pay_on_spot' && !paymentIntentId.value && props.cartData.items.length > 0) {
        // Create payment intent if switching from pay on spot to payment method
        console.log('Switched from pay on spot to payment method, creating payment intent...')
        await createPaymentIntentForUI()
    }
})

// Watch for form readiness - keep this for debugging
watch(() => [form.first_name, form.last_name, form.email, form.phone], ([firstName, lastName, email, phone]) => {
    console.log('Form fields changed:', { firstName, lastName, email, phone, orderType: form.order_type })
}, { immediate: true })

// Watch for clientSecret changes
watch(() => clientSecret.value, (newSecret, oldSecret) => {
    console.log('Main component clientSecret changed:', { newSecret, oldSecret })
})

const handleOrderTypeChange = (orderType) => {
    form.order_type = orderType
}

const handlePaymentError = (errorMessage) => {
    console.log('Payment error received:', errorMessage)
    processing.value = false
}

const createPaymentIntentForUI = async () => {
    try {
        const total = props.cartData.summary.total + shippingCost.value
        console.log('Creating payment intent for total:', total)
        const intentResponse = await createPaymentIntent(total)
        
        console.log('Payment intent response:', intentResponse)
        if (intentResponse.error) {
            console.error('Payment intent error:', intentResponse.error)
            return
        }
        
        console.log('Setting paymentIntentId and clientSecret...')
        paymentIntentId.value = intentResponse.id
        clientSecret.value = intentResponse.clientSecret
        
        console.log('Values set:', {
            paymentIntentId: paymentIntentId.value,
            clientSecret: clientSecret.value
        })
        
        // Set up payment element with client secret
        if (paymentFormRef.value && clientSecret.value) {
            console.log('Setting up payment element')
            await paymentFormRef.value.setupPaymentElement(clientSecret.value)
        } else {
            console.log('Cannot setup payment element:', {
                hasPaymentFormRef: !!paymentFormRef.value,
                hasClientSecret: !!clientSecret.value
            })
        }
    } catch (error) {
        console.error('Error creating payment intent:', error)
    }
}

const createPaymentIntentForForm = async () => {
    try {
        const total = props.cartData.summary.total + shippingCost.value
        console.log('Creating payment intent for total:', total)
        const intentResponse = await createPaymentIntent(total)
        
        console.log('Payment intent response:', intentResponse)
        if (intentResponse.error) {
            console.error('Payment intent error:', intentResponse.error)
            return
        }
        
        console.log('Setting paymentIntentId and clientSecret...')
        paymentIntentId.value = intentResponse.id
        clientSecret.value = intentResponse.clientSecret  // Using camelCase to match backend
        
        console.log('Values set:', {
            paymentIntentId: paymentIntentId.value,
            clientSecret: clientSecret.value
        })
        
        // Set up payment element with client secret
        if (paymentFormRef.value && clientSecret.value) {
            console.log('Setting up payment element')
            await paymentFormRef.value.setupPaymentElement(clientSecret.value)
        } else {
            console.log('Cannot setup payment element:', {
                hasPaymentFormRef: !!paymentFormRef.value,
                hasClientSecret: !!clientSecret.value
            })
        }
    } catch (error) {
        console.error('Error creating payment intent:', error)
    }
}

const handleSubmit = async () => {

    if (form.processing) return
    
    processing.value = true
    
    try {
        if (form.order_type === 'pay_on_spot') {
            // Direct form submission for pay on spot - let server handle validation
            form.post('/checkout/store', {
                onSuccess: (page) => {
                    processing.value = false
                },
                onError: (errors) => {
                    processing.value = false
                    // Inertia automatically handles validation errors
                }
            })
        } else {
            // Handle Stripe payment
            await handleStripePayment()
        }
    } catch (error) {
        console.error('Checkout error:', error)
        processing.value = false
    }
}

const handleStripePayment = async () => {
    processing.value = true
    
    try {
        // Payment intent should already be created, just proceed with customer and payment
        if (!paymentIntentId.value) {
            throw new Error('Payment intent not ready')
        }
        
        // Create customer and order
        const customerResponse = await createCustomerAndOrder()
        
        if (customerResponse.error) {
            throw new Error(customerResponse.error)
        }
        
        // Confirm payment with Stripe
        if (paymentFormRef.value) {
            await paymentFormRef.value.confirmPayment({
                order_id: customerResponse.order_id,
                purchase_order_id: customerResponse.purchase_order_id,
                customer_id: customerResponse.customer_id,
                clientSecret: clientSecret.value
            })
        }
    } catch (error) {
        console.error('Payment error:', error)
        processing.value = false
    }
}

const createPaymentIntent = async (total) => {
    
    try {
        console.log('Making AJAX call to create payment intent for total:', total)
        
        const response = await fetch('/checkout/payment-intent', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                total_price: total
            })
        })

        const data = await response.json()
        console.log('Payment intent AJAX response:', data)

        if (!response.ok) {
            throw new Error(data.error || 'Failed to create payment intent')
        }

        return data
    } catch (error) {
        console.error('Error in createPaymentIntent AJAX:', error)
        return { error: error.message }
    }
}

const createCustomerAndOrder = async () => {
    try {
        console.log('Making AJAX call to create customer and order')
        
        const response = await fetch('/checkout/create-customer', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                payment_intent_id: paymentIntentId.value,
                ...form.data()
            })
        })

        const data = await response.json()
        console.log('Customer and order AJAX response:', data)

        if (!response.ok) {
            // Handle validation errors from Laravel
            if (response.status === 422 && data.errors) {
                // Set errors on the Inertia form object so they display correctly
                Object.keys(data.errors).forEach(field => {
                    form.setError(field, data.errors[field])
                })
            }
            throw new Error(data.error || data.message || 'Failed to create customer and order')
        }

        return data
    } catch (error) {
        console.error('Error in createCustomerAndOrder AJAX:', error)
        return { error: error.message }
    }
}
</script>
