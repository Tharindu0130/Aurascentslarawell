package com.example.aurascents.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

// Light color scheme
private val LightColors = lightColorScheme(
    primary = Color(0xFF7C580D),
    onPrimary = Color.White,
    primaryContainer = Color(0xFFFFDEAC),
    onPrimaryContainer = Color(0xFF604100),
    secondary = Color(0xFF6E5C40),
    onSecondary = Color.White,
    background = Color(0xFFFFFBFF),
    surface = Color(0xFFFFFBFF)
)

// Dark color scheme
private val DarkColors = darkColorScheme(
    primary = Color(0xFFE0BB74),
    onPrimary = Color(0xFF402D00),
    primaryContainer = Color(0xFF5A4100),
    onPrimaryContainer = Color(0xFFFFDEAC),
    secondary = Color(0xFFDDBE8E),
    onSecondary = Color(0xFF3E2E12),
    background = Color(0xFF1C1B17),
    surface = Color(0xFF1C1B17)
)

// ✅ Main theme composable
@Composable
fun AuraScentsTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) DarkColors else LightColors

    MaterialTheme(
        colorScheme = colorScheme,
        typography = AppTypography, // from Type.kt
        content = content
    )
}
