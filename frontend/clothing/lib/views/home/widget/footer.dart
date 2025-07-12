import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: const Color(0xFFF6F4F0),
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 40,
                  runSpacing: 32,
                  children: [
                    const SizedBox(
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.refreshCw, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'ReWear',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Making fashion sustainable, one swap at a time. Join our community and give your clothes a second life.',
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(LucideIcons.facebook),
                              SizedBox(width: 8),
                              Icon(LucideIcons.twitter),
                              SizedBox(width: 8),
                              Icon(LucideIcons.instagram),
                              SizedBox(width: 8),
                              Icon(LucideIcons.mail),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const _FooterColumn(
                      title: 'Platform',
                      items: [
                        'Browse Items',
                        'List an Item',
                        'How It Works',
                        'Pricing',
                      ],
                    ),
                    const _FooterColumn(
                      title: 'Community',
                      items: ['Success Stories', 'Blog', 'Forum', 'Events'],
                    ),
                    const _FooterColumn(
                      title: 'Support',
                      items: [
                        'Help Center',
                        'Safety Guidelines',
                        'Contact Us',
                        'Privacy Policy',
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  '© 2024 ReWear. All rights reserved. Made with 💚 for a sustainable future.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(e, style: const TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }
}
