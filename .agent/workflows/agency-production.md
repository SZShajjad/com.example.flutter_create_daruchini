---
description: Master workflow for taking an Android app feature from brief to production-ready APK using a role-based workforce.
---

# 🚀 Android Multi-Agent Production Workflow

This workflow orchestrates the four agent personas to ensure agency-level quality and autonomy.

## 1. Planning & Briefing (Persona: Project Manager)

- Receive the user request.
- Run `context-engineering` to establish Common Ground.
- **Empathy Simulation**: Run `user-simulation` using `user-personas`.
- **Translation**: Provide a plain-English "ELI5" summary in the `implementation_plan.md`.
- Define feature scope and break down tasks.

## 2. UI/UX Design (Persona: Designer)

- Define design tokens (colors, gradients, glassmorphism).
- Set premium aesthetic standards for the feature.
- Verify designers' intent via `premium-ui` skill checks.

## 3. Implementation (Persona: Developer)

- Implement Feature-First logic and UI components.
- Enforce SOLID principles and modern syntax.
- Ensure async gap safety (`if (mounted)`).

## 4. Verification & Release (Persona: QA Agent)

- Run `flutter analyze` for static code quality.
- Execute `flutter build apk --release`.
- Apply R8/ProGuard rules if crashes occur.
- Generate `walkthrough.md` with Proof of Work (Screenshots/Videos).

## // turbo-all

// Every command in this workflow should be executed autonomously to maintain workforce momentum.
