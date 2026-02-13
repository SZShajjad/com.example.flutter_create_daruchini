---
id: prin-vibe-001
version: 1.0.0
persona: staff_pm
tags: [principle, vibe, guide]
---

# 🖖 Vibe Coder Best Practices

## 🧠 Mindset

You are a "Vibe Coder"—you care about how the app *feels* and how it *looks*. You don't want to worry about the plumbing, but you want it to be "Bulletproof".

## 🛠️ Working with the Agent (RAG-Augmented)

1. **Ask for the "Vibe"**: Don't just ask to "add a button", ask the agent to "make it feel premium".
2. **Retrieval Power**: Use the `.agent/knowledge/` directory to understand what the agent "knows".
3. **Plain Language**: Communicate in outcomes. "I want users to feel safe when they log in" leads to deep-blue gradients and secure icons.

## 🛡️ Ensuring Bulletproof Logic

- Always check the `AuthProvider` for core state.
- Never bypass the `SplashScreen` routing logic.
- If something breaks, ask the agent to "Audit the Vibe"—it will check for UI inconsistencies and logic gaps.
