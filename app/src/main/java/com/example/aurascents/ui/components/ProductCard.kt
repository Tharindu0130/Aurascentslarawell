package com.example.aurascents.ui.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.FavoriteBorder
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
// removed duplicate Alignment import
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.res.painterResource
import com.example.aurascents.data.Product
import com.example.aurascents.data.sampleProducts
import com.example.aurascents.ui.theme.*
import com.example.aurascents.ui.utils.formatLkr

@Composable
fun ProductCard(
    product: Product,
    onProductClick: (String) -> Unit,
    onWishlistToggle: (String) -> Unit = {},
    isInWishlist: Boolean = false,
    modifier: Modifier = Modifier
) {
    var isWishlistPressed by remember { mutableStateOf(false) }
    
    val wishlistScale by animateFloatAsState(
        targetValue = if (isWishlistPressed) 0.8f else 1f,
        animationSpec = tween(100),
        label = "wishlist_scale"
    )
    
    Card(
        modifier = modifier
            .fillMaxWidth()
            .clickable { onProductClick(product.id) },
        shape = RoundedCornerShape(12.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier.padding(12.dp)
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(1f) // keep image area square to avoid clipping across sizes
            ) {
                if (product.imageResId != null) {
                    androidx.compose.foundation.Image(
                        painter = painterResource(product.imageResId),
                        contentDescription = product.name,
                        modifier = Modifier
                            .fillMaxSize()
                            .clip(RoundedCornerShape(8.dp)),
                        contentScale = ContentScale.Fit
                    )
                } else {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .clip(RoundedCornerShape(8.dp))
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
                            style = MaterialTheme.typography.headlineMedium,
                            fontWeight = FontWeight.Bold,
                            color = when (product.category) {
                                "MEN" -> MenFragrance
                                "WOMEN" -> WomenFragrance
                                else -> UnisexFragrance
                            }
                        )
                    }
                }
                
                // Wishlist Button
                IconButton(
                    onClick = {
                        isWishlistPressed = true
                        onWishlistToggle(product.id)
                    },
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .scale(wishlistScale)
                ) {
                    Icon(
                        imageVector = if (isInWishlist) Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                        contentDescription = "Add to Wishlist",
                        tint = if (isInWishlist) ErrorRed else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                
                // Category Badge
                Surface(
                    modifier = Modifier
                        .align(Alignment.TopStart)
                        .padding(8.dp),
                    shape = RoundedCornerShape(12.dp),
                    color = when (product.category) {
                        "MEN" -> MenFragrance
                        "WOMEN" -> WomenFragrance
                        else -> UnisexFragrance
                    }
                ) {
                    Text(
                        text = product.category,
                        modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp),
                        style = MaterialTheme.typography.labelSmall,
                        color = Color.White
                    )
                }
            }
            
            Spacer(modifier = Modifier.height(8.dp))
            
            // Product Name
            Text(
                text = product.name,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
            
            Spacer(modifier = Modifier.height(4.dp))
            
            // Product Notes
            Text(
                text = product.notes,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                maxLines = 2,
                overflow = TextOverflow.Ellipsis
            )
            
            Spacer(modifier = Modifier.height(8.dp))
            
            // Price Row
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = formatLkr(product.price),
                        style = MaterialTheme.typography.titleLarge,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.primary
                    )
                }
                
                // Removed side rating block for cleaner alignment
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun ProductCardPreview() {
    AuraScentsTheme {
        ProductCard(
            product = sampleProducts[0],
            onProductClick = {},
            onWishlistToggle = {},
            isInWishlist = false
        )
    }
}

