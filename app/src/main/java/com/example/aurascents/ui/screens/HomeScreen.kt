package com.example.aurascents.ui.screens

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.aurascents.R
import com.example.aurascents.data.sampleProducts
import com.example.aurascents.data.WishlistState
import com.example.aurascents.ui.components.ProductCard
import com.example.aurascents.ui.theme.*
import androidx.compose.foundation.layout.BoxWithConstraints
import com.example.aurascents.ui.util.Responsive

@Composable
fun HomeScreen(
    onProductClick: (String) -> Unit,
    onNavigateToWishlist: () -> Unit,
    onNavigateToCart: () -> Unit,
    onNavigateToProfile: () -> Unit,
    modifier: Modifier = Modifier
) {
    val featuredProducts = sampleProducts.take(3)
    val popularProducts = sampleProducts.drop(3)
    
    // Use shared wishlist state
    val wishlistItems by WishlistState.wishlistItems

    BoxWithConstraints(modifier = modifier.fillMaxSize()) {
        val landscape = maxWidth > maxHeight
        val outerPadding = if (landscape) 20.dp else 16.dp

        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.background),
            contentPadding = PaddingValues(outerPadding),
            verticalArrangement = Arrangement.spacedBy(if (landscape) 20.dp else 24.dp)
        ) {
        // Header
        item {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(
                    modifier = Modifier.weight(Responsive.horizontalContentWidthFraction(landscape)),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    // Logo
                    Image(
                        painter = painterResource(id = R.drawable.logo),
                        contentDescription = "AuraScents Logo",
                        modifier = Modifier
                            .size(if (landscape) 48.dp else 40.dp)
                            .clip(RoundedCornerShape(8.dp)),
                        contentScale = ContentScale.Fit
                    )
                    
                    // Brand Text
                    Column {
                        Text(
                            text = "AuraScents",
                            style = if (landscape) MaterialTheme.typography.titleLarge else MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.Bold,
                            color = MaterialTheme.colorScheme.onBackground
                        )
                        Text(
                            text = "Explore Products",
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
                
                IconButton(
                    onClick = onNavigateToCart,
                    modifier = Modifier
                        .background(
                            MaterialTheme.colorScheme.primary.copy(alpha = 0.1f),
                            RoundedCornerShape(12.dp)
                        )
                ) {
                    Icon(
                        imageVector = Icons.Default.ShoppingCart,
                        contentDescription = "Shopping Cart",
                        tint = MaterialTheme.colorScheme.primary
                    )
                }
            }
        }
        
        // Search Bar
        item {
            OutlinedTextField(
                value = "",
                onValueChange = { },
                placeholder = { Text("Search perfumes...") },
                leadingIcon = {
                    Icon(Icons.Default.Search, contentDescription = "Search")
                },
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(16.dp),
                singleLine = true
            )
        }
        
        // Featured Section (carousel)
        item {
            Column {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Spacer(modifier = Modifier.height(4.dp))
                }
                
                Spacer(modifier = Modifier.height(12.dp))
                
                LazyRow(
                    horizontalArrangement = Arrangement.spacedBy(if (landscape) 20.dp else 16.dp),
                    contentPadding = PaddingValues(horizontal = 4.dp)
                ) {
                    items(featuredProducts) { product ->
                        ProductCard(
                            product = product,
                            onProductClick = onProductClick,
                            onWishlistToggle = { productId ->
                                // Toggle wishlist item
                                WishlistState.toggleWishlistItem(productId)
                            },
                            isInWishlist = WishlistState.isProductInWishlist(product.id),
                            modifier = if (landscape) Modifier.width(200.dp) else Modifier.width(160.dp)
                        )
                    }
                }
            }
        }
        
        // Popular Section
        item {
            Column {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "Popular Products",
                        style = MaterialTheme.typography.headlineSmall,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.onBackground
                    )
                    
                    TextButton(onClick = { /* Show all popular */ }) { Text("see all") }
                }
                
                Spacer(modifier = Modifier.height(12.dp))
                
                LazyRow(
                    horizontalArrangement = Arrangement.spacedBy(if (landscape) 20.dp else 16.dp),
                    contentPadding = PaddingValues(horizontal = 4.dp)
                ) {
                    items(popularProducts) { product ->
                        ProductCard(
                            product = product,
                            onProductClick = onProductClick,
                            onWishlistToggle = { productId ->
                                // Toggle wishlist item
                                WishlistState.toggleWishlistItem(productId)
                            },
                            isInWishlist = WishlistState.isProductInWishlist(product.id),
                            modifier = if (landscape) Modifier.width(260.dp) else Modifier.width(220.dp)
                        )
                    }
                }
            }
        }
        
        // Categories Section
        item {
            Column {
                Text(
                    text = "Categories",
                    style = MaterialTheme.typography.headlineSmall,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.onBackground
                )
                
                Spacer(modifier = Modifier.height(12.dp))
                
                LazyRow(
                    horizontalArrangement = Arrangement.spacedBy(if (landscape) 16.dp else 12.dp),
                    contentPadding = PaddingValues(horizontal = 4.dp)
                ) {
                    items(listOf("MEN", "WOMEN", "UNISEX")) { category ->
                        CategoryChip(
                            category = category,
                            onClick = { /* Filter by category */ }
                        )
                    }
                }
            }
        }
        
        // Special Offer Banner
        item {
            Card(
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(16.dp),
                colors = CardDefaults.cardColors(
                    containerColor = AuraGold.copy(alpha = 0.1f)
                )
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(
                            Brush.horizontalGradient(
                                colors = listOf(
                                    AuraGold.copy(alpha = 0.1f),
                                    AuraGold.copy(alpha = 0.05f)
                                )
                            )
                        )
                        .padding(if (landscape) 24.dp else 20.dp)
                ) {
                    Column(
                        modifier = if (landscape) Modifier.fillMaxWidth(0.8f) else Modifier.fillMaxWidth()
                    ) {
                        Text(
                            text = "Special Offer",
                            style = MaterialTheme.typography.titleLarge,
                            fontWeight = FontWeight.Bold,
                            color = MaterialTheme.colorScheme.onBackground
                        )
                        Text(
                            text = "Get 20% off on your first order",
                            style = MaterialTheme.typography.bodyLarge,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        TextButton(
                            onClick = { /* Apply offer */ },
                            colors = ButtonDefaults.textButtonColors(
                                contentColor = MaterialTheme.colorScheme.primary
                            )
                        ) {
                            Text("Shop Now")
                        }
                    }
                }
            }
        }
        }
    }
}

@Composable
private fun CategoryChip(
    category: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    val backgroundColor = when (category) {
        "MEN" -> MenFragrance.copy(alpha = 0.1f)
        "WOMEN" -> WomenFragrance.copy(alpha = 0.1f)
        else -> UnisexFragrance.copy(alpha = 0.1f)
    }
    
    val textColor = when (category) {
        "MEN" -> MenFragrance
        "WOMEN" -> WomenFragrance
        else -> UnisexFragrance
    }
    
    Surface(
        modifier = modifier
            .clip(RoundedCornerShape(20.dp))
            .clickable { onClick() },
        color = backgroundColor,
        border = androidx.compose.foundation.BorderStroke(
            1.dp,
            textColor.copy(alpha = 0.3f)
        )
    ) {
        Text(
            text = category,
            modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp),
            style = MaterialTheme.typography.bodyMedium,
            fontWeight = FontWeight.Medium,
            color = textColor
        )
    }
}

@Preview(showBackground = true)
@Composable
fun HomeScreenPreview() {
    AuraScentsTheme {
        HomeScreen(
            onProductClick = {},
            onNavigateToWishlist = {},
            onNavigateToCart = {},
            onNavigateToProfile = {}
        )
    }
}
