---
name: rag-audit
description: Auto-trigger RAG retrieval, gap detection, and knowledge integrity enforcement.
---

# 🔍 Skill: RAG Audit

## 🚀 Purpose

Ensures the RAG system is **self-healing**: it auto-triggers on every query, detects gaps, and enforces strict filling protocols. The goal is that the knowledge base gets STRONGER after every conversation.

## ⚡ Auto-Trigger Engine

### How Retrieval Works

```
USER QUERY
    ↓
Extract keywords (nouns, verbs, domain terms)
    ↓
Match against registry.json "keywords" index
    ↓
Load ALL matching Knowledge Items
    ↓
If 0 matches → FLAG AS GAP
    ↓
Proceed with task
    ↓
After task → Run Gap Audit Checklist
```

### Keyword Extraction Rules

| User Input Type | Extraction Strategy |
| --- | --- |
| "Fix X" / "X is broken" | Extract the noun X → search `fixes/` + `patterns/` |
| "Add X" / "I want X" | Extract the noun X → search `features/` + `recipes/` |
| "Make it look X" | Extract the adjective X → search `principles/` |
| "What is X?" | Extract the noun X → search `glossary/` |
| "How do I X?" | Extract the verb phrase X → search `recipes/` + `patterns/` |
| "Build / Deploy / Publish" | Literal keyword match → search `recipes/` |

### Gap Detection

A **RAG Gap** is flagged when:

1. ZERO keyword matches in `registry.json`
2. A keyword matches but the referenced file is MISSING
3. A KI is loaded but its content doesn't cover the user's specific scenario
4. A task is completed using first-principles (no KI was consulted)

## 📋 Gap Audit Checklist (STRICT)

After EVERY gap, ALL boxes must be checked before the task is considered complete.

### Phase 1: Classify

- [ ] **Gap Type**: `missing-ki` / `outdated-ki` / `missing-keyword` / `missing-category`
- [ ] **Severity**: `critical` (blocks future work) / `moderate` (delays work) / `low` (nice to have)
- [ ] **Category**: `principles` / `patterns` / `features` / `fixes` / `glossary` / `recipes`

### Phase 2: Fill

- [ ] KI file created using `knowledge-item-template.md`
- [ ] YAML frontmatter complete: `id`, `version`, `persona`, `tags`
- [ ] Content has: Concept, Principles, Technical Pattern, Hardening sections
- [ ] Code examples included (if technical pattern)
- [ ] Plain-English explanation included (if user-facing)

### Phase 3: Index

- [ ] Node added to `registry.json` → `graph.[category].nodes`
- [ ] Keywords added to `registry.json` → `keywords`
- [ ] `depends_on` links established (if applicable)
- [ ] `registry.json` version number incremented

### Phase 4: Verify

- [ ] File exists on disk at the referenced path
- [ ] JSON parses without error
- [ ] GEMINI.md Knowledge Graph table counts updated
- [ ] Gap is no longer flagged on a re-query

## 🛡️ Self-Repair (Action)

- If a KI is missing tags but its content is clear → Automate tag generation.
- If a version mismatch is found → Synchronize based on file modification timestamp.
- If a keyword returns a broken file reference → Delete the node OR restore the file.
- If a recipe is requested but doesn't exist → Create the recipe AND add it to the recipe triggers list in GEMINI.md.

## 🔄 Continuous Improvement Loop

```
Every Conversation:
  1. Auto-trigger retrieval
  2. Detect gaps
  3. Complete the task
  4. Fill gaps (strict checklist)
  5. RAG is now stronger
  
Result: The system becomes battle-tested over time.
         Gaps shrink exponentially.
         Eventually: ZERO gaps for common operations.
```

## ✨ Principles

1. **Metadata Compliance**: Every node in `registry.json` must exist in the file system and have matching YAML frontmatter.
2. **Versioning**: High-level principles must be pinned to stable versions; breaking technical changes must increment SemVer.
3. **Persona Accountability**: Every KI must have a designated `staff_persona` owner.
4. **Zero-Gap Policy**: Gaps are not tolerated. Every gap is a TODO that blocks "task complete."

## // RAG-ACTIVE

This skill fires AUTOMATICALLY during Discovery and Harvest phases. It is NOT optional.
