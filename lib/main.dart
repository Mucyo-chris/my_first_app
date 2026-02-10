import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        useMaterial3: true,
      ),
      home: const PhoneMockupWrapper(),
    );
  }
}

// ── Phone mockup wrapper ──────────────────────────────────────────────────────
class PhoneMockupWrapper extends StatelessWidget {
  const PhoneMockupWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EDF2),
      body: Center(
        child: Container(
          width: 320,
          height: 660,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1E),
            borderRadius: BorderRadius.circular(44),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 48,
                offset: const Offset(0, 24),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // ── Thin outer ring highlight ──
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44),
                  border: Border.all(
                    color: const Color(0xFF3A3A3E),
                    width: 1,
                  ),
                ),
              ),

              // ── Screen content with thin padding ──
              Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: const UserProfileScreen(),
                ),
              ),

              // ── Left side buttons ──
              Positioned(
                left: -2,
                top: 110,
                child: Column(
                  children: [
                    _SideButton(height: 24),
                    const SizedBox(height: 12),
                    _SideButton(height: 24),
                    const SizedBox(height: 12),
                    _SideButton(height: 40),
                  ],
                ),
              ),

              // ── Right side button ──
              Positioned(
                right: -2,
                top: 140,
                child: _SideButton(height: 52, isRight: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  final double height;
  final bool isRight;
  const _SideButton({required this.height, this.isRight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2E),
        borderRadius: isRight
            ? const BorderRadius.horizontal(right: Radius.circular(2))
            : const BorderRadius.horizontal(left: Radius.circular(2)),
      ),
    );
  }
}

// ── Actual profile screen UI ──────────────────────────────────────────────────
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 50.0;
    const double avatarOverlap = avatarRadius;

    return Stack(
      children: [
        // ── Gradient background ──
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF90C8F0),
                Color(0xFFB8DCF5),
                Color(0xFFDEEEFA),
                Color(0xFFF0F4F8),
              ],
              stops: [0.0, 0.25, 0.45, 0.65],
            ),
          ),
        ),

        // ── Content ──
        Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 14.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: avatarRadius * 0.5),

            // Card + avatar stack
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // White card
                  Padding(
                    padding: EdgeInsets.only(
                      top: avatarOverlap,
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: avatarOverlap + 10,
                          left: 20,
                          right: 20,
                          bottom: 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Olivia Chen',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '@olivia_chen',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8A9BB0),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Stats
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                _StatItem(value: '35', label: 'Posts'),
                                _VerticalDivider(),
                                _StatItem(value: '12.5K', label: 'Followers'),
                                _VerticalDivider(),
                                _StatItem(value: '800', label: 'Following'),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF5DADE2),
                                          Color(0xFF3498DB),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(21),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF3498DB)
                                              .withOpacity(0.35),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Follow',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(
                                        color: const Color(0xFFD0DCE8),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Message',
                                        style: TextStyle(
                                          color: Color(0xFF3D5A73),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // Bio
                            const Text(
                              'Passionate photographer and digital nomad. Exploring the world, one picture at a time. Sharing my journey and love for nature.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF5A6A7A),
                                height: 1.55,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Avatar
                  Positioned(
                    top: 0,
                    child: Container(
                      width: avatarRadius * 2,
                      height: avatarRadius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/women/44.jpg',
                        ),
                        backgroundColor: Color(0xFFE8D5C4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF8A9BB0),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: const Color(0xFFE2EAF0),
    );
  }
}