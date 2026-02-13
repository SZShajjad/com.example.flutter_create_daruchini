---
id: fix-rate-001
version: 1.0.0
persona: staff_developer
tags: [fix, security, ux, rate-limiting]
---

# ⏱️ Fix: Rate-Limiting UI Actions

## 🚀 Concept

Prevent users from spamming sensitive actions (email resend, password reset) by implementing client-side cooldown timers. This protects the backend and improves UX.

## ✨ Principles

- **Cooldown Window**: 30s for email verification resend, 60s for password reset
- **Visual Feedback**: Show countdown on the button itself ("Resend in 23s")
- **Disable Button**: Button is null-onPressed during cooldown
- **Timer Safety**: Always check `mounted` inside `Timer.periodic`

## 🛠️ Technical Pattern

```dart
int _cooldown = 0;
Timer? _timer;

void _startCooldown(int seconds) {
  setState(() => _cooldown = seconds);
  _timer?.cancel();
  _timer = Timer.periodic(const Duration(seconds: 1), (t) {
    if (!mounted) { t.cancel(); return; }
    setState(() {
      _cooldown--;
      if (_cooldown <= 0) t.cancel();
    });
  });
}

// In build():
TextButton(
  onPressed: _cooldown > 0 ? null : _handleResend,
  child: Text(_cooldown > 0 ? 'Resend in ${_cooldown}s' : 'Resend'),
)
```

## 🛡️ Hardening

- Always dispose the timer: `_timer?.cancel()` in `dispose()`
- Server-side rate limiting is ALSO required — client-side is UX only
- Consider exponential backoff for repeated failures

## // RAG-TAGS

`#fix` `#security` `#ux` `#rate-limiting`
