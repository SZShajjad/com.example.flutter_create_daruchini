import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:daruchini_auth/features/auth/data/auth_provider.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import 'verify_email_screen.dart';
import 'package:daruchini_auth/features/home/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:daruchini_auth/features/auth/presentation/services/security_utils.dart';
import '../../../../core/presentation/widgets/shake_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SecureScreenMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _shakeController = ShakeController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  static final _emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');

  @override
  void initState() {
    super.initState();
    setSecureScreen(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    setSecureScreen(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Expressive Header
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(48),
                    bottomRight: Radius.circular(48),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 80, 32, 48),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Hero(
                            tag: 'auth_shield',
                            child: Icon(
                              Icons.security_rounded,
                              size: 48,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Daruchini Auth',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'SECURE • INDUSTRIAL • EXPRESSIVE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: ShakeWidget(
                  controller: _shakeController,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome Back',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!_emailRegex.hasMatch(value.trim())) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _handleLogin(),
                          ),
                          if (_errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(
                                    color: colorScheme.error, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgotPasswordScreen())),
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    HapticFeedback.mediumImpact();
                                    _handleLogin();
                                  },
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2))
                                : const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Social Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        colorScheme.secondaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialButton(
                        context,
                        icon: Icons.g_mobiledata,
                        onTap: () => _handleGoogleSignIn(),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to Daruchini?",
                        style: TextStyle(color: colorScheme.onSurfaceVariant)),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupScreen())),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      _shakeController.shake();
      HapticFeedback.heavyImpact();
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    // Returns Failure? instead of String?
    final failure = await auth.signIn(
        _emailController.text.trim(), _passwordController.text);

    if (!mounted) return;

    setState(() {
      _errorMessage = failure?.message;
      _isLoading = false;
    });

    if (failure != null) {
      _shakeController.shake();
      HapticFeedback.heavyImpact();
    } else {
      if (auth.isEmailVerified) {
        navigator.pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        navigator
            .push(MaterialPageRoute(builder: (_) => const VerifyEmailScreen()));
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    // Returns Failure?
    final failure = await auth.signInWithGoogle();

    if (!mounted) return;

    setState(() {
      _errorMessage = failure?.message;
      _isLoading = false;
    });

    if (failure == null) {
      // Check for cancellation logic (if failure was null but no user... wait, provider returns Failure if canceled now)
      // Actually provider returns AuthFailure('canceled') if canceled. So failure != null.
      // So if failure == null, we are good.

      if (auth.isEmailVerified) {
        navigator.pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        navigator
            .push(MaterialPageRoute(builder: (_) => const VerifyEmailScreen()));
      }
    }
  }

  Widget _buildSocialButton(BuildContext context,
      {required IconData icon, required VoidCallback onTap}) {
    return IconButton.filledTonal(
      onPressed: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      icon: Icon(icon, size: 32),
      style: IconButton.styleFrom(
        fixedSize: const Size(64, 64),
      ),
    );
  }
}
