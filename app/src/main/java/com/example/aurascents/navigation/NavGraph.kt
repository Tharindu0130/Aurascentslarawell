package com.example.aurascents.navigation

import android.util.Log
import androidx.compose.runtime.Composable
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHostState
import androidx.compose.runtime.remember
import androidx.compose.foundation.layout.padding
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.aurascents.ui.screens.*
import com.example.aurascents.ui.components.AuraScentsBottomNavigation
import com.example.aurascents.ui.components.AuraScentsSnackbarHost

@Composable
fun AuraScentsNavGraph(
    navController: NavHostController = rememberNavController()
) {
    Log.d("AuraScents", "AuraScentsNavGraph composable started")
    val snackbarHostState = remember { SnackbarHostState() }

    Scaffold(
        snackbarHost = { AuraScentsSnackbarHost(hostState = snackbarHostState) },
        bottomBar = {
            val navBackStackEntry = navController.currentBackStackEntryAsState()
            val currentRoute = navBackStackEntry.value?.destination?.route
            val showBottomBar = currentRoute in listOf(
                Destinations.HOME,
                Destinations.WISHLIST,
                Destinations.CART,
                Destinations.PROFILE
            )
            if (showBottomBar) {
                AuraScentsBottomNavigation(
                    currentRoute = currentRoute,
                    onNavigate = { route ->
                        if (route != currentRoute) navController.navigate(route) {
                            popUpTo(Destinations.HOME) { saveState = true }
                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                )
            }
        }
    ) { paddingValues ->
        NavHost(
            navController = navController,
            startDestination = Destinations.SPLASH,
            modifier = androidx.compose.ui.Modifier.padding(paddingValues)
        ) {
        Log.d("AuraScents", "NavHost initialized with startDestination: ${Destinations.SPLASH}")
        composable(Destinations.SPLASH) {
            Log.d("AuraScents", "Navigating to SplashScreen")
            SplashScreen(
                onNavigateToLogin = {
                    Log.d("AuraScents", "SplashScreen: Navigating to Login")
                    navController.navigate(Destinations.LOGIN) {
                        popUpTo(Destinations.SPLASH) { inclusive = true }
                    }
                }
            )
        }
        
        composable(Destinations.LOGIN) {
            LoginScreen(
                onNavigateToRegister = {
                    navController.navigate(Destinations.REGISTER)
                },
                onNavigateToHome = {
                    navController.navigate(Destinations.HOME) {
                        popUpTo(Destinations.LOGIN) { inclusive = true }
                    }
                }
            )
        }
        
        composable(Destinations.REGISTER) {
            RegisterScreen(
                onNavigateToLogin = {
                    navController.navigate(Destinations.LOGIN) {
                        popUpTo(Destinations.REGISTER) { inclusive = true }
                    }
                },
                onNavigateToHome = {
                    navController.navigate(Destinations.HOME) {
                        popUpTo(Destinations.REGISTER) { inclusive = true }
                    }
                }
            )
        }
        
        composable(Destinations.HOME) {
            HomeScreen(
                onProductClick = { productId ->
                    navController.navigate(Destinations.productDetail(productId))
                },
                onNavigateToWishlist = {
                    navController.navigate(Destinations.WISHLIST) {
                        popUpTo(Destinations.HOME) { saveState = true }
                        launchSingleTop = true
                        restoreState = true
                    }
                },
                onNavigateToCart = {
                    navController.navigate(Destinations.CART) {
                        popUpTo(Destinations.HOME) { saveState = true }
                        launchSingleTop = true
                        restoreState = true
                    }
                },
                onNavigateToProfile = {
                    navController.navigate(Destinations.PROFILE) {
                        popUpTo(Destinations.HOME) { saveState = true }
                        launchSingleTop = true
                        restoreState = true
                    }
                }
            )
        }
        
        composable(Destinations.PRODUCT_DETAIL) { backStackEntry ->
            val productId = backStackEntry.arguments?.getString("productId") ?: ""
            ProductDetailScreen(
                productId = productId,
                onNavigateBack = {
                    navController.popBackStack()
                },
                onNavigateToCart = {
                    navController.navigate(Destinations.CART) {
                        popUpTo(Destinations.HOME) { saveState = true }
                        launchSingleTop = true
                        restoreState = true
                    }
                }
            )
        }
        
        composable(Destinations.WISHLIST) {
            WishlistScreen(
                onNavigateBack = {
                    navController.popBackStack()
                },
                onProductClick = { productId ->
                    navController.navigate(Destinations.productDetail(productId))
                }
            )
        }
        
        composable(Destinations.CART) {
            CartScreen(
                onNavigateBack = {
                    navController.popBackStack()
                },
                onNavigateToCheckout = {
                    navController.navigate(Destinations.CHECKOUT)
                },
                onProductClick = { productId ->
                    navController.navigate(Destinations.productDetail(productId))
                }
            )
        }
        
        composable(Destinations.CHECKOUT) {
            CheckoutScreen(
                onNavigateBack = {
                    navController.popBackStack()
                },
                onOrderPlaced = {
                    navController.navigate(Destinations.ORDER_HISTORY) {
                        popUpTo(Destinations.HOME) { inclusive = false }
                    }
                }
            )
        }
        
        composable(Destinations.ORDER_HISTORY) {
            OrderHistoryScreen(
                onNavigateBack = {
                    navController.popBackStack()
                },
                onOrderClick = { orderId ->
                    // Navigate to order detail if needed
                }
            )
        }
        
        composable(Destinations.SETTINGS) {
            SettingsScreen(
                onNavigateBack = {
                    navController.popBackStack()
                }
            )
        }
        
        composable(Destinations.PROFILE) {
            ProfileScreen(
                onNavigateBack = {
                    navController.popBackStack()
                },
                onNavigateToOrderHistory = {
                    navController.navigate(Destinations.ORDER_HISTORY)
                },
                onNavigateToWishlist = {
                    navController.navigate(Destinations.WISHLIST) {
                        popUpTo(Destinations.HOME) { saveState = true }
                        launchSingleTop = true
                        restoreState = true
                    }
                },
                onNavigateToSettings = {
                    navController.navigate(Destinations.SETTINGS)
                },
                onLogout = {
                    navController.navigate(Destinations.LOGIN) {
                        popUpTo(0) { inclusive = true }
                    }
                }
            )
        }
        }
    }
    Log.d("AuraScents", "AuraScentsNavGraph composable completed successfully")
}

