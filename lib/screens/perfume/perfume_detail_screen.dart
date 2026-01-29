import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/perfume.dart';
import '../../providers/app_state.dart';
import '../../widgets/cached_perfume_image.dart';

class PerfumeDetailScreen extends StatelessWidget {
  final dynamic perfume;

  const PerfumeDetailScreen({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    final Perfume perfumeData = perfume as Perfume;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'perfume-${perfumeData.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedPerfumeImage(
                      imageUrl: perfumeData.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Consumer<AppState>(
                builder: (context, appState, _) {
                  return IconButton(
                    icon: Icon(
                      appState.isInWishlist(perfumeData.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: appState.isInWishlist(perfumeData.id)
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      if (appState.isInWishlist(perfumeData.id)) {
                        appState.removeFromWishlist(perfumeData.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Removed from wishlist'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        appState.addToWishlist(perfumeData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to wishlist'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and Name
                  Text(
                    perfumeData.brand,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    perfumeData.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Rating and Reviews
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < perfumeData.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${perfumeData.rating} (${perfumeData.reviewCount} reviews)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${perfumeData.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: perfumeData.isAvailable
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: perfumeData.isAvailable
                                ? Colors.green[300]!
                                : Colors.red[300]!,
                          ),
                        ),
                        child: Text(
                          perfumeData.isAvailable ? 'In Stock' : 'Out of Stock',
                          style: TextStyle(
                            color: perfumeData.isAvailable ? Colors.green[700] : Colors.red[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    perfumeData.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Notes
                  Text(
                    'Fragrance Notes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: perfumeData.notes.map((note) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          note,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Consumer<AppState>(
          builder: (context, appState, _) {
            final isInCart = appState.isInCart(perfumeData.id);
            final quantity = appState.getCartQuantity(perfumeData.id);
            
            return Row(
              children: [
                if (isInCart) ...[
                  // Quantity Controls
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              appState.updateCartQuantity(perfumeData.id, quantity - 1);
                            } else {
                              appState.removeFromCart(perfumeData.id);
                            }
                          },
                          icon: Icon(
                            quantity > 1 ? Icons.remove : Icons.delete,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            appState.updateCartQuantity(perfumeData.id, quantity + 1);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                
                // Add to Cart / View Cart Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: perfumeData.isAvailable
                        ? () {
                            if (isInCart) {
                              Navigator.of(context).pushNamed('/cart');
                            } else {
                              appState.addToCart(perfumeData);
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      isInCart ? 'View Cart' : 'Add to Cart',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}