import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daruchini_auth/features/auth/data/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daruchini_auth/features/auth/presentation/services/security_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SecureScreenMixin {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;
  int _sendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    setSecureScreen(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cooldownTimer?.cancel();
    setSecureScreen(false);
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _sendCooldown = 60);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _sendCooldown--;
        if (_sendCooldown <= 0) timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 64,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Reset Password',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Industrial-grade password recovery.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 48),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: (_isLoading || _sendCooldown > 0)
                          ? null
                          : _handleReset,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(_sendCooldown > 0
                              ? 'Resend in ${_sendCooldown}s'
                              : 'Send Reset Link'),
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
                    color: _isSuccess ? Colors.green : colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'For security, you can request one link every 60 seconds.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleReset() async {
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _message = 'Please enter your email address.';
        _isSuccess = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
    });

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final failure =
        await auth.sendPasswordResetEmail(_emailController.text.trim());

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      if (failure == null) {
        // Always show success to prevent account enumeration
        _message =
            "If an account exists for this email, a reset link has been sent.";
        _isSuccess = true;
        _startCooldown();
      } else {
        _message = failure.message;
        _isSuccess = false;
      }
    });
  }
}
