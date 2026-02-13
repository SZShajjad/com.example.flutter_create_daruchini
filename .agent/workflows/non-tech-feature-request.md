---
description: Step-by-step workflow for when a non-tech user says "I want X" — translates intent into implementation
---

# 🗣️ Non-Tech Feature Request Workflow

This workflow ensures every feature request from a non-technical user is understood, translated, built, and verified — with plain-English updates at every step.

## 1. Listen & Understand (Persona: Project Manager)

- Read the user's request carefully
- Identify the **intent** (what they want to achieve) vs the **words** (what they literally said)
- Run `technical-translation` to map the request to technical objectives
- Ask ONE clarifying question if needed — never more

## 2. Explain the Plan (Persona: Project Manager)

- Write a plain-English summary of WHAT will be done and WHY
- Use the glossary (`knowledge/glossary/`) to translate any technical terms
- Include a "What this means for you" section
- Show estimated number of files that will change

## 3. Check for Recipes (Persona: Developer)

- Search `knowledge/recipes/` for matching pre-built guides
- If a recipe exists, follow it step-by-step
- If no recipe exists, create one after the task is done

## 4. Build (Persona: Developer)

- Follow the `agency-production.md` workflow for implementation
- Check `knowledge/patterns/` and `knowledge/fixes/` for relevant patterns
- Apply `premium-ui` skill for all visual elements

## 5. Verify (Persona: QA Agent)

- Run `dart analyze` — must be zero errors
- Run `flutter build apk --debug` to ensure it compiles
- Check for `mounted` guards, controller disposal, and error handling

## 6. Report Back (Persona: Project Manager)

- Write a "What Changed" summary in NON-TECHNICAL language
- Include before/after descriptions where relevant
- Example: "The login screen now shows a strength meter when you type your password"

## 7. Harvest (Persona: Developer)

// turbo

- Update `.agent/knowledge/` with any new patterns learned
- Follow the `knowledge-harvest.md` workflow
- Update `registry.json` with new nodes

## // turbo-all
