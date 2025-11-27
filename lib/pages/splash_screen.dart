import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'bottomNavBar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _gradientCtrl;
  late final AnimationController _orbitCtrl;
  late final AnimationController _pulseCtrl;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _gradientCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _orbitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
      lowerBound: 0.9,
      upperBound: 1.06,
    )..repeat(reverse: true);

    // Navigate after a short intro; replace HomeScreen with your actual start page
    _timer = Timer(const Duration(milliseconds: 3200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => Bottomnavbar(),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _gradientCtrl.dispose();
    _orbitCtrl.dispose();
    _pulseCtrl.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl, // Arabic-friendly
      child: Scaffold(
        body: Stack(
          children: [
            _AnimatedGradientBackground(controller: _gradientCtrl),
            // Decorative top-right spark
            Positioned(
              top: -40,
              right: -20,
              child: _GlowDot(color: cs.secondary.withOpacity(0.35), size: 180),
            ),
            Positioned(
              bottom: -60,
              left: -20,
              child: _GlowDot(color: cs.tertiary.withOpacity(0.30), size: 220),
            ),
            // Main content
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    ScaleTransition(
                        scale: _pulseCtrl, child: const _BrandEmblem()),
                    const SizedBox(height: 26),
                    _OrbitingTools(controller: _orbitCtrl),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Text(
                            'كل ما تحتاجه لصيانة منزلك في تطبيق واحد',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'خدمات سريعة • فنيون موثوقون • قطع غيار أصلية',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.75),
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _ProgressDots(),
                  ],
                ),
              ),
            ),
            // Skip button (for dev/testing) — remove in production if undesired
            Positioned(
              top: 16,
              left: 16,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  backgroundColor:
                      Theme.of(context).colorScheme.surface.withOpacity(0.3),
                ),
                onPressed: () {
                  _timer?.cancel();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => Bottomnavbar()),
                  );
                },
                icon: const Icon(Icons.skip_next_rounded),
                label: const Text('تخطي'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated moving gradient background with subtle shimmer
class _AnimatedGradientBackground extends StatelessWidget {
  final AnimationController controller;
  const _AnimatedGradientBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark
        ? const [
            Color.fromARGB(255, 74, 98, 178),
            Color(0xFF0E2A47),
            Color.fromARGB(255, 59, 144, 213),
            Color(0xFF0B1020),
          ]
        : const [
            Color.fromARGB(255, 124, 164, 177),
            Color(0xFFD6F1FF),
            Color(0xFFBCE7FF),
            Color(0xFFF4FBFF),
          ];

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        final begin = Alignment(
          math.cos(2 * math.pi * t) * 0.8,
          math.sin(2 * math.pi * t) * 0.8,
        );
        final end = Alignment(
          math.cos(2 * math.pi * (t + 0.5)) * 0.8,
          math.sin(2 * math.pi * (t + 0.5)) * 0.8,
        );
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: begin, end: end, colors: colors),
          ),
          child: Container(
            // subtle overlay to add depth
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(isDark ? 0.03 : 0.08),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BrandEmblem extends StatelessWidget {
  const _BrandEmblem();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 132,
      height: 132,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          cs.primary.withOpacity(0.18),
          cs.primary.withOpacity(0.04)
        ]),
        border: Border.all(color: cs.primary.withOpacity(0.25), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withOpacity(0.35),
            blurRadius: 22,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shield background
          Icon(
            Icons.shield_moon_rounded,
            size: 96,
            color: cs.primary.withOpacity(0.18),
          ),
          // House icon
          Icon(Icons.other_houses_rounded, size: 64, color: cs.primary),
        ],
      ),
    );
  }
}

class _OrbitingTools extends StatelessWidget {
  final AnimationController controller;
  const _OrbitingTools({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 160,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final t = controller.value;
          final radius = 62.0;
          final center = const Offset(110, 80);

          Offset pos(double angle) => Offset(
                center.dx + radius * math.cos(angle),
                center.dy + radius * math.sin(angle),
              );

          // Icons and their phase offsets (radians)
          final data = <MapEntry<IconData, double>>[
            MapEntry(Icons.build_rounded, 0.0),
            MapEntry(Icons.plumbing_rounded, math.pi / 2),
            MapEntry(Icons.bolt_rounded, math.pi),
            MapEntry(Icons.home_repair_service_rounded, 3 * math.pi / 2),
          ];

          return Stack(
            children: [
              // faint orbit circle
              Positioned(
                left: center.dx - radius,
                top: center.dy - radius,
                child: Container(
                  width: radius * 2,
                  height: radius * 2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.12),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // orbiting icons
              for (final entry in data)
                Positioned(
                  left: pos(2 * math.pi * t + entry.value).dx - 16,
                  top: pos(2 * math.pi * t + entry.value).dy - 16,
                  child: _ToolIcon(icon: entry.key),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ToolIcon extends StatelessWidget {
  final IconData icon;
  const _ToolIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: cs.primaryContainer.withOpacity(0.85),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: cs.primary.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Icon(icon, size: 18, color: cs.onPrimaryContainer),
    );
  }
}

class _ProgressDots extends StatefulWidget {
  const _ProgressDots();

  @override
  State<_ProgressDots> createState() => _ProgressDotsState();
}

class _ProgressDotsState extends State<_ProgressDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
        lowerBound: 0.65,
        upperBound: 1.0,
      )..repeat(reverse: true, period: const Duration(milliseconds: 900)),
    );

    // tiny phase offset so dots don't pulse exactly together
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 120), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: ScaleTransition(
            scale: _controllers[i],
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _GlowDot extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowDot({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color, blurRadius: size / 2, spreadRadius: size / 5),
        ],
      ),
    );
  }
}
