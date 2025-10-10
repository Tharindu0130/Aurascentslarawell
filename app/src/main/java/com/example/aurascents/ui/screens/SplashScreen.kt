package com.example.aurascents.ui.screens

import android.util.Log
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.aurascents.R
import com.example.aurascents.ui.theme.*
import kotlinx.coroutines.delay

@Composable
fun SplashScreen(
    onNavigateToLogin: () -> Unit,
    modifier: Modifier = Modifier
) {
    Log.d("AuraScents", "SplashScreen composable started")
    var startAnimation by remember { mutableStateOf(false) }
    val alphaAnim by animateFloatAsState(
        targetValue = if (startAnimation) 1f else 0f,
        animationSpec = tween(1000),
        label = "alpha_anim"
    )
    val scaleAnim by animateFloatAsState(
        targetValue = if (startAnimation) 1f else 0.3f,
        animationSpec = tween(1000),
        label = "scale_anim"
    )
    
    LaunchedEffect(Unit) {
        Log.d("AuraScents", "SplashScreen LaunchedEffect started")
        startAnimation = true
        Log.d("AuraScents", "SplashScreen animation started")
        delay(3000) // Show splash for 3 seconds
        Log.d("AuraScents", "SplashScreen delay completed, navigating to login")
        onNavigateToLogin()
    }
    
    Log.d("AuraScents", "SplashScreen: About to render Box")
    Box(
        modifier = modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    colors = listOf(
                        AuraGold.copy(alpha = 0.1f),
                        AuraWhite
                    )
                )
            ),
        contentAlignment = Alignment.Center
    ) {
        Log.d("AuraScents", "SplashScreen: Box rendered, adding content")
        // Splash Screen Image Only
        Image(
            painter = painterResource(id = R.drawable.splashscreen),
            contentDescription = "AuraScents Splash Screen",
            modifier = Modifier
                .size(250.dp)
                .scale(scaleAnim)
                .alpha(alphaAnim)
                .clip(RoundedCornerShape(16.dp)),
            contentScale = ContentScale.Fit
        )
    }
    Log.d("AuraScents", "SplashScreen composable completed successfully")
}

@Preview(showBackground = true)
@Composable
fun SplashScreenPreview() {
    AuraScentsTheme {
        SplashScreen(
            onNavigateToLogin = {}
        )
    }
}

