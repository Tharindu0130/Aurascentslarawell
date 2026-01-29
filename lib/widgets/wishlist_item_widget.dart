import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/wishlist_item.dart';
import '../providers/app_state.dart';

class WishlistItemWidget extends StatelessWidget {
  final WishlistItem wishlistItem;

  const WishlistItemWidget({super.key, required this.wishlistItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/perfume-detail',
            arguments: wishlistItem.perfume,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(wishlistItem.perfume.imageUrl),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        // Handle image loading error
                      },
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wishlistItem.perfume.brand,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      wishlistItem.perfume.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${wishlistItem.perfume.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Rating
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < wishlistItem.perfume.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 14,
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${wishlistItem.perfume.rating}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Added date
                    Text(
                      'Added ${_formatDate(wishlistItem.addedAt)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Action Buttons
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add to Cart Button
                  Consumer<AppState>(
                    builder: (context, appState, _) {
                      final isInCart = appState.isInCart(wishlistItem.perfume.id);
                      
                      return ElevatedButton(
                        onPressed: wishlistItem.perfume.isAvailable
                            ? () {
                                if (isInCart) {
                                  Navigator.of(context).pushNamed('/cart');
                                } else {
                                  appState.addToCart(wishlistItem.perfume);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to cart'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          minimumSize: const Size(80, 32),
                        ),
                        child: Text(
                          isInCart ? 'In Cart' : 'Add to Cart',
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Remove from Wishlist Button
                  OutlinedButton(
                    onPressed: () {
                      _showRemoveDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      minimumSize: const Size(80, 32),
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showRemoveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove from Wishlist'),
          content: Text('Remove ${wishlistItem.perfume.name} from your wishlist?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<AppState>().removeFromWishlist(wishlistItem.perfume.id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Removed from wishlist'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                'Remove',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}