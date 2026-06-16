import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers/app_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Wait for splash to fully show
    await Future.delayed(const Duration(milliseconds: 2800));
    if (!mounted) return;
    final provider = context.read<AppProvider>();
    await provider.init();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0520),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Full screen splash image ──────────────
            Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
            )
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut),

            // ── Subtle bottom gradient overlay ────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF0A0520).withOpacity(0.85),
                    ],
                  ),
                ),
              ),
            ),

            // ── Loading indicator at bottom ───────────
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Loading your study space...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              )
                  .animate(delay: 800.ms)
                  .fadeIn(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}
