---
id: prin-sys-001
version: 2.0.0
persona: staff_pm
tags: [principle, system, integrity, auto-trigger]
---

# 🏥 RAG Integrity & Battle-Testing

## 🚀 Purpose

Ensures the Retrieval-Augmented Generation system is **self-healing, auto-triggered, and gap-intolerant**.

## ⚡ Auto-Trigger Principle

> **"The RAG system fires automatically on every user query. It is never manual, never optional, never lazy."**

### The Flow

1. User sends a query
2. Agent extracts keywords from the query
3. Keywords are matched against `registry.json` keyword index
4. ALL matching KIs are loaded before any code is written
5. If zero matches → Gap detected → Task includes gap-filling

### Why This Matters

Without auto-triggering, the agent forgets its own knowledge. It rediscovers solutions to problems already solved. This wastes time and produces inconsistent results.

## ✨ Principles

1. **Zero-Broken-Links**: Every reference in a Knowledge Item (KI) must be valid and local.
2. **Continuous Harvest**: Every bug fixed must result in a new or updated KI.
3. **Vibe Validation**: Periodically audit if "Vibe" keywords still map to the intended code patterns.
4. **Zero-Gap Policy**: If the RAG couldn't answer a query, the gap MUST be filled before the task is marked complete.
5. **Auto-Trigger First**: The agent MUST check knowledge BEFORE acting. Think first, code second.

## 🛠️ The "Harvest" Loop

1. **Execution**: Solve the issue.
2. **Verification**: Confirm the fix works.
3. **Extraction**: Identify the core pattern or mistake.
4. **Distillation**: Update an existing KI or create a new one in `.agent/knowledge/`.
5. **Indexing**: Add/update the node and keywords in `registry.json`.

## 📋 Gap-Fill Mandate

When a gap is detected, the agent MUST follow the strict audit:

### Required Outputs

- [ ] New/updated KI file in the correct category directory
- [ ] YAML frontmatter with `id`, `version`, `persona`, `tags`
- [ ] Node added to `registry.json` graph
- [ ] Keywords added to `registry.json` keywords index
- [ ] `registry.json` version incremented
- [ ] GEMINI.md Knowledge Graph count updated (if applicable)

### Severity Classification

- **Critical Gap**: The agent had to build from scratch with no RAG guidance → MUST create KI
- **Moderate Gap**: KI existed but was outdated or incomplete → MUST update KI
- **Low Gap**: KI existed but was missing keywords → MUST add keywords

## 🛡️ Battle-Testing Protocol

- **Regression Audit**: Before significant refactors, retrieve the `/fixes/` module to avoid re-introducing old bugs.
- **Context Refresh**: When the project scope changes, archive outdated KIs to prevent "Context Pollution."
- **Keyword Coverage Check**: Periodically verify that common queries map to at least one KI.

## // RAG-TAGS

`#system` `#integrity` `#learning` `#auto-trigger`
