---
name: skills-audit
description: Quality assurance protocol for maintaining skill consistency and accuracy.
---

# 🔍 Skills Audit

Protocol for verifying that all agent expertise modules meet quality standards.

## ⚖️ Audit Principles

- **Accuracy**: Code snippets must be valid for the current SDK.
- **Language**: 100% English enforcement.
- **Safety**: Check for `if (mounted)` and `withValues()` modernizations.
- **Freshness**: Ensure "Session Learnings" are updated after major tasks.

## 🔄 Audit Workflow

1. **Scan**: List all skills in `skills_manifest.json`.
2. **Verify**: Check each `SKILL.md` for proper YAML and headers.
3. **Analyze**: Cross-reference against recent `flutter analyze` reports.
4. **Refine**: Correct any Turkish residuals or deprecated syntax.
