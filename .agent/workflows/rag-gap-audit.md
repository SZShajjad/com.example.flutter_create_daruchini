---
description: Workflow triggered when a RAG gap is detected — strict fill protocol with mandatory checkboxes
---

# 🔴 RAG Gap Audit Workflow

This workflow fires AUTOMATICALLY when the RAG system cannot match a user's query to any existing knowledge item.

## When Does This Trigger?

- Zero keyword matches in `registry.json` for a user query
- A KI was loaded but didn't cover the specific scenario
- The agent had to solve a problem from scratch (no KI consulted)
- A task is completed and the knowledge gained has no home in the RAG

## Step 1: Classify the Gap

- What was the user's original request?
- What knowledge was missing?
- Assign severity: `critical` / `moderate` / `low`
- Assign category: `principles` / `patterns` / `features` / `fixes` / `glossary` / `recipes`

## Step 2: Create the Knowledge Item

// turbo

- Use the template: `.agent/knowledge/templates/knowledge-item-template.md`
- Generate a unique ID following the pattern: `[category-prefix]-[topic]-[number]`
  - Prefixes: `prin-`, `ptrn-`, `feat-`, `fix-`, `gloss-`, `recipe-`
- Set version to `1.0.0`
- Assign a persona owner: `staff_developer` / `staff_designer` / `staff_pm` / `staff_qa`
- Add descriptive tags

## Step 3: Write the Content

// turbo
Must include ALL of these sections:

- [ ] **Concept**: What is this, in one plain-English sentence
- [ ] **Principles**: The rules or aesthetic guidelines
- [ ] **Technical Pattern**: Code examples (if applicable)
- [ ] **Hardening**: Edge cases, security, and failure modes
- [ ] **RAG-TAGS**: Hashtags for searchability

## Step 4: Index in Registry

// turbo

- [ ] Add node to `registry.json` → `graph.[category].nodes`
- [ ] Add ALL relevant keywords to `registry.json` → `keywords`
- [ ] Set `depends_on` links to related KIs
- [ ] Bump `registry.json` version (patch increment)

## Step 5: Verify

// turbo

- [ ] File exists at the path referenced in registry
- [ ] `registry.json` parses without error (run JSON validation)
- [ ] Re-query with original keywords → confirm match now returns the new KI
- [ ] GEMINI.md Knowledge Graph table counts still accurate

## Step 6: Declare

Log the gap fill in the task summary:

```
🔴 RAG GAP FILLED: [topic]
   Category: [category]
   Severity: [severity]
   New KI: [filename]
   Keywords added: [list]
```

## // turbo-all
