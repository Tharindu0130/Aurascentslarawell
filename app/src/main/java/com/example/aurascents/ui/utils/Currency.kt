package com.example.aurascents.ui.utils

import java.text.NumberFormat
import java.util.Locale

fun formatLkr(amount: Double): String {
    val locale = Locale("en", "LK")
    val formatter = NumberFormat.getNumberInstance(locale)
    formatter.maximumFractionDigits = if (amount % 1.0 == 0.0) 0 else 2
    val formatted = formatter.format(amount)
    return "Rs $formatted"
}


