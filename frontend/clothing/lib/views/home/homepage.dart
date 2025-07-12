import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF66BB8A),
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Give Your Clothes\nA Second Life",
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Join the sustainable fashion revolution. Swap, redeem, and\n"
                      "discover amazing pre-loved clothes while earning points for every contribution.",
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _ActionButton(text: 'Start Swapping', onPressed: () {}),
                        _ActionButton(
                          text: 'Browse Items',
                          disabled: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      spacing: 48,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: const [
                        _FeatureIcon(
                          icon: Icons.loop,
                          title: 'Sustainable',
                          subtitle:
                              'Reduce fashion waste by giving\nclothes new homes',
                        ),
                        _FeatureIcon(
                          icon: Icons.groups,
                          title: 'Community',
                          subtitle:
                              'Connect with like-minded fashion\nenthusiasts',
                        ),
                        _FeatureIcon(
                          icon: Icons.emoji_events,
                          title: 'Rewarding',
                          subtitle:
                              'Earn points for every item you list\nand swap',
                        ),
                      ],
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

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.recycling, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            "ReWear",
            style: TextStyle(
              color: Colors.green.shade800,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton(onPressed: () {}, child: const Text("Browse Items")),
          TextButton(onPressed: () {}, child: const Text("How It Works")),
          TextButton(onPressed: () {}, child: const Text("Community")),
          const SizedBox(width: 16),
          const Icon(Icons.search),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text("1,250 pts"),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text("List Item"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: disabled ? Colors.white54 : Colors.white,
        foregroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_right_alt),
        ],
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureIcon({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.green.shade700, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
