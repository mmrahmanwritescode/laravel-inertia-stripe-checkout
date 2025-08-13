<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('purchase_order_id')->unique();
            $table->enum('status', ['order_in_progress', 'order_placed', 'confirmed', 'cancelled'])->default('order_in_progress');
            $table->enum('payment_method', ['stripe', 'N/A'])->default('stripe');
            $table->decimal('price', 8, 2);
            $table->decimal('shipping_cost', 8, 2)->default(0);
            $table->string('transaction_id')->nullable();
            $table->string('payment_intent_id')->nullable();
            $table->text('notes')->nullable();
            $table->enum('order_type', ['delivery', 'takeaway', 'pay_on_spot'])->default('delivery');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
