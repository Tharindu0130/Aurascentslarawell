package com.example.aurascents.ui.util

import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.asPaddingValues
import androidx.compose.foundation.layout.systemBars
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

/**
 * Lightweight responsive helpers for Compose screens.
 */
object Responsive {
    @Composable
    fun isLandscape(content: @Composable (Boolean) -> Unit) {
        BoxWithConstraints {
            val landscape = maxWidth > maxHeight
            content(landscape)
        }
    }

    @Composable
    fun paddings(landscape: Boolean): PaddingValues {
        return if (landscape) PaddingValues(20.dp) else PaddingValues(16.dp)
    }

    @Composable
    fun horizontalContentWidthFraction(landscape: Boolean): Float {
        // In landscape, constrain content to ~65% width for readability
        return if (landscape) 0.65f else 1f
    }
}

@Composable
fun systemBarsPaddingValues(): PaddingValues = WindowInsets.systemBars.asPaddingValues()

fun Modifier.ifThen(condition: Boolean, then: Modifier.() -> Modifier): Modifier {
    return if (condition) then(this) else this
}


