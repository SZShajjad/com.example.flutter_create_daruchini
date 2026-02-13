import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:daruchini_auth/features/auth/data/auth_provider.dart';
import 'login_screen.dart';
import 'package:daruchini_auth/features/home/presentation/screens/home_screen.dart';
import '../services/biometric_service.dart';
import 'verify_email_screen.dart'; // Added for VerifyEmailScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _biometricService = BiometricService();
  bool _showPasswordFallback = false;

  @override
  void initState() {
    super.initState();
    _handleAuth();
  }

  Future<void> _handleAuth() async {
    // Artificial delay for splash vibe
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.isAuthenticated) {
      final isBioAvailable = await _biometricService.isBiometricAvailable();
      if (!mounted) return;
      if (isBioAvailable) {
        final authenticated = await _biometricService.authenticate();
        if (!authenticated) {
          setState(() => _showPasswordFallback = true);
          return;
        }
      }

      if (!mounted) return;
      final navigator = Navigator.of(context);

      if (auth.isEmailVerified) {
        navigator.pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        navigator.pushReplacement(
            MaterialPageRoute(builder: (_) => const VerifyEmailScreen()));
      }
    } else {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.primaryContainer.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  width: 2,
                ),
              ),
              child: Hero(
                tag: 'auth_shield',
                child: Icon(
                  Icons.security_rounded,
                  size: 80,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
                children: [
                  TextSpan(
                    text: 'D',
                    style: GoogleFonts.playfairDisplay(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const TextSpan(text: 'aruchini'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'INDUSTRIAL AUTH',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: colorScheme.primary.withValues(alpha: 0.5),
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 64),
            if (_showPasswordFallback) ...[
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
                icon: const Icon(Icons.password_rounded),
                label: const Text('Sign in with Password'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: colorScheme.primary.withValues(alpha: 0.5)),
                ),
              ),
            ] else
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: colorScheme.primary.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
