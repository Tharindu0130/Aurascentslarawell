import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/perfume.dart';
import '../providers/cart_provider.dart';
import '../utils/theme.dart';

class PerfumeCard extends StatelessWidget {
  final Perfume perfume;

  const PerfumeCard({Key? key, required this.perfume}) : super(key: key);

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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(perfume.imageUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Handle image loading error
                    },
                  ),
                ),
                child: Stack(
                  children: [
                    // Favorite Button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, _) {
                          final isInCart = cartProvider.isInCart(perfume.id);
                          return GestureDetector(
                            onTap: () {
                              if (isInCart) {
                                cartProvider.removeFromCart(perfume.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from cart'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                cartProvider.addToCart(perfume);
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
                                isInCart ? Icons.favorite : Icons.favorite_border,
                                color: isInCart ? Colors.red : Colors.grey[600],
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
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Text(
                      perfume.brand,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 2),
                    
                    // Name
                    Text(
                      perfume.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                              size: 12,
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${perfume.reviewCount})',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Price
                    Text(
                      '\$${perfume.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
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