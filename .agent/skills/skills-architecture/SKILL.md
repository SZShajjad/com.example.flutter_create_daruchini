---
name: skills-architecture
description: Structural definition of the Antigravity agentic brain and its integration points.
---

# 🏗️ Skills Architecture

This skill defines the directory and dependency structure of the agent's knowledge system.

## 📁 System Layout

- `.agent/`: Root of agentic identity.
  - `skills/`: Sub-indexed expertise folders.
  - `workflows/`: Reusable procedural steps.
  - `GEMINI.md`: Core identity and global rules.
  - `skills_manifest.json`: Single source of truth for loading skills.

## 🔗 Knowledge Hierarchy

1. **Core (GEMINI.md)**: Unchangeable values and engineering principles.
2. **Meta (skills_architecture, etc.)**: Tools for managing other tools.
3. **Domain (mobile_flutter, advanced_auth)**: Specialized technical knowledge.
4. **Learn (Session Learnings)**: Just-in-time knowledge gained from local bugs.
