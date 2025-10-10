package com.example.aurascents

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHostState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.example.aurascents.navigation.AuraScentsNavGraph
import com.example.aurascents.ui.components.AuraScentsSnackbarHost
import com.example.aurascents.ui.theme.AuraScentsTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("AuraScents", "MainActivity onCreate started")

        try {
            enableEdgeToEdge() // keeps content under status/navigation bars
            Log.d("AuraScents", "EdgeToEdge enabled successfully")

            setContent {
                Log.d("AuraScents", "Setting content with AuraScentsApp")
                AuraScentsApp()
            }
            Log.d("AuraScents", "MainActivity onCreate completed successfully")
        } catch (e: Exception) {
            Log.e("AuraScents", "Error in MainActivity onCreate", e)
            throw e
        }
    }
}

@Composable
fun AuraScentsApp() {
    Log.d("AuraScents", "AuraScentsApp composable started")
    AuraScentsTheme {
        Log.d("AuraScents", "AuraScentsTheme applied, initializing NavGraph")
        AuraScentsNavGraph()
    }
    Log.d("AuraScents", "AuraScentsApp composable completed successfully")
}
