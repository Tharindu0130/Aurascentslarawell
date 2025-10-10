package com.example.aurascents.data

import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.State
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue

object WishlistState {
    private val _wishlistItems = mutableStateOf(sampleWishlist)
    val wishlistItems: State<List<WishlistItem>> = _wishlistItems
    
    fun isProductInWishlist(productId: String): Boolean {
        return _wishlistItems.value.any { wishlistItem -> 
            wishlistItem.product.id == productId 
        }
    }
    
    fun toggleWishlistItem(productId: String) {
        val product = sampleProducts.find { it.id == productId }
        if (product != null) {
            _wishlistItems.value = if (isProductInWishlist(productId)) {
                // Remove from wishlist
                _wishlistItems.value.filter { it.product.id != productId }
            } else {
                // Add to wishlist
                _wishlistItems.value + WishlistItem(product)
            }
        }
    }
    
    fun removeFromWishlist(productId: String) {
        _wishlistItems.value = _wishlistItems.value.filter { it.product.id != productId }
    }
}
