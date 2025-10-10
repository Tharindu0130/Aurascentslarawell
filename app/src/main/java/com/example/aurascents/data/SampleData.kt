package com.example.aurascents.data

import com.example.aurascents.R
import java.util.Date

val sampleProducts = listOf(
    Product(
        id = "1",
        name = "Chanel No. 5",
        price = 24500.0,
        originalPrice = 26900.0,
        description = "The timeless floral-aldehydic icon by Chanel.",
        category = "WOMEN",
        notes = "Aldehydes, Jasmine, Rose",
        rating = 4.8f,
        reviewCount = 210,
        imageResId = R.drawable.chanel_no5
    ),
    Product(
        id = "2",
        name = "Dior Sauvage",
        price = 21500.0,
        originalPrice = 23900.0,
        description = "Fresh spicy and aromatic with ambroxan trail.",
        category = "MEN",
        notes = "Bergamot, Pepper, Ambroxan",
        rating = 4.7f,
        reviewCount = 320,
        imageResId = R.drawable.dior_sauvage
    ),
    Product(
        id = "3",
        name = "Bleu de Chanel",
        price = 23500.0,
        description = "Elegant woody aromatic signature by Chanel.",
        category = "MEN",
        notes = "Citrus, Incense, Cedar",
        rating = 4.6f,
        reviewCount = 280,
        imageResId = R.drawable.bleu_de_chanel
    ),
    Product(
        id = "4",
        name = "Gucci Bloom",
        price = 19500.0,
        description = "Rich white floral bouquet with tuberose and jasmine.",
        category = "WOMEN",
        notes = "Tuberose, Jasmine, Rangoon Creeper",
        rating = 4.5f,
        reviewCount = 190,
        imageResId = R.drawable.gucci_bloom
    ),
    Product(
        id = "5",
        name = "Tom Ford Black Orchid",
        price = 26500.0,
        originalPrice = 28900.0,
        description = "Dark, opulent floral oriental with black orchid.",
        category = "UNISEX",
        notes = "Black Orchid, Patchouli, Vanilla",
        rating = 4.6f,
        reviewCount = 240,
        imageResId = R.drawable.tom_ford_black_orchid
    ),
    Product(
        id = "6",
        name = "YSL Libre",
        price = 22500.0,
        description = "Modern lavender-vanilla contrasted with orange blossom.",
        category = "WOMEN",
        notes = "Lavender, Orange Blossom, Vanilla",
        rating = 4.4f,
        reviewCount = 170,
        imageResId = R.drawable.ysl_libre
    ),
    Product(
        id = "7",
        name = "Armani Code",
        price = 20500.0,
        description = "Smooth tonka, citrus and woods for evening wear.",
        category = "MEN",
        notes = "Citrus, Tonka, Woods",
        rating = 4.5f,
        reviewCount = 200,
        imageResId = R.drawable.armani_code
    ),
    Product(
        id = "8",
        name = "Versace Eros",
        price = 18500.0,
        description = "Fresh minty-vanilla masculine with vibrant projection.",
        category = "MEN",
        notes = "Mint, Green Apple, Vanilla",
        rating = 4.4f,
        reviewCount = 260,
        imageResId = R.drawable.versace_eros
    ),
    Product(
        id = "9",
        name = "Calvin Klein Eternity",
        price = 17500.0,
        description = "Clean, classic aromatic with citrus and florals.",
        category = "UNISEX",
        notes = "Citrus, Lavender, Floral",
        rating = 4.2f,
        reviewCount = 150,
        imageResId = R.drawable.ck_eternity
    ),
    Product(
        id = "10",
        name = "Lancôme La Vie Est Belle",
        price = 21500.0,
        description = "Gourmand iris with sweet praline and vanilla.",
        category = "WOMEN",
        notes = "Iris, Praline, Vanilla",
        rating = 4.5f,
        reviewCount = 230,
        imageResId = R.drawable.lancome_la_vie_est_belle
    ),
    Product(
        id = "11",
        name = "Paco Rabanne 1 Million",
        price = 20000.0,
        description = "Warm spicy-leathery with a sweet amber base.",
        category = "MEN",
        notes = "Cinnamon, Leather, Amber",
        rating = 4.3f,
        reviewCount = 300,
        imageResId = R.drawable.paco_rabanne_1_million
    ),
    Product(
        id = "12",
        name = "JPG Le Male",
        price = 19000.0,
        description = "Iconic barbershop mint-lavender with vanilla.",
        category = "MEN",
        notes = "Mint, Lavender, Vanilla",
        rating = 4.4f,
        reviewCount = 275,
        imageResId = R.drawable.jpg_le_male
    )
)

val sampleUser = User(
    id = "user1",
    email = "kotagoda1@gmail.com",
    name = "Tharindu Karunarathna",
    phone = "+94 77 123 4567",
    address = Address(
        street = "123 Main Street",
        city = "Colombo",
        zipCode = "00100"
    )
)

val sampleOrders = listOf(
    Order(
        id = "ORD001",
        userId = "user1",
        items = listOf(
            CartItem(sampleProducts[0], 1),
            CartItem(sampleProducts[2], 2)
        ),
        totalAmount = sampleProducts[0].price * 1 + sampleProducts[2].price * 2,
        orderDate = Date(System.currentTimeMillis() - 86400000 * 7), // 7 days ago
        status = OrderStatus.DELIVERED,
        shippingAddress = Address(
            street = "123 Main Street",
            city = "Colombo",
            zipCode = "00100"
        ),
        paymentMethod = "Credit Card"
    ),
    Order(
        id = "ORD002",
        userId = "user1",
        items = listOf(
            CartItem(sampleProducts[4], 1),
            CartItem(sampleProducts[6], 1)
        ),
        totalAmount = sampleProducts[4].price * 1 + sampleProducts[6].price * 1,
        orderDate = Date(System.currentTimeMillis() - 86400000 * 14), // 14 days ago
        status = OrderStatus.SHIPPED,
        shippingAddress = Address(
            street = "123 Main Street",
            city = "Colombo",
            zipCode = "00100"
        ),
        paymentMethod = "PayPal"
    ),
    Order(
        id = "ORD003",
        userId = "user1",
        items = listOf(
            CartItem(sampleProducts[1], 1)
        ),
        totalAmount = sampleProducts[1].price * 1,
        orderDate = Date(System.currentTimeMillis() - 86400000 * 30), // 30 days ago
        status = OrderStatus.DELIVERED,
        shippingAddress = Address(
            street = "123 Main Street",
            city = "Colombo",
            zipCode = "00100"
        ),
        paymentMethod = "Credit Card"
    )
)

val sampleWishlist = listOf(
    WishlistItem(sampleProducts[3]),
    WishlistItem(sampleProducts[5]),
    WishlistItem(sampleProducts[7])
)

