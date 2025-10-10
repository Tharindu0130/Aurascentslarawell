package com.example.aurascents.navigation

object Destinations {
    // Auth Screens
    const val SPLASH = "splash"
    const val LOGIN = "login"
    const val REGISTER = "register"
    
    // Main App Screens
    const val HOME = "home"
    const val PRODUCT_DETAIL = "product_detail/{productId}"
    const val WISHLIST = "wishlist"
    const val CART = "cart"
    const val CHECKOUT = "checkout"
    const val ORDER_HISTORY = "order_history"
    const val SETTINGS = "settings"
    const val PROFILE = "profile"
    
    // Helper functions
    fun productDetail(productId: String) = "product_detail/$productId"
}

