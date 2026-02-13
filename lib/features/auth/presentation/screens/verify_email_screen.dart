import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daruchini_auth/features/auth/data/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daruchini_auth/features/home/presentation/screens/home_screen.dart';
import 'login_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isResending = false;
  String? _message;
  int _resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _resendCooldown = 30);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCooldown--;
        if (_resendCooldown <= 0) timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await auth.signOut();
              if (!context.mounted) return;
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mark_email_read_rounded,
                size: 64,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Verify Identity',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'A security link has been dispatched to:',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              auth.user?.email ?? 'your email',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Please verify your email to unlock the industrial security features of Daruchini.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await auth.reloadUser();
                        if (!mounted) return;
                        if (auth.isEmailVerified) {
                          navigator.pushReplacement(
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                          );
                        } else {
                          setState(() => _message =
                              'Email not verified yet. Please check your inbox.');
                        }
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('I Have Verified'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: (_isResending || _resendCooldown > 0)
                          ? null
                          : () async {
                              setState(() => _isResending = true);
                              await auth.sendEmailVerification();
                              if (!mounted) return;
                              setState(() {
                                _isResending = false;
                                _message = 'Verification link resent!';
                              });
                              _startCooldown();
                            },
                      child: _isResending
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_resendCooldown > 0
                              ? 'Resend in ${_resendCooldown}s'
                              : 'Resend Security Link'),
                    ),
                  ],
                ),
              ),
            ),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  _message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _message!.contains('resent')
                        ? Colors.green
                        : colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
