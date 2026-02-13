---
id: gloss-flutter-001
version: 1.0.0
persona: staff_pm
tags: [glossary, flutter, non-tech]
---

# 🐦 Flutter Glossary — Plain English

Everything the agent says about Flutter, translated for real people.

| Term | What It Actually Means | Why You Should Care |
| --- | --- | --- |
| **Widget** | A building block of the screen. A button is a widget, a text is a widget, even the screen itself is a widget. | Everything you see is made of widgets stacked together. |
| **State** | The "memory" of a widget. Does the button say "Submit" or "Loading..."? That's state. | When state changes, the screen updates automatically. |
| **BuildContext** | The widget's "address" in the app. It knows where it lives in the widget tree. | You never interact with this — but if the agent mentions it, it's fixing a navigation issue. |
| **Provider** | A way for different parts of the app to share information. Like a shared whiteboard. | This is how login status is shared between screens. |
| **Hot Reload** | Instant preview of your code changes without restarting the app. | Saves time — you see changes in under a second. |
| **Hot Restart** | Like hot reload, but resets all the app's memory. | Use when hot reload doesn't show your changes correctly. |
| **StatelessWidget** | A widget that never changes. Like a label that always says the same thing. | Simple, fast, and predictable. |
| **StatefulWidget** | A widget that can change. Like a counter that goes up when you tap it. | More complex, but necessary for interactive screens. |
| **Scaffold** | The basic layout skeleton of a screen — app bar at top, body in middle, nav bar at bottom. | Almost every screen starts with one. |
| **Navigator** | The system that moves you between screens. Like a stack of cards — you push new ones on top. | When the agent says "push" or "pop", it means going to or coming back from a screen. |
| **pubspec.yaml** | The app's shopping list. Lists all the packages (tools) the app needs. | When the agent "adds a dependency", it's adding to this list. |
| **Dart** | The programming language Flutter is built with. Clean, modern, and type-safe. | All your app's logic is written in Dart. |
| **Material 3** | Google's latest design system. Gives your app a modern, polished look automatically. | The "premium feel" uses Material 3 components. |
| **async / await** | A way to do something that takes time (like logging in) without freezing the screen. | Without this, the app would freeze while waiting for the internet. |
| **mounted** | Checks if a screen is still visible before updating it. | Prevents crashes when a screen disappears during a slow operation. |

## // RAG-TAGS

`#glossary` `#flutter` `#non-tech`
