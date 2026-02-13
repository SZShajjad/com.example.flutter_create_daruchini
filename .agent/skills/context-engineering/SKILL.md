---
name: context-engineering
description: Strategies for maintaining structured project context and "Common Ground".
---

# 🌐 Context Engineering

This skill defines how to maintain high-fidelity project memory within the Antigravity system.

## 🧠 Principles

- **Common Ground**: Always establish the "Current State vs. Desired State" before execution.
- **Context Compression**: Summarize complex tasks into structured `.agent/skills` updates.
- **Hierarchy of Truth**:
    1. `skills_manifest.json` (Expertise index)
    2. `GEMINI.md` (Global Rules)
    3. `SKILL.md` (Domain Knowledge)
    4. `task.md` (Active Progress)

## 🛠️ Techniques

- **Hook Detection**: Identify when a new technical pattern emerges and create a "Hook" in the relevant skill.
- **Audit Trails**: Maintain the "Session Learnings" section in all technical skills to catch non-obvious fixes.
- **Context Loading**: At the start of a task, "load" relevant skills via `view_file` to align with established constraints.

## 🔄 Workflow

1. **Assess**: Review project structure and existing skills.
2. **Standardize**: Ensure all documentation follows the English-only, high-gloss pattern.
3. **Persist**: Write learnings into the agent's long-term memory (`.agent/skills`).
