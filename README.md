# Laravel Inertia Vue3 Stripe Checkout System

A modern, full-featured food ordering system with Stripe payment processing, built using Laravel 12, Inertia.js, Vue 3, and comprehensive webhook integration.

## 🚀 Live Demo
**Try it now:** [https://laravel-inertia-stripe.laravelcs.com/checkout](https://laravel-inertia-stripe.laravelcs.com/checkout)

Experience the complete checkout flow with real-time payment processing and webhook integration!

## 🛠️ Technology Stack

### Backend
- **Laravel 12** - Latest PHP framework
- **Inertia.js Laravel** (v2.0) - Server-side adapter
- **Stripe PHP SDK** (v17.5) - Payment processing
- **MySQL** - Database
- **PHP 8.2+** - Modern PHP features

### Frontend
- **Vue 3** (v3.5.18) - Progressive JavaScript framework
- **Inertia.js Vue3** (v2.0.17) - Client-side adapter
- **Bootstrap 5** (v5.3.3) - UI framework
- **Stripe.js** (v7.8.0) - Client-side payment processing
- **Vite** (v7.0.4) - Build tool and dev server

## ✨ Key Features

### 🛒 Shopping Cart System
- **Session-based cart management**
- **Real-time cart count updates**
- **Add/remove items with AJAX**
- **Cart persistence across page reloads**
- **Automatic cart clearing after successful orders**

### 💳 Advanced Payment Processing
- **Multiple Order Types:**
  - Delivery (with shipping cost)
  - Takeaway (free pickup)  
  - Pay on Spot (no online payment)
- **Stripe Payment Intents** - Modern payment processing
- **SCA Compliance** - Strong Customer Authentication support
- **3D Secure** - Enhanced security for European customers
- **Real-time payment validation**
- **Automatic payment error handling**

### 🔔 Comprehensive Webhook Integration
- **Real-time order status updates**
- **Payment event handling:**
  - `payment_intent.succeeded` - Order confirmation
  - `payment_intent.payment_failed` - Payment failure handling
  - `payment_intent.canceled` - Order cancellation
  - `payment_intent.requires_action` - 3D Secure handling
  - `charge.dispute.created` - Chargeback notifications
- **Secure webhook signature verification**
- **Complete event logging and tracking**
- **Automatic order status synchronization**

### 🎯 User Experience
- **Single Page Application** feel with Inertia.js
- **Server-side validation** with real-time error display
- **Responsive design** with Bootstrap 5
- **Loading states** and progress indicators
- **Error recovery** and retry mechanisms
- **Clean, modern UI/UX**

### 🔐 Security & Validation
- **Server-side form validation**
- **CSRF protection**
- **Stripe webhook signature verification**
- **SQL injection prevention**
- **XSS protection**
- **Conditional validation** (delivery address requirements)

## 📋 Database Schema

### Tables Included
- **users** - Customer information
- **food_items** - Product catalog
- **cart_items** - Session-based shopping cart
- **orders** - Order management
- **order_items** - Order line items

### Key Relationships
```
users (1:n) orders (1:n) order_items (n:1) food_items
cart_items (n:1) food_items
orders (1:1) payment_intents (via Stripe)
```

## 🔧 Installation & Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd laravel-inertia-stripe
```

### 2. Backend Setup
```bash
# Install PHP dependencies
composer install

# Copy environment file
cp .env.example .env

# Generate application key
php artisan key:generate
```

### 3. Database Configuration
```bash
# Create MySQL database
# Update .env with database credentials:
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_username
DB_PASSWORD=your_password

# Run migrations with demo data
php artisan migrate:fresh --seed
```

### 4. Stripe Configuration
```bash
# Add to .env file:
STRIPE_KEY=pk_test_your_publishable_key
STRIPE_SECRET=sk_test_your_secret_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
```

### 5. Frontend Setup
```bash
# Install Node.js dependencies
npm install

# Build for development
npm run dev

# Or build for production
npm run build
```

### 6. Webhook Setup
1. **Stripe Dashboard Configuration:**
   - Go to Stripe Dashboard → Webhooks
   - Add endpoint: `https://yourdomain.com/stripe/webhook`
   - Select events: `payment_intent.succeeded`, `payment_intent.payment_failed`, `payment_intent.canceled`, `payment_intent.requires_action`, `charge.dispute.created`
   - Copy webhook signing secret to `.env`

2. **Local Development (using Stripe CLI):**
```bash
# Install Stripe CLI
stripe listen --forward-to localhost:8000/stripe/webhook

# Copy webhook secret to .env
STRIPE_WEBHOOK_SECRET=whsec_...
```

### 7. Start Development Servers
```bash
# Terminal 1: Laravel development server
php artisan serve

# Terminal 2: Vite development server  
npm run dev

# Browse to: http://localhost:8000
```

## 🔄 Payment Flow

### Delivery/Takeaway Orders (Stripe Payment)
1. **User fills checkout form** → Client-side validation
2. **Payment Intent created** → Server generates Stripe Payment Intent
3. **Stripe Elements initialized** → Secure card input fields
4. **Form submission** → Server-side validation
5. **Customer & Order created** → Database records
6. **Payment processing** → Stripe handles payment
7. **Webhook confirmation** → Real-time status updates
8. **Success redirect** → Order confirmation page

### Pay on Spot Orders
1. **User fills checkout form** → Client-side validation
2. **Form submission** → Server-side validation
3. **Order creation** → Direct database storage
4. **Success redirect** → Order confirmation page

## 📁 Project Structure

### Backend Architecture
```
app/
├── Http/Controllers/
│   ├── CartController.php          # Shopping cart operations
│   ├── CheckoutController.php      # Payment processing
│   ├── OrderController.php         # Order management
│   └── StripeWebhookController.php # Webhook handling
├── Models/
│   ├── User.php                    # Customer model
│   ├── FoodItem.php               # Product model
│   ├── CartItem.php               # Cart model
│   ├── Order.php                  # Order model
│   └── OrderItem.php              # Order items model
├── Services/
│   └── StripeService.php          # Stripe integration service
└── Helpers/
    └── CartHelpers.php            # Cart utility functions
```

### Frontend Architecture
```
resources/js/
├── Components/
│   ├── Layout/
│   │   └── AppLayout.vue          # Main layout component
│   └── Checkout/
│       ├── CheckoutForm.vue       # Billing information form
│       ├── PaymentForm.vue        # Stripe payment elements
│       └── OrderSummary.vue       # Cart summary display
└── Pages/
    ├── Cart/
    │   └── Index.vue              # Shopping cart page
    ├── Checkout/
    │   └── Show.vue               # Checkout page
    └── Orders/
        ├── Index.vue              # Order history
        └── Confirmed.vue          # Order confirmation
```

## 🧪 Testing

### Payment Testing (Stripe Test Cards)
```bash
# Successful payment
4242 4242 4242 4242

# 3D Secure authentication required  
4000 0025 0000 3155

# Card declined
4000 0000 0000 0002

# Expired card
4000 0000 0000 0069
```

### Webhook Testing
```bash
# Test webhook locally with Stripe CLI
stripe trigger payment_intent.succeeded
stripe trigger payment_intent.payment_failed
stripe trigger payment_intent.canceled
```

## 🔍 Monitoring & Logging

### Webhook Events
- All webhook events are logged in `storage/logs/laravel.log`
- Order status changes are tracked
- Payment failures are recorded with reasons
- Dispute events are captured for review

### Error Handling
- Graceful payment error recovery
- User-friendly error messages
- Comprehensive error logging
- Automatic retry mechanisms

## 🚀 Production Deployment

### Environment Setup
```bash
# Set production environment
APP_ENV=production
APP_DEBUG=false

# Configure production database
# Set production Stripe keys
# Configure webhook URL
```

### Build Assets
```bash
npm run build
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

## 📖 API Endpoints

### Checkout Endpoints
- `GET /checkout` - Checkout page
- `POST /checkout/payment-intent` - Create payment intent
- `POST /checkout/create-customer` - Create Stripe customer & order
- `POST /checkout/store` - Store pay-on-spot orders
- `POST /checkout/payment-status` - Handle payment status

### Cart Endpoints  
- `GET /cart` - View cart
- `POST /cart/add` - Add item to cart
- `DELETE /cart/remove/{id}` - Remove cart item
- `POST /clear-cart` - Clear entire cart

### Webhook Endpoints
- `POST /stripe/webhook` - Stripe webhook handler

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

## 🔗 Related Resources

### Tutorials & Documentation
- [A Step-by-Step Guide on Laravel Checkout System with Stripe](https://laravelcs.com/communities/projects/topics/stripe/posts/192)
- [Building mini ecommerce in Laravel](https://laravelcs.com/communities/projects/topics/mini-ecommerce/posts/113)
- [Building mini issue tracker with Vue3 SPA in Laravel](https://laravelcs.com/communities/projects/topics/mini-issue-tracker/posts/159)

### More Projects
Visit [LaravelCodeSnippet.com](https://laravelcs.com) for more Laravel tutorials and projects.

### Freelance Work
Available for custom Laravel development projects. Contact: [mahfoozurrahman.com](https://www.mahfoozurrahman.com)

---

⭐ **If this project helped you, please give it a star!** ⭐