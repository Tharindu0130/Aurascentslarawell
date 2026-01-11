import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/location_provider.dart';
import '../../utils/theme.dart';
import '../../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              if (cartProvider.items.isNotEmpty) {
                return TextButton(
                  onPressed: () {
                    _showClearCartDialog(context, cartProvider);
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          if (cartProvider.items.isEmpty) {
            return const _EmptyCartWidget();
          }

          return Column(
            children: [
              // Cart Items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CartItemWidget(cartItem: cartItem),
                    );
                  },
                ),
              ),
              
              // Cart Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Items: ${cartProvider.itemCount}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showCheckoutDialog(context, cartProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text('Are you sure you want to remove all items from your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                cartProvider.clearCart();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cart cleared'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCheckoutDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text('Items: ${cartProvider.itemCount}'),
              const SizedBox(height: 16),
              const Text('This is a demo app. In a real application, this would integrate with a payment gateway.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Simulate order placement
                cartProvider.clearCart();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully! (Demo)'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyCartWidget extends StatelessWidget {
  const _EmptyCartWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some perfumes to get started',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home tab
              // This assumes the cart screen is part of a bottom navigation
            },
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }
}