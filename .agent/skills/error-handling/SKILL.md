---
name: error-handling
router_kit: FullStackKit
description: Robust failure handling strategies.
---
# 🛡️ Error Handling

## 1. Philosophies

- **Fail Fast**: Catch errors at the source.
- **Exceptions vs Result Types**: Use `try-catch` for unpredictable failures (like Network/Firebase) and `Result` types for predictable domain logic.
- **Clean Up Resources**: Always use `finally` to close streams or controllers.

## ⚡ Universal Patterns

- **Circuit Breaker**: Stop remote requests if the service is down to save resources.
- **Graceful Degradation**: Show cached data or fallback UI if an error occurs.

## 🔄 Workflow

1. **Prevention**: Define custom, typed exceptions for the domain (e.g., `AuthenticationException`).
2. **Handling**: Provide user-friendly messages rather than technical codes.
3. **Monitoring**: Log critical errors to services like Sentry or Firebase Crashlytics.

## 🧠 Session Learnings

- **Firebase Mapping**: Always use a helper method (e.g., `_getErrorMessage(String code)`) to convert technical Firebase error codes (like `email-already-in-use`) into friendly text.
- **Async Safety**: When handling errors in async UI methods, verify that the widget is still `mounted` before showing a `SnackBar` or updating the error state to avoid `setState()` crashes.
- **Rate-Limiting as Prevention**: Client-side cooldown timers (30s/60s) prevent users from spamming sensitive actions. This is UX-level error prevention, not security — server-side limits are still needed.
- **Cooldown Timer Pattern**: Use `Timer.periodic` with `mounted` checks, disable the button during cooldown, and show remaining seconds on the label. Always cancel in `dispose()`.
- **Anti-Enumeration as Error Design**: Some "errors" should be hidden from the user entirely. Password reset should always show "success" to prevent account enumeration — the error is real but the feedback is opaque.
