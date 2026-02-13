---
name: premium-ui
description: Design patterns for modern, premium Flutter interfaces.
---
# Premium UI Skill

## 1. Glassmorphism Design Pattern

**Principle**: Use translucent backgrounds with blur effects to create depth. Use `withValues(alpha: ...)` instead of deprecated `withOpacity`.

### Implementation

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(24),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: child,
    ),
  ),
)
```

## 2. Animated Input Fields

**Principle**: Use `InputDecoration` with `filled: true` and subtle border changes on focus.

```dart
InputDecoration(
  filled: true,
  fillColor: Colors.white.withValues(alpha: 0.05),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
)
```

## 3. High-Gloss Buttons

**Principle**: Use gradients and shadows to simulate a glossy surface.

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF4FC3F7), Color(0xFF2196F3)],
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF2196F3).withValues(alpha: 0.3),
        blurRadius: 12,
        offset: Offset(0, 6),
      ),
    ],
  ),
  child: ElevatedButton(...),
)
```

## 🧠 Session Learnings

- **Performance of Blurs**: Over-using `BackdropFilter` on low-end devices can cause frame drops. Limit glass effects to primary cards/modals.
- **Constraint Errors**: When using `BackdropFilter` inside a `Stack`, ensure its parent has defined constraints (like a `SizedBox` or `Expanded`) to avoid layout overflows.
- **Modern Syntax**: Flutter's move from `withOpacity(0.1)` to `withValues(alpha: 0.1)` is not just stylistic; it prepares the framework for more complex color space handling. Use the latest syntax to avoid technical debt.
