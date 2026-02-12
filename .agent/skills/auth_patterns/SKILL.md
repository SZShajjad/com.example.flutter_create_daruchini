---
name: auth_patterns
router_kit: FullStackKit
description: Authentication & Authorization patterns.
---
# 🔐 Auth Patterns
## 1. Authentication vs Authorization
- AuthN: Kimsin?
- AuthZ: Ne yapabilirsin?

## 🛡️ Security Best Practices
- Password Hashing (bcrypt/argon2).
- HTTPS zorunlu.
- Rate Limiting.

## 🔄 Workflow
1. **Strategy**: Mobile için JWT/Token tabanlı strateji seç.
2. **Hardening**: Brute-force koruması ve input validation ekle.
3. **Audit**: Token saklama güvenliğini kontrol et.
