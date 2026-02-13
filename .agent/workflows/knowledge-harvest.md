---
description: How to harvest learnings after a bug fix or feature implementation
---

# 🌾 Knowledge Harvest Workflow

Follow these steps after completing a task to ensure the RAG system learns:

1. **Identify the Lesson**
   - Was this a new feature? -> `/features/`.
   - Was this a bug fix? -> `/fixes/`.
   - Was this an aesthetic change? -> `/principles/`.

2. **Generate Metadata**
   - Assign a Unique ID (e.g., `feat-xyz-001`).
   - Set Version to `1.0.0`.
   - Designate the owner Persona (e.g., `staff_developer`).
   - Add descriptive Tags.

3. **Standardize the Content**
   - Use the `knowledge-item-template.md`.
   - Ensure "Vibe Coder" friendly language.

4. **Update Registry**
   - Add the new node to `.agent/knowledge/registry.json`.
   - Establish `depends_on` links if applicable.

5. **Check Integrity**
   - Ensure all file links are absolute.
   - Save the file to the correct sub-directory in `.agent/knowledge/`.
   - Mention the "Harvest" in the final task summary.
