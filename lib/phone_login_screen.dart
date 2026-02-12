import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider; // Unused in this context after refactor

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _codeSent = false;
  String? _errorMessage;
  int _timerCount = 60;
  Timer? _timer;
  bool _isLoading = false;

  void _startTimer() {
    setState(() => _timerCount = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerCount == 0) {
        setState(() => timer.cancel());
      } else {
        setState(() => _timerCount--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
              ),
            ),
          ),
          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                        _codeSent
                            ? Icons.mark_email_read_rounded
                            : Icons.phone_android_rounded,
                        size: 64,
                        color: const Color(0xFF1A237E)),
                    const SizedBox(height: 24),
                    Text(
                      _codeSent ? 'Enter OTP' : 'Phone Auth',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _codeSent
                          ? 'We have sent an OTP to ${_phoneController.text}'
                          : 'Enter your number to receive a secure code',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    if (!_codeSent) ...[
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '+1 555 000 0000',
                          prefixIcon: Icon(Icons.phone_outlined, size: 20),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() {
                                  _errorMessage = null;
                                  _isLoading = true;
                                });
                                final phone = _phoneController.text.trim();
                                if (phone.isEmpty) {
                                  setState(() {
                                    _errorMessage = "Enter valid phone number";
                                    _isLoading = false;
                                  });
                                  return;
                                }
                                try {
                                  await auth.verifyPhoneNumber(
                                    phone,
                                    onCodeSent: (verId, token) {
                                      setState(() {
                                        _codeSent = true;
                                        _isLoading = false;
                                      });
                                      _startTimer();
                                    },
                                    onVerificationFailed: (e) {
                                      setState(() {
                                        _errorMessage = e.message;
                                        _isLoading = false;
                                      });
                                    },
                                  );
                                } catch (e) {
                                  setState(() {
                                    _errorMessage = e.toString();
                                    _isLoading = false;
                                  });
                                }
                              },
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Text('Send Verification Code'),
                      ),
                    ] else ...[
                      TextField(
                        controller: _otpController,
                        decoration: const InputDecoration(
                          labelText: '6-Digit OTP',
                          prefixIcon: Icon(Icons.lock_clock_outlined, size: 20),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() => _isLoading = true);
                                final error = await auth
                                    .signInWithOtp(_otpController.text.trim());
                                if (error != null) {
                                  setState(() {
                                    _errorMessage = error;
                                    _isLoading = false;
                                  });
                                } else {
                                  if (!context.mounted) return;
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                }
                              },
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Text('Verify & Continue'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _timerCount == 0
                            ? () {
                                setState(() {
                                  _codeSent = false;
                                  _isLoading = false;
                                });
                              }
                            : null,
                        child: Text(_timerCount == 0
                            ? 'Resend Code'
                            : 'Resend in ${_timerCount}s'),
                      ),
                    ],
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          _errorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
