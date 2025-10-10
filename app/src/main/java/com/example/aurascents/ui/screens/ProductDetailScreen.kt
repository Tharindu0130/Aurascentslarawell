package com.example.aurascents.ui.screens

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.filled.List // ✅ fixed deprecation
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.aurascents.data.WishlistState
import com.example.aurascents.data.sampleProducts
import com.example.aurascents.ui.components.QuantityStepper
import com.example.aurascents.ui.theme.*
import com.example.aurascents.ui.utils.formatLkr
import kotlinx.coroutines.delay
import java.util.*

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProductDetailScreen(
    productId: String,
    onNavigateBack: () -> Unit,
    onNavigateToCart: () -> Unit,
    onNavigateToWishlist: () -> Unit,
    modifier: Modifier = Modifier
) {
    val product = sampleProducts.find { it.id == productId } ?: sampleProducts.first()

    var quantity by remember { mutableIntStateOf(1) }
    var isInWishlist by remember(productId) {
        mutableStateOf(WishlistState.isProductInWishlist(productId))
    }

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

    LaunchedEffect(isAddToCartPressed) {
        if (isAddToCartPressed) {
            delay(120)
            isAddToCartPressed = false
        }
    }
    LaunchedEffect(isWishlistPressed) {
        if (isWishlistPressed) {
            delay(120)
            isWishlistPressed = false
        }
    }

    val scrollState = rememberScrollState()

    // ✅ Removed BoxWithConstraints (not needed)
    Column(modifier = modifier.fillMaxSize()) {

        TopAppBar(
            title = { Text("Product Details") },
            navigationIcon = {
                IconButton(onClick = onNavigateBack) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                        contentDescription = "Back"
                    )
                }
            },
            actions = {
                // Wishlist toggle
                IconButton(
                    onClick = {
                        isWishlistPressed = true
                        WishlistState.toggleWishlistItem(productId)
                        isInWishlist = !isInWishlist
                    },
                    modifier = Modifier.scale(wishlistScale)
                ) {
                    Icon(
                        imageVector = if (isInWishlist) Icons.Filled.Favorite else Icons.Filled.FavoriteBorder,
                        contentDescription = if (isInWishlist) "Remove from Wishlist" else "Add to Wishlist",
                        tint = if (isInWishlist) ErrorRed else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }

                // ✅ Fixed: use AutoMirrored List icon
                IconButton(onClick = onNavigateToWishlist) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.List,
                        contentDescription = "View Wishlist"
                    )
                }
            }
        )

        // Scrollable layout for product details
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
        ) {
            ProductImageSection(product)
            ProductInfoColumn(
                product = product,
                quantity = quantity,
                onQuantityChange = { quantity = it },
                addToCartScale = addToCartScale,
                onNavigateToCart = {
                    isAddToCartPressed = true
                    onNavigateToCart()
                },
                scrollState = scrollState
            )
        }
    }
}

@Composable
private fun ProductImageSection(product: com.example.aurascents.data.Product) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(220.dp)
            .clip(RoundedCornerShape(12.dp))
    ) {
        if (product.imageResId != null) {
            Image(
                painter = painterResource(product.imageResId),
                contentDescription = product.name,
                modifier = Modifier.fillMaxSize(),
                contentScale = ContentScale.Fit
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
}

@Composable
private fun ProductInfoColumn(
    product: com.example.aurascents.data.Product,
    quantity: Int,
    onQuantityChange: (Int) -> Unit,
    addToCartScale: Float,
    onNavigateToCart: () -> Unit,
    scrollState: androidx.compose.foundation.ScrollState
) {
    Column(
        modifier = Modifier
            .padding(16.dp)
            .verticalScroll(scrollState),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
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
            Row(verticalAlignment = Alignment.CenterVertically) {
                Icon(
                    imageVector = Icons.Filled.Star,
                    contentDescription = "Rating",
                    tint = AuraGold,
                    modifier = Modifier.size(20.dp)
                )
                Spacer(Modifier.width(4.dp))
                Text(
                    text = String.format(Locale.getDefault(), "%.1f", product.rating),
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

        Text(
            text = formatLkr(product.price),
            style = MaterialTheme.typography.headlineLarge,
            fontWeight = FontWeight.Bold,
            color = MaterialTheme.colorScheme.primary
        )

        Text(
            text = product.description,
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            lineHeight = MaterialTheme.typography.bodyLarge.lineHeight
        )

        Card(
            modifier = Modifier.fillMaxWidth(),
            shape = RoundedCornerShape(12.dp),
            colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceVariant)
        ) {
            Column(Modifier.padding(16.dp)) {
                Text(
                    text = "Fragrance Notes",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(Modifier.height(8.dp))
                Text(
                    text = product.notes,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "Quantity",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
            QuantityStepper(
                quantity = quantity,
                onQuantityChange = onQuantityChange,
                minQuantity = 1,
                maxQuantity = 10
            )
        }

        Button(
            onClick = onNavigateToCart,
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
                .scale(addToCartScale),
            shape = RoundedCornerShape(16.dp)
        ) {
            Icon(
                imageVector = Icons.Filled.ShoppingCart,
                contentDescription = "Add to Cart",
                modifier = Modifier.size(20.dp)
            )
            Spacer(Modifier.width(8.dp))
            Text(
                text = "Add to Cart - ${formatLkr(product.price * quantity)}",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
        }

        OutlinedButton(
            onClick = { /* TODO: navigate to checkout */ },
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            shape = RoundedCornerShape(16.dp)
        ) {
            Text(
                "Buy Now",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
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
