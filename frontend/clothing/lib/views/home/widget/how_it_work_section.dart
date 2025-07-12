import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HowReWearWorksSection extends StatelessWidget {
  const HowReWearWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'icon': LucideIcons.upload,
        'step': 'Step 1',
        'title': 'List Your Items',
        'desc':
            'Upload photos and details of clothes you no longer wear. Get approval from our community moderators.',
      },
      {
        'icon': LucideIcons.users,
        'step': 'Step 2',
        'title': 'Connect & Swap',
        'desc':
            'Browse items from other users and request swaps. Chat with other members to arrange exchanges.',
      },
      {
        'icon': LucideIcons.coins,
        'step': 'Step 3',
        'title': 'Earn Points',
        'desc':
            'Get points for every successful swap or listing. Use points to redeem items without swapping.',
      },
      {
        'icon': LucideIcons.recycle,
        'step': 'Step 4',
        'title': 'Make Impact',
        'desc':
            'Track your environmental impact and celebrate your contribution to sustainable fashion.',
      },
    ];

    return Row(
      children: [
        Expanded(
          child: Container(
            color: const Color(0xFFFAF9F7),
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
            child: Column(
              children: [
                const Text(
                  'How ReWear Works',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B4332),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Join thousands of users in creating a more sustainable fashion future, one swap at a time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children:
                      steps.map((step) {
                        return Container(
                          width: 260,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFE6F4EA),
                                child: Icon(
                                  (step['icon'] ?? Icons.question_mark)
                                      as IconData?,
                                  color: const Color(0xFF2C6E49),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                step['step'].toString(),
                                style: const TextStyle(
                                  color: Color(0xFF2C6E49),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                step['title'].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                step['desc'].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
