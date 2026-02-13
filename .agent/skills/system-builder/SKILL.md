---
name: system-builder
description: Blueprint for scaling agentic AI features within the Antigravity ecosystem.
---

# 🚀 System Builder

This skill provides patterns for building and scaling agentic systems.

## 🏗️ Building Blocks

- **Modularity**: Every feature should be its own `lib/features` module.
- **Provider-Driven**: Use `Provider` or similar for reactive system states.
- **Verification-First**: Never consider a build "Done" until the agent runs `flutter build apk` and verifies output.

## 🤖 Agentic Patterns

- **Self-Documenting**: New code should immediately trigger a "Session Learning" update in the relevant skill.
- **Standardized**: Use the `skills_creator` protocol for any new engineering domain encountered.
- **Clean Registry**: Keep `.agent/skills_manifest.json` perfectly synced with the directory structure.
