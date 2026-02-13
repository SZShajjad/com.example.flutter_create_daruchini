---
id: ptrn-form-001
version: 1.0.0
persona: staff_developer
tags: [pattern, form, validation, ux]
---

# 📝 Pattern: Form Validation

## 🚀 Concept

Every user input form must use Flutter's `Form` widget with a `GlobalKey<FormState>` to enable declarative, per-field validation before submission.

## ✨ Principles

- **Never trust raw input** — validate before submission
- **Inline errors** — show errors below each field, not in snackbars
- **Trim inputs** — always `.trim()` before processing

## 🛠️ Technical Patterns

### Form Setup

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(children: [
    TextFormField(validator: _validateEmail),
    TextFormField(validator: _validatePassword),
  ]),
)

// On submit:
if (_formKey.currentState!.validate()) {
  // All fields are valid — proceed
}
```

### Email Validator

```dart
static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

String? _validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Please enter your email';
  if (!_emailRegex.hasMatch(value.trim())) return 'Please enter a valid email';
  return null;
}
```

### Password Strength Calculator

```dart
void _calculateStrength(String password) {
  double strength = 0;
  if (password.length >= 8) strength += 0.25;
  if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
  if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
  if (password.contains(RegExp(r'[!@#$%^&*]'))) strength += 0.25;
  // Map strength → label: Weak/Fair/Strong/Excellent
}
```

### Confirm Password (Cross-Field Validation)

```dart
validator: (value) {
  if (value == null || value.isEmpty) return 'Please confirm your password';
  if (value != _passwordController.text) return 'Passwords do not match';
  return null;
},
```

## 🛡️ Hardening

- Always use `autovalidateMode: AutovalidateMode.onUserInteraction` for real-time feedback
- Use `textInputAction: TextInputAction.next` for keyboard flow between fields
- Regex for email is intentionally permissive — true validation happens server-side

## // RAG-TAGS

`#pattern` `#form` `#validation` `#ux`
