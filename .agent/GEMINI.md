# 📜 Antigravity Global Rules & Memory (RAG-Augmented)

## 🧠 System Protocol: @/super_protokol_v3

Every action follows the Cognitive Engine lifecycle:

1. **Discovery (AUTO-TRIGGER)**:
   - **MANDATORY**: Extract keywords from the user's query and match against `registry.json` `keywords` index
   - Auto-load ALL matching knowledge items — do NOT wait for manual lookup
   - Check glossary (`knowledge/glossary/`) for term translations
   - Check `knowledge/recipes/` for pre-built guides that match the request
   - If **zero matches found** → this is a **RAG GAP** — trigger the Gap Audit (see below)
2. **Strategy**: Align with `SKILL.md`, evaluate against `user-personas`, and establish **Common Ground**. If the user is non-technical, activate **Non-Tech Mode**.
3. **Execution**: Adopt a Persona to perform the task with a focus on **Plain Language** clarity. In case of conflicting persona goals, the **Project Manager** is the final tie-breaker.
4. **Verification**: Validate with **Proof of Work**, **Visual Evidence**, and **Self-Audit**.
5. **Harvest (MANDATORY)**: After EVERY task, run the Gap Audit Checklist. Update `.agent/knowledge/` with new learnings. This is NOT optional.

---

## 🔴 RAG Auto-Trigger Protocol

The RAG system is PASSIVE-AGGRESSIVE — it fires automatically, not on request.

### How It Works

```text
USER QUERY → Extract Keywords → Match registry.json keywords → Load KIs → Respond
```

### Trigger Rules

| User Says... | Keywords Extracted | KIs Auto-Loaded |
| --- | --- | --- |
| "Fix the login" | `auth`, `secure` | bulletproof-auth-logic, secure-auth-suite, account-enumeration |
| "Make it look premium" | `premium`, `vibe` | premium-ui-vibe, vibe-coder-best-practices |
| "Add a new screen" | `screen`, `recipe` | add-new-screen recipe |
| "Build an APK" | `build`, `recipe` | build-release-apk recipe |
| "Why does it crash?" | `safety`, `disposal` | async-context-safety, resource-management |
| "Add Firebase database" | `firebase`, `recipe` | add-firebase-feature recipe, firebase-glossary |

### If Zero Matches → RAG GAP DETECTED

When a user query produces zero keyword matches, this is a **gap in the knowledge system**. The agent MUST:

1. Log the gap (what was asked, what was missing)
2. Complete the task using first principles
3. After completion, run the **RAG Gap Audit Checklist** (below)
4. Create or update the missing KI
5. Add the new node + keywords to `registry.json`

---

## 📋 RAG Gap Audit Checklist

Run this after EVERY task where a gap was detected. **Every box must be checked.**

```text
GAP AUDIT — [Topic]
━━━━━━━━━━━━━━━━━━━
- [ ] Gap identified: [what was missing]
- [ ] Category determined: principles / patterns / features / fixes / glossary / recipes
- [ ] KI created with proper YAML frontmatter (id, version, persona, tags)
- [ ] Content follows knowledge-item-template.md format
- [ ] File placed in correct subdirectory
- [ ] Node added to registry.json graph
- [ ] Keywords added to registry.json keywords index
- [ ] depends_on links set (if applicable)
- [ ] registry.json version bumped
- [ ] skills_manifest.json updated (if new skill created)
- [ ] GEMINI.md Knowledge Graph table updated (if new category/count changed)
```

---

## 🗣️ Non-Tech Mode Protocol

When working with a non-technical user:

- **Always explain** what you're doing in one sentence of plain English BEFORE doing it
- **Use the Glossary** — look up terms in `knowledge/glossary/` and use the "What It Actually Means" column
- **Back-Translate** — after every change, write a "What this means for you" summary
- **Avoid Jargon** — never say "widget", "context", "provider" etc. without explanation
- **Recipe-First** — check `knowledge/recipes/` before building from scratch
- **One Question Rule** — ask at most ONE clarifying question per request

### 🍳 Recipe Triggers

Users can say "recipe: [name]" to trigger a pre-built guide:

- `recipe: add screen` → follows `knowledge/recipes/add-new-screen.md`
- `recipe: firebase` → follows `knowledge/recipes/add-firebase-feature.md`
- `recipe: icon` → follows `knowledge/recipes/change-app-icon.md`
- `recipe: build apk` → follows `knowledge/recipes/build-release-apk.md`
- `recipe: publish` → follows `knowledge/recipes/publish-to-play-store.md`

## 🛡️ Engineering Principles

- **Context Engineering**: Maintain deep, structured project memory via `.agent/skills`.
- **Zero-Gap Policy**: Every completed task must leave the RAG system stronger than before.
- **Auto-Trigger First**: Never manually browse knowledge — let keywords pull relevant KIs.

## 📁 Integrated Expertise (20 Modules)

### 👥 Autonomous Workforce (Staff)

- **Project Manager, Designer, Developer, QA Agent**.

### Meta-Infrastructure

- **Skills Creator, Skills Audit, Skills Architecture, System Builder, Context Engineering, RAG Audit**.

### Non-Technical Support (Empathy Layer)

- **User Personas**: Profile-based simulation.
- **User Simulation**: Pre-emptive confusion detection.
- **Technical Translation**: Jargon-to-Job mapping.

### Technical Domain

- **Mobile Flutter, Advanced Auth, Auth Patterns, Premium UI**.

### Operation & Methodology

- **Scientific Thinking, Debugging Methodology, Error Handling**.

## 📚 Knowledge Graph

| Category | Purpose | Count |
| --- | --- | --- |
| `principles/` | Core design and system principles | 4 |
| `patterns/` | Reusable implementation patterns | 2 |
| `features/` | Feature-level documentation | 1 |
| `fixes/` | Bug fix patterns and solutions | 4 |
| `glossary/` | Plain-English term dictionaries | 3 |
| `recipes/` | Step-by-step "how to" guides | 5 |
| `templates/` | Knowledge item templates | 1 |
