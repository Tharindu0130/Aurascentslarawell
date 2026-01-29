import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        children: [
          // Contact Support Section
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Support',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Having trouble? Our support team is here to help.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.email),
                    label: const Text('Email Support'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FAQ Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // FAQ Items
          ExpansionTile(
            title: const Text('How do I reset my password?'),
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'To reset your password, go to the login screen and tap on "Forgot Password". Enter your email address and follow the instructions sent to your inbox.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: const Text('How do I track my order?'),
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'You can track your order by going to the Profile section and selecting "Order History". Here you will find all your orders with their current status.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: const Text('Can I return a product?'),
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Yes, you can return products within 30 days of purchase. Please contact our support team for assistance with the return process.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: const Text('How do I update my shipping address?'),
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Go to your Profile section, tap on "Edit Profile", and you can update your shipping address information.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          ExpansionTile(
            title: const Text('What payment methods do you accept?'),
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'We accept all major credit cards including Visa, Mastercard, and American Express. We also support PayPal and Apple Pay.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          // Tips Section
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tips for Using the App',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTip('• Use the search bar to quickly find specific perfumes'),
                  _buildTip('• Add items to your wishlist to save them for later'),
                  _buildTip('• Check your cart regularly for special offers'),
                  _buildTip('• Enable notifications to stay updated on sales'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(tip, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}