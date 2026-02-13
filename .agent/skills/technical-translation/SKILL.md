---
name: technical-translation
description: Logic layer for converting human intent into technical specs and vice versa.
---

# 🗣️ Technical Translation

The bridge between "Human Needs" and "Machine Execution."

## ↔️ The Translation Matrix

| Human Request | Technical Objective | Explain Like I'm Five (ELI5) |
| :--- | :--- | :--- |
| "Make it look professional." | Apply Glassmorphism, 800-weight fonts, Inter font family. | "I'm adding a modern, glassy effect and cleaner text." |
| "I want everyone to login with Google." | Integrate `google_sign_in`, configure Firebase OAuth. | "I'm setting up a 'Sign in with Google' button." |
| "It feels slow." | Optimize `BackdropFilter`, use `ListView.builder`. | "I'm making the list scroll smoother." |

## 🛠️ Protocol

- **Ask for Clarification**: If a request is too vague (e.g., "Make it better"), translate it into 3 technical options for the user.
- **Back-Translation**: When a task is finished, translate the Git diff into a "What this means for you" report.
- **Jargon Guard**: Detect terms like "Dependency Injection" and replace with "How the app shares data internally."
