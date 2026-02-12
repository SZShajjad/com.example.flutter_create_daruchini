---
name: mobile_flutter
router_kit: FullStackKit
description: Flutter/Dart best practices ve architecture.
---
# 🐦 Mobile Flutter
## 📁 Proje Yapısı (Feature-First)
lib/core/, lib/features/, lib/services/

## 🧩 Widget Best Practices
- const constructor kullan.
- Statik widgetları işaretle.

## ⚡ Performance
- ListView.builder kullan.
- Isolate for CPU-heavy tasks.

## 🔄 Workflow
1. **Architecture**: Feature-First yapısını kur.
2. **Implementation**: const constructorları kullanarak rebuild'leri minimize et.
3. **Quality**: Unit/Widget/Integration testlerini yaz.
