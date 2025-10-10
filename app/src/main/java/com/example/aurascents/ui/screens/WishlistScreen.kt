package com.example.aurascents.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items as gridItems
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.aurascents.data.WishlistState
import com.example.aurascents.ui.components.ProductCard
import com.example.aurascents.ui.theme.*

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WishlistScreen(
    onNavigateBack: () -> Unit,
    onProductClick: (String) -> Unit,
    modifier: Modifier = Modifier
) {
    val wishlistItems by WishlistState.wishlistItems

    BoxWithConstraints(modifier = modifier.fillMaxSize()) {
        val landscape = maxWidth > maxHeight

        Column(modifier = Modifier.fillMaxSize()) {
            // Top App Bar
            TopAppBar(
                title = { Text("My Wishlist") },
                navigationIcon = {
                    IconButton(onClick = onNavigateBack) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
                    }
                },
                actions = {
                    IconButton(onClick = { /* Add all to cart or clear */ }) {
                        Icon(Icons.Default.ShoppingCart, contentDescription = "Add All to Cart")
                    }
                }
            )

            if (wishlistItems.isEmpty()) {
                // Empty State
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(
                            Brush.verticalGradient(
                                colors = listOf(
                                    AuraGold.copy(alpha = 0.05f),
                                    MaterialTheme.colorScheme.background
                                )
                            )
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally,
                        verticalArrangement = Arrangement.spacedBy(if (landscape) 12.dp else 16.dp)
                    ) {
                        Icon(
                            imageVector = Icons.Default.Favorite,
                            contentDescription = "Empty Wishlist",
                            modifier = Modifier.size(if (landscape) 48.dp else 64.dp),
                            tint = MaterialTheme.colorScheme.onSurfaceVariant
                        )

                        Text(
                            text = "Your wishlist is empty",
                            style = MaterialTheme.typography.headlineSmall,
                            fontWeight = FontWeight.SemiBold,
                            color = MaterialTheme.colorScheme.onBackground
                        )

                        Text(
                            text = "Add items you love to your wishlist",
                            style = MaterialTheme.typography.bodyLarge,
                            color = MaterialTheme.colorScheme.onSurfaceVariant,
                            textAlign = TextAlign.Center
                        )
                    }
                }
            } else {
                if (landscape) {
                    // 🌐 Landscape → grid layout
                    LazyVerticalGrid(
                        columns = GridCells.Fixed(3),
                        contentPadding = PaddingValues(if (landscape) 20.dp else 16.dp),
                        verticalArrangement = Arrangement.spacedBy(if (landscape) 12.dp else 16.dp),
                        horizontalArrangement = Arrangement.spacedBy(if (landscape) 12.dp else 16.dp),
                        modifier = Modifier.fillMaxSize()
                    ) {
                        gridItems(wishlistItems) { wishlistItem ->
                            ProductCard(
                                product = wishlistItem.product,
                                onProductClick = onProductClick,
                                onWishlistToggle = { productId ->
                                    WishlistState.removeFromWishlist(productId)
                                },
                                isInWishlist = true,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                    }
                } else {
                    // 📱 Portrait → vertical list
                    LazyColumn(
                        modifier = Modifier.fillMaxSize(),
                        contentPadding = PaddingValues(if (landscape) 20.dp else 16.dp),
                        verticalArrangement = Arrangement.spacedBy(if (landscape) 12.dp else 16.dp)
                    ) {
                        items(wishlistItems) { wishlistItem ->
                            ProductCard(
                                product = wishlistItem.product,
                                onProductClick = onProductClick,
                                onWishlistToggle = { productId ->
                                    WishlistState.removeFromWishlist(productId)
                                },
                                isInWishlist = true,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun WishlistScreenPreview() {
    AuraScentsTheme {
        WishlistScreen(
            onNavigateBack = {},
            onProductClick = {}
        )
    }
}
