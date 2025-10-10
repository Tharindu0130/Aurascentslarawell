package com.example.aurascents.ui.theme

import androidx.compose.material3.Typography
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.font.FontStyle

// Use system fonts with proper Material 3 typography
val bodyFontFamily = FontFamily.Default
val displayFontFamily = FontFamily.Default

// Base Material 3 typography with proper font weights
val baseline = Typography()

// Apply proper typography with appropriate font weights
val AppTypography = Typography(
    displayLarge = baseline.displayLarge.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.Normal
    ),
    displayMedium = baseline.displayMedium.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.Normal
    ),
    displaySmall = baseline.displaySmall.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.Normal
    ),
    headlineLarge = baseline.headlineLarge.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.SemiBold
    ),
    headlineMedium = baseline.headlineMedium.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.SemiBold
    ),
    headlineSmall = baseline.headlineSmall.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.SemiBold
    ),
    titleLarge = baseline.titleLarge.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.Medium
    ),
    titleMedium = baseline.titleMedium.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.Medium
    ),
    titleSmall = baseline.titleSmall.copy(
        fontFamily = displayFontFamily,
        fontWeight = FontWeight.Medium
    ),
    bodyLarge = baseline.bodyLarge.copy(
        fontFamily = bodyFontFamily,
        fontWeight = FontWeight.Normal
    ),
    bodyMedium = baseline.bodyMedium.copy(
        fontFamily = bodyFontFamily,
        fontWeight = FontWeight.Normal
    ),
    bodySmall = baseline.bodySmall.copy(
        fontFamily = bodyFontFamily,
        fontWeight = FontWeight.Normal
    ),
    labelLarge = baseline.labelLarge.copy(
        fontFamily = bodyFontFamily,
        fontWeight = FontWeight.Medium
    ),
    labelMedium = baseline.labelMedium.copy(
        fontFamily = bodyFontFamily,
        fontWeight = FontWeight.Medium
    ),
    labelSmall = baseline.labelSmall.copy(
        fontFamily = bodyFontFamily,
        fontWeight = FontWeight.Medium
    )
)
