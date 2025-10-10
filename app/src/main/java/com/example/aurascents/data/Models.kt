package com.example.aurascents.data

import java.util.Date

data class Product(
    val id: String,
    val name: String,
    val price: Double,
    val originalPrice: Double? = null,
    val description: String,
    val category: String, // MEN, WOMEN, UNISEX
    val imageUrl: String? = null,
    val imageResId: Int? = null,
    val isAvailable: Boolean = true,
    val rating: Float = 0f,
    val reviewCount: Int = 0,
    val notes: String = "", // Fragrance notes
    val size: String = "50ml"
)

data class CartItem(
    val product: Product,
    val quantity: Int
) {
    val totalPrice: Double
        get() = product.price * quantity
}

data class User(
    val id: String,
    val email: String,
    val name: String,
    val phone: String? = null,
    val address: Address? = null
)

data class Address(
    val street: String,
    val city: String,
    val zipCode: String,
    val country: String = "Sri Lanka"
)

data class Order(
    val id: String,
    val userId: String,
    val items: List<CartItem>,
    val totalAmount: Double,
    val orderDate: Date,
    val status: OrderStatus,
    val shippingAddress: Address,
    val paymentMethod: String
)

enum class OrderStatus {
    PENDING,
    CONFIRMED,
    SHIPPED,
    DELIVERED,
    CANCELLED
}

data class WishlistItem(
    val product: Product,
    val addedDate: Date = Date()
)

