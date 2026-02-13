---
id: prin-ui-001
version: 1.0.0
persona: staff_designer
tags: [principle, ui, aesthetic]
---

# ✨ Premium UI & Aesthetic Vibe

## 🎨 Design Philosophy

The Daruchini Agency prioritizes "Visual Excellence" that wows at first glance.

1. **Glassmorphism**: Use of `BackdropFilter` and semi-transparent white/black backgrounds to create depth.
2. **Gradients**: Deep Blue and Royal Purple gradients (`0xFF1A237E` to `0xFF3949AB`) for a high-end, secure feel.
3. **Micro-animations**: Smooth transitions (Fades/Slides) between auth states.

## 📐 Layout System

- **Corner Radius**: Standardized at `16px` or `24px` for a modern, soft look.
- **Typography**: Uses modern sans-serif fonts with generous letter spacing (`1.2`) for headers.
- **Contrast**: High-contrast white text on dark gradients ensures accessibility and premium clarity.

## 🛠️ Implementation for Vibe Coders

- Use the `_buildSocialButton` helper for consistent button styling.
- All containers should use `BoxDecoration` with subtle `Border.all` to define edges in complex backgrounds.
