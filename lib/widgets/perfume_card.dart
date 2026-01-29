import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/perfume.dart';
import '../providers/app_state.dart';
import 'cached_perfume_image.dart';

class PerfumeCard extends StatelessWidget {
  final Perfume perfume;

  const PerfumeCard({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/perfume-detail',
            arguments: perfume,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Perfume Image
                  Positioned.fill(
                    child: CachedPerfumeImage(
                      imageUrl: perfume.imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  
                  // Overlay Controls
                  Positioned.fill(
                    child: Stack(
                  children: [
                    // Wishlist Button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer<AppState>(
                        builder: (context, appState, _) {
                          final isInWishlist = appState.isInWishlist(perfume.id);
                          return GestureDetector(
                            onTap: () {
                              appState.toggleWishlist(perfume);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isInWishlist 
                                        ? 'Removed from wishlist' 
                                        : 'Added to wishlist'
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isInWishlist ? Icons.favorite : Icons.favorite_border,
                                color: isInWishlist ? Colors.red : Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Cart Button
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Consumer<AppState>(
                        builder: (context, appState, _) {
                          final isInCart = appState.isInCart(perfume.id);
                          return GestureDetector(
                            onTap: () {
                              if (isInCart) {
                                appState.removeFromCart(perfume.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from cart'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                appState.addToCart(perfume);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to cart'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                                color: isInCart ? Theme.of(context).colorScheme.primary : Colors.grey[600]!,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Stock Status
                    if (!perfume.isAvailable)
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Brand
                    Text(
                      perfume.brand,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 2),
                    
                    // Name
                    Flexible(
                      child: Text(
                        perfume.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Rating
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < perfume.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 11,
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${perfume.reviewCount})',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Price
                    Text(
                      '\$${perfume.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}