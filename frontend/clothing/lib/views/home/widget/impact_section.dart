import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ImpactSection extends StatelessWidget {
  const ImpactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: const Color(0xFF1D5C46),
                padding: const EdgeInsets.symmetric(
                  vertical: 64,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Our Growing Impact',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Together, we're making a real difference in sustainable fashion and reducing clothing waste.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 40,
                      runSpacing: 40,
                      children: const [
                        _ImpactStat(
                          icon: LucideIcons.users,
                          value: '12,500+',
                          label: 'Active Members',
                          desc:
                              'Growing community of sustainable fashion enthusiasts',
                        ),
                        _ImpactStat(
                          icon: LucideIcons.repeat,
                          value: '45,000+',
                          label: 'Items Swapped',
                          desc: 'Clothes given new life through our platform',
                        ),
                        _ImpactStat(
                          icon: LucideIcons.trendingUp,
                          value: '89%',
                          label: 'Satisfaction Rate',
                          desc: 'Members love their swapping experience',
                        ),
                        _ImpactStat(
                          icon: LucideIcons.award,
                          value: '2.5M',
                          label: 'Points Earned',
                          desc: 'Total points earned by our community',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Footer(),
      ],
    );
  }
}

class _ImpactStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String desc;

  const _ImpactStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
