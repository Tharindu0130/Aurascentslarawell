package com.example.aurascents.ui.screens

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.aurascents.data.sampleProducts
import com.example.aurascents.data.WishlistState
import com.example.aurascents.ui.components.QuantityStepper
import com.example.aurascents.ui.theme.*
import com.example.aurascents.ui.utils.formatLkr
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.layout.ContentScale
import androidx.compose.foundation.layout.BoxWithConstraints

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProductDetailScreen(
    productId: String,
    onNavigateBack: () -> Unit,
    onNavigateToCart: () -> Unit,
    onNavigateToWishlist: () -> Unit,
    modifier: Modifier = Modifier
) {
    val product = sampleProducts.find { it.id == productId } ?: sampleProducts[0]
    var quantity by remember { mutableStateOf(1) }
    
    // Check if product is already in wishlist
    val isInWishlist = WishlistState.isProductInWishlist(productId)
    
    var isAddToCartPressed by remember { mutableStateOf(false) }
    var isWishlistPressed by remember { mutableStateOf(false) }
    
    val addToCartScale by animateFloatAsState(
        targetValue = if (isAddToCartPressed) 0.95f else 1f,
        animationSpec = tween(100),
        label = "add_to_cart_scale"
    )
    
    val wishlistScale by animateFloatAsState(
        targetValue = if (isWishlistPressed) 0.8f else 1f,
        animationSpec = tween(100),
        label = "wishlist_scale"
    )
    
    val scrollState = rememberScrollState()
    
    BoxWithConstraints(modifier = modifier.fillMaxSize()) {
        val landscape = maxWidth > maxHeight
        
        Column(
            modifier = Modifier.fillMaxSize()
        ) {
        // Top App Bar
        TopAppBar(
            title = { Text("Product Details") },
            navigationIcon = {
                IconButton(onClick = onNavigateBack) {
                    Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                }
            },
            actions = {
                IconButton(
                    onClick = {
                        isWishlistPressed = true
                        // Toggle wishlist item
                        WishlistState.toggleWishlistItem(productId)
                    },
                    modifier = Modifier.scale(wishlistScale)
                ) {
                    Icon(
                        imageVector = if (isInWishlist) Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                        contentDescription = if (isInWishlist) "Remove from Wishlist" else "Add to Wishlist",
                        tint = if (isInWishlist) ErrorRed else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
        )
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
        ) {
            // Product Image
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(if (landscape) 200.dp else 300.dp)
                    .clip(RoundedCornerShape(12.dp))
            ) {
                if (product.imageResId != null) {
                    androidx.compose.foundation.Image(
                        painter = painterResource(product.imageResId),
                        contentDescription = product.name,
                        modifier = Modifier.fillMaxSize(),
                        contentScale = ContentScale.Fit // Changed from Crop to Fit to show full image
                    )
                } else {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(
                                when (product.category) {
                                    "MEN" -> MenFragrance.copy(alpha = 0.1f)
                                    "WOMEN" -> WomenFragrance.copy(alpha = 0.1f)
                                    else -> UnisexFragrance.copy(alpha = 0.1f)
                                }
                            ),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = product.name.take(2).uppercase(),
                            style = MaterialTheme.typography.displayLarge,
                            fontWeight = FontWeight.Bold,
                            color = when (product.category) {
                                "MEN" -> MenFragrance
                                "WOMEN" -> WomenFragrance
                                else -> UnisexFragrance
                            }
                        )
                    }
                }
            }
            
            // Product Info
            Column(
                modifier = Modifier.padding(if (landscape) 20.dp else 16.dp),
                verticalArrangement = Arrangement.spacedBy(if (landscape) 12.dp else 16.dp)
            ) {
                // Product Name and Category
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(modifier = Modifier.weight(1f)) {
                        Text(
                            text = product.name,
                            style = MaterialTheme.typography.headlineMedium,
                            fontWeight = FontWeight.Bold,
                            color = MaterialTheme.colorScheme.onBackground
                        )
                        Text(
                            text = product.category,
                            style = MaterialTheme.typography.bodyLarge,
                            color = when (product.category) {
                                "MEN" -> MenFragrance
                                "WOMEN" -> WomenFragrance
                                else -> UnisexFragrance
                            }
                        )
                    }
                    
                    // Rating
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            imageVector = Icons.Default.Star,
                            contentDescription = "Rating",
                            tint = AuraGold,
                            modifier = Modifier.size(20.dp)
                        )
                        Spacer(modifier = Modifier.width(4.dp))
                        Text(
                            text = String.format("%.1f", product.rating),
                            style = MaterialTheme.typography.bodyLarge,
                            fontWeight = FontWeight.Medium
                        )
                        Text(
                            text = " (${product.reviewCount})",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
                
                // Price
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = formatLkr(product.price),
                        style = MaterialTheme.typography.headlineLarge,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.primary
                    )
                }
                
                // Description
                Text(
                    text = product.description,
                    style = MaterialTheme.typography.bodyLarge,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    lineHeight = MaterialTheme.typography.bodyLarge.lineHeight
                )
                
                // Fragrance Notes
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(12.dp),
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceVariant
                    )
                ) {
                    Column(
                        modifier = Modifier.padding(16.dp)
                    ) {
                        Text(
                            text = "Fragrance Notes",
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.SemiBold,
                            color = MaterialTheme.colorScheme.onSurface
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        Text(
                            text = product.notes,
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
                
                // Quantity Selector
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "Quantity",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.SemiBold,
                        color = MaterialTheme.colorScheme.onSurface
                    )
                    
                    QuantityStepper(
                        quantity = quantity,
                        onQuantityChange = { quantity = it },
                        minQuantity = 1,
                        maxQuantity = 10
                    )
                }
                
                // Add to Cart Button
                Button(
                    onClick = {
                        isAddToCartPressed = true
                        onNavigateToCart()
                    },
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(56.dp)
                        .scale(addToCartScale),
                    shape = RoundedCornerShape(16.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.ShoppingCart,
                        contentDescription = "Add to Cart",
                        modifier = Modifier.size(20.dp)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = "Add to Cart - ${formatLkr(product.price * quantity)}",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.SemiBold
                    )
                }
                
                // Buy Now Button
                OutlinedButton(
                    onClick = { /* Navigate to checkout */ },
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(56.dp),
                    shape = RoundedCornerShape(16.dp)
                ) {
                    Text(
                        text = "Buy Now",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.SemiBold
                    )
                }
            }
        }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun ProductDetailScreenPreview() {
    AuraScentsTheme {
        ProductDetailScreen(
            productId = "1",
            onNavigateBack = {},
            onNavigateToCart = {},
            onNavigateToWishlist = {}
        )
    }
}
