---
name: user-simulation
description: Protocol for pre-emptive identification of user confusion and technical hurdles.
---

# 🧪 User Simulation

Protocol for "Testing with Empathy" before any code is written.

## 🔄 Simulation Loop

1. **Input**: Receive the technical plan from the Developer.
2. **Apply Persona**: Select a persona from `user-personas`.
3. **Simulate Interactions**:
   - "What happens if I click this and it fails?"
   - "Do I know I need to download a file from Firebase Console?"
   - "Is this explanation too technical?"
4. **Identify Gaps**: Flag any "hidden requirements" (e.g., setting up a Google Cloud project).
5. **Guidance Generation**: Create the "Plain Language Summary" for the user.

## 📏 Success Metrics

- **Zero Jargon**: No unexplained acronyms in the user-facing summary.
- **Actionable Steps**: The user knows exactly what *they* need to do (e.g., "Grant me permission").
- **Clarity**: The benefit of the change is explained in business/user terms.
