package com.example.aurascents.ui.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Remove
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.aurascents.ui.theme.AuraScentsTheme

@Composable
fun QuantityStepper(
    quantity: Int,
    onQuantityChange: (Int) -> Unit,
    modifier: Modifier = Modifier,
    minQuantity: Int = 1,
    maxQuantity: Int = 99
) {
    var isDecreasePressed by remember { mutableStateOf(false) }
    var isIncreasePressed by remember { mutableStateOf(false) }
    
    val decreaseScale by animateFloatAsState(
        targetValue = if (isDecreasePressed) 0.8f else 1f,
        animationSpec = tween(100),
        label = "decrease_scale"
    )
    
    val increaseScale by animateFloatAsState(
        targetValue = if (isIncreasePressed) 0.8f else 1f,
        animationSpec = tween(100),
        label = "increase_scale"
    )
    
    Row(
        modifier = modifier,
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        // Decrease Button
        Box(
            modifier = Modifier
                .size(32.dp)
                .scale(decreaseScale)
                .clip(CircleShape)
                .background(
                    if (quantity > minQuantity) MaterialTheme.colorScheme.primary
                    else MaterialTheme.colorScheme.surfaceVariant
                )
                .clickable(enabled = quantity > minQuantity) {
                    isDecreasePressed = true
                    onQuantityChange(quantity - 1)
                },
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = Icons.Default.Remove,
                contentDescription = "Decrease",
                tint = if (quantity > minQuantity) MaterialTheme.colorScheme.onPrimary
                else MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier.size(16.dp)
            )
        }
        
        // Quantity Display
        Surface(
            modifier = Modifier
                .width(48.dp)
                .height(32.dp),
            shape = RoundedCornerShape(8.dp),
            color = MaterialTheme.colorScheme.surfaceVariant,
            border = androidx.compose.foundation.BorderStroke(
                1.dp,
                MaterialTheme.colorScheme.outline
            )
        ) {
            Box(
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = quantity.toString(),
                    style = MaterialTheme.typography.bodyMedium,
                    fontWeight = FontWeight.Medium,
                    color = MaterialTheme.colorScheme.onSurface
                )
            }
        }
        
        // Increase Button
        Box(
            modifier = Modifier
                .size(32.dp)
                .scale(increaseScale)
                .clip(CircleShape)
                .background(
                    if (quantity < maxQuantity) MaterialTheme.colorScheme.primary
                    else MaterialTheme.colorScheme.surfaceVariant
                )
                .clickable(enabled = quantity < maxQuantity) {
                    isIncreasePressed = true
                    onQuantityChange(quantity + 1)
                },
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = Icons.Default.Add,
                contentDescription = "Increase",
                tint = if (quantity < maxQuantity) MaterialTheme.colorScheme.onPrimary
                else MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier.size(16.dp)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun QuantityStepperPreview() {
    AuraScentsTheme {
        Row(
            modifier = Modifier.padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            QuantityStepper(
                quantity = 2,
                onQuantityChange = {},
                minQuantity = 1,
                maxQuantity = 10
            )
            
            QuantityStepper(
                quantity = 1,
                onQuantityChange = {},
                minQuantity = 1,
                maxQuantity = 5
            )
            
            QuantityStepper(
                quantity = 5,
                onQuantityChange = {},
                minQuantity = 1,
                maxQuantity = 5
            )
        }
    }
}

