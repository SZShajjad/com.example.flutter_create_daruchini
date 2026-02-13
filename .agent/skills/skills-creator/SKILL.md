---
name: skills-creator
description: Protocol for creating and standardizing new Antigravity expertise modules.
---

# 🛠️ Skills Creator

This skill defines how to create new skills for the Antigravity agent.

## 📋 Creation Checklist

1. **Directory**: Create `.agent/skills/<skill_name>/`.
2. **Metadata**: Add YAML frontmatter to `SKILL.md`.
3. **Structure**:
   - `# <Skill Name>` header.
   - `## 1. Concepts/Principles`.
   - `## 2. Implementation Patterns` (with code blocks).
   - `## 🧠 Session Learnings` (dynamic knowledge).
4. **Manifest**: Update `.agent/skills_manifest.json`.

## ✍️ Writing Style

- **English Only**: All content must be in English.
- **Actionable**: Focus on "How to" rather than "What is".
- **Context-Rich**: Include recent bug fixes and technical decisions.
