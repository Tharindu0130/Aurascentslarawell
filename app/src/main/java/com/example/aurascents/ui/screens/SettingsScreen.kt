package com.example.aurascents.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.clickable
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.aurascents.ui.theme.*
import androidx.compose.foundation.layout.BoxWithConstraints

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsScreen(
    onNavigateBack: () -> Unit,
    modifier: Modifier = Modifier
) {
    var isDarkTheme by remember { mutableStateOf(false) }
    var notificationsEnabled by remember { mutableStateOf(true) }
    var emailNotifications by remember { mutableStateOf(true) }
    var pushNotifications by remember { mutableStateOf(true) }
    var locationEnabled by remember { mutableStateOf(false) }
    
    val scrollState = rememberScrollState()
    
    BoxWithConstraints(modifier = modifier.fillMaxSize()) {
        val landscape = maxWidth > maxHeight
        
        Column(
            modifier = Modifier.fillMaxSize()
        ) {
        // Top App Bar
        TopAppBar(
            title = { Text("Settings") },
            navigationIcon = {
                IconButton(onClick = onNavigateBack) {
                    Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                }
            }
        )
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(if (landscape) 20.dp else 16.dp),
            verticalArrangement = Arrangement.spacedBy(if (landscape) 12.dp else 16.dp)
        ) {
            // Appearance Section
            SettingsSection(
                title = "Appearance",
                icon = Icons.Default.ColorLens
            ) {
                SettingsItem(
                    title = "Dark Theme",
                    subtitle = "Use dark theme for the app",
                    icon = Icons.Default.Nightlight,
                    trailing = {
                        Switch(
                            checked = isDarkTheme,
                            onCheckedChange = { isDarkTheme = it }
                        )
                    }
                )
            }
            
            // Notifications Section
            SettingsSection(
                title = "Notifications",
                icon = Icons.Default.Notifications
            ) {
                SettingsItem(
                    title = "Enable Notifications",
                    subtitle = "Receive app notifications",
                    icon = Icons.Default.Notifications,
                    trailing = {
                        Switch(
                            checked = notificationsEnabled,
                            onCheckedChange = { notificationsEnabled = it }
                        )
                    }
                )
                
                if (notificationsEnabled) {
                    SettingsItem(
                        title = "Email Notifications",
                        subtitle = "Get updates via email",
                        icon = Icons.Default.Email,
                        trailing = {
                            Switch(
                                checked = emailNotifications,
                                onCheckedChange = { emailNotifications = it }
                            )
                        }
                    )
                    
                    SettingsItem(
                        title = "Push Notifications",
                        subtitle = "Receive push notifications",
                        icon = Icons.Default.Phone,
                        trailing = {
                            Switch(
                                checked = pushNotifications,
                                onCheckedChange = { pushNotifications = it }
                            )
                        }
                    )
                }
            }
            
            // Privacy Section
            SettingsSection(
                title = "Privacy & Security",
                icon = Icons.Default.Lock,
            ) {
                SettingsItem(
                    title = "Location Services",
                    subtitle = "Allow location access for better recommendations",
                    icon = Icons.Default.LocationOn,
                    trailing = {
                        Switch(
                            checked = locationEnabled,
                            onCheckedChange = { locationEnabled = it }
                        )
                    }
                )
                
                SettingsItem(
                    title = "Privacy Policy",
                    subtitle = "View our privacy policy",
                    icon = Icons.Default.Policy,
                    onClick = { /* Navigate to privacy policy */ }
                )
                
                SettingsItem(
                    title = "Terms of Service",
                    subtitle = "View terms and conditions",
                    icon = Icons.Default.Info,
                    onClick = { /* Navigate to terms */ }
                )
            }
            
            // Account Section
            SettingsSection(
                title = "Account",
                icon = Icons.Default.Person
            ) {
                SettingsItem(
                    title = "Edit Profile",
                    subtitle = "Update your personal information",
                    icon = Icons.Default.Edit,
                    onClick = { /* Navigate to edit profile */ }
                )
                
                SettingsItem(
                    title = "Change Password",
                    subtitle = "Update your password",
                    icon = Icons.Default.Lock,
                    onClick = { /* Navigate to change password */ }
                )
                
                SettingsItem(
                    title = "Delete Account",
                    subtitle = "Permanently delete your account",
                    icon = Icons.Default.Delete,
                    onClick = { /* Show delete confirmation */ },
                    textColor = ErrorRed
                )
            }
            
            // Support Section
            SettingsSection(
                title = "Support",
                icon = Icons.Default.Help
            ) {
                SettingsItem(
                    title = "Help Center",
                    subtitle = "Get help and support",
                    icon = Icons.Default.HelpOutline,
                    onClick = { /* Navigate to help */ }
                )
                
                SettingsItem(
                    title = "Contact Us",
                    subtitle = "Send us feedback or report issues",
                    icon = Icons.Default.Email,
                    onClick = { /* Navigate to contact */ }
                )
                
                SettingsItem(
                    title = "Rate App",
                    subtitle = "Rate us on the Play Store",
                    icon = Icons.Default.Star,
                    onClick = { /* Open Play Store */ }
                )
            }
            
            // App Info Section
            SettingsSection(
                title = "About",
                icon = Icons.Default.Info
            ) {
                SettingsItem(
                    title = "App Version",
                    subtitle = "1.0.0",
                    icon = Icons.Default.Info,
                    onClick = { /* Show version info */ }
                )
                
                SettingsItem(
                    title = "Open Source Licenses",
                    subtitle = "View third-party licenses",
                    icon = Icons.Default.Code,
                    onClick = { /* Show licenses */ }
                )
            }
        }
        }
    }
}

@Composable
private fun SettingsSection(
    title: String,
    icon: ImageVector,
    content: @Composable () -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.padding(bottom = 12.dp)
            ) {
                Icon(
                    imageVector = icon,
                    contentDescription = title,
                    tint = MaterialTheme.colorScheme.primary,
                    modifier = Modifier.size(20.dp)
                )
                Spacer(modifier = Modifier.width(12.dp))
                Text(
                    text = title,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold,
                    color = MaterialTheme.colorScheme.onSurface
                )
            }
            
            content()
        }
    }
}

@Composable
private fun SettingsItem(
    title: String,
    subtitle: String,
    icon: ImageVector,
    onClick: (() -> Unit)? = null,
    trailing: @Composable (() -> Unit)? = null,
    textColor: androidx.compose.ui.graphics.Color = MaterialTheme.colorScheme.onSurface,
    modifier: Modifier = Modifier
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .let { 
                if (onClick != null) it.clickable { onClick() } else it
            }
            .padding(vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            imageVector = icon,
            contentDescription = title,
            tint = MaterialTheme.colorScheme.onSurfaceVariant,
            modifier = Modifier.size(20.dp)
        )
        
        Spacer(modifier = Modifier.width(16.dp))
        
        Column(
            modifier = Modifier.weight(1f)
        ) {
            Text(
                text = title,
                style = MaterialTheme.typography.bodyLarge,
                fontWeight = FontWeight.Medium,
                color = textColor
            )
            Text(
                text = subtitle,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        
        trailing?.invoke() ?: run {
            if (onClick != null) {
                Icon(
                    imageVector = Icons.Default.KeyboardArrowRight,
                    contentDescription = "Navigate",
                    tint = MaterialTheme.colorScheme.onSurfaceVariant,
                    modifier = Modifier.size(20.dp)
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun SettingsScreenPreview() {
    AuraScentsTheme {
        SettingsScreen(
            onNavigateBack = {}
        )
    }
}

