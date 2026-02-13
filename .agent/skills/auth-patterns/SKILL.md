---
name: auth-patterns
router_kit: FullStackKit
description: Authentication & Authorization patterns.
---
# 🔐 Auth Patterns

## 1. Authentication vs Authorization

- **AuthN (Authentication)**: Who are you? (Identity)
- **AuthZ (Authorization)**: What can you do? (Permissions)

## 🛡️ Security Best Practices

- **Password Hashing**: Use secure algorithms (bcrypt/argon2).
- **HTTPS Enforcement**: Encrypt all traffic.
- **Rate Limiting**: Prevent brute-force attacks.
- **Dependency Pinning**: Encountered build failures with `google_sign_in: ^7.2.0`; downgraded to `6.2.1` for stability in legacy-compatible environments.

## 🔄 Workflow

1. **Strategy**: Choose Token-based (JWT/OAuth2) strategies for mobile.
2. **Hardening**: Implement robust input validation and account lockout policies.
3. **Audit**: Regularly check secure token storage (e.g., `flutter_secure_storage`).

## 🧠 Session Learnings

- **Provider Preference**: Users may shift from legacy methods (Phone Auth) to modern ones (Google Sign-In) mid-cycle; architecture must be modular enough to swap logic without UI breakage.
- **Build Stabilization**: If release builds fail with `ClassNotFoundException` or `UnsatisfiedLinkError`, investigate if ProGuard/R8 rules for the auth provider are missing or if plugin versions are too new for the current Gradle configuration.
