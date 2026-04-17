# AutoMate — Project Context for Claude Code

This file is read automatically by Claude Code as persistent project context.
Reference it when building any part of the AutoMate app.

---

## What is AutoMate?

A mobile companion app for car owners. Users register their vehicle once and get:
- Maintenance reminders tailored to their car
- Correct consumable specs (oil grade, fill volumes, etc.)
- In-app repair tutorials filtered for their exact model
- AI-powered voice breakdown assistance on the road
- A generated workshop report to hand to mechanics

---

## Core Design Principle

**Skill level drives everything.** At registration, the user picks:
- `beginner` — suggest workshops, simple explanations, avoid DIY for complex jobs
- `intermediate` — show tutorials, explain fault codes, offer DIY with guidance
- `pro` — full technical detail, OBD-II data, minimal hand-holding

Every AI recommendation, tutorial filter, and repair suggestion should branch on this value.

---

## Data Model (Simplified)

```
User
  ├── vehicles[]
  │     ├── make, model, year, vin, fuel_type
  │     ├── mileage (current)
  │     ├── skill_level: 'beginner' | 'intermediate' | 'pro'
  │     └── maintenance_history[]
  └── reminders[]
        ├── type: 'oil_change' | 'tuev' | 'inspection' | 'tyre' | 'custom'
        ├── due_date
        ├── due_km
        └── notified: boolean
```

---

## Modules & Phases

### Phase 1 — MVP (build first, no AI required)

#### Vehicle Management
- Register multiple vehicles per account
- Optional OCR scan of registration document → auto-fill fields
- Pull vehicle specs from open API (NHTSA or TecDoc)
- Store skill level per vehicle

#### Maintenance Reminders
- Reminders triggered by date OR mileage (whichever comes first)
- Types: oil change, TÜV/MOT, major service, minor service, seasonal tyre swap, custom
- Push notifications: 8 weeks / 4 weeks / 1 week before due
- Full maintenance history log

#### Consumables Tracker
- Per-vehicle: engine oil grade + volume, coolant type, brake fluid spec, transmission fluid
- Data sourced from vehicle spec DB / API
- QR code showing the correct spec (for use in a shop)
- Optional retailer deep links

---

### Phase 2 — Extended

#### Repair Tutorials
- YouTube Data API v3 search scoped to `{make} {model} {year} {issue}`
- In-app video player (no app switching)
- Written step-by-step instructions alongside video
- Pre-repair checklist: tools, parts, estimated time
- Direct buy links for tools and parts (Amazon / eBay / local)

#### Workshop Report
- AI generates a clear technical summary of the diagnosed problem
- Export as PDF or plain text
- Multilingual output (useful when broken down abroad)
- Includes approximate market repair cost estimate

---

### Phase 3 — AI Features (most complex)

#### AI Breakdown Assistant
- Voice-first interface — fully hands-free
- User describes problem in natural language → AI diagnosis
- OBD-II fault code reader via Bluetooth adapter → plain-language explanation
- Recommendation branches on skill level:
  - beginner → step-by-step or "call a mechanic"
  - intermediate → tutorial + parts list
  - pro → raw data + advanced options
- Nearby garage finder (Maps API / Google Places) with phone numbers + hours
- One-tap call to workshop or towing service

---

## Tech Stack

| Layer        | Choice                                                   |
|--------------|----------------------------------------------------------|
| Mobile       | Flutter + Dart (iOS & Android from one codebase)         |
| Web / PWA    | Flutter Web — same codebase, deployable as PWA           |
| Backend      | Node.js + Express or Fastify (or Dart with Shelf)        |
| Database     | PostgreSQL (vehicles, users, reminders)                  |
| Auth         | Supabase Auth or Firebase Auth                           |
| AI / LLM     | Google Gemini API (gemini-2.5-flash)                     |
| Voice        | `speech_to_text` package + `flutter_tts` for TTS         |
| Vehicle API  | NHTSA vPIC API (free) or TecDoc                          |
| Tutorials    | YouTube Data API v3                                      |
| Maps         | Google Maps Flutter plugin or `flutter_map` (OSM)        |
| OCR          | Google ML Kit via `google_mlkit_text_recognition`        |
| OBD-II       | `flutter_bluetooth_serial` + ELM327 adapter protocol     |
| PDF export   | `pdf` package (dart-pdf) or `printing` plugin            |
| State mgmt   | Riverpod (recommended) or Bloc                           |
| Local DB     | Drift (SQLite wrapper for Dart) for offline-first data   |

### PWA Notes
Flutter Web compiles to a PWA out of the box (`flutter build web --pwa-strategy=offline-first`).
Good fit for the Workshop Report and Consumables Tracker (light, shareable features).
Heavy features (OBD-II BLE, voice, camera OCR) require the native app — degrade gracefully on PWA with a prompt to install the mobile app.

---

## API Notes

### NHTSA vPIC (vehicle data, free)
```
GET https://vpic.nhtsa.dot.gov/api/vehicles/GetModelsForMakeYear/make/{make}/modelyear/{year}?format=json
```

### YouTube Data API v3 (tutorials)
```
GET https://www.googleapis.com/youtube/v3/search
  ?part=snippet
  &q={make}+{model}+{year}+{issue}
  &type=video
  &key={API_KEY}
```

### Google Gemini API (breakdown assistant, Dart)
```dart
final response = await http.post(
  Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent',
  ),
  headers: {
    'x-goog-api-key': apiKey,
    'content-type': 'application/json',
  },
  body: jsonEncode({
    'systemInstruction': {
      'parts': [
        {
          'text': 'You are an automotive assistant. '
              'Car: $vehicleMake $vehicleModel $vehicleYear. '
              'User skill level: $skillLevel. '
              'Give practical advice matching their skill level.'
        }
      ]
    },
    'contents': [
      {'role': 'user', 'parts': [{'text': userMessage}]}
    ],
    'generationConfig': {'maxOutputTokens': 1024},
  }),
);
final data = jsonDecode(response.body);
final reply = data['candidates'][0]['content']['parts'][0]['text'];
```

---

## Key Decisions to Remember

- OCR scan is **optional** — never block the user if they skip it
- Skill level is set **per vehicle**, not per account
- Workshop Report must work **offline** after generation (cached PDF)
- Voice assistant must be fully functional with screen off
- All AI responses must degrade gracefully if the API is unavailable (show manual fallback)

---

## Folder Structure (Flutter)

```
automate/
├── CLAUDE.md                      ← this file
├── pubspec.yaml                   ← Flutter dependencies
├── lib/
│   ├── main.dart
│   ├── app.dart                   ← MaterialApp / routing
│   ├── core/
│   │   ├── theme/
│   │   ├── router/                ← go_router
│   │   └── providers/             ← Riverpod root providers
│   ├── features/
│   │   ├── vehicle_setup/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── dashboard/
│   │   ├── reminders/
│   │   ├── consumables/
│   │   ├── tutorials/
│   │   ├── breakdown/             ← AI assistant + voice
│   │   └── workshop_report/
│   └── services/
│       ├── gemini_service.dart    ← Google Gemini API client
│       ├── youtube_service.dart
│       ├── nhtsa_service.dart
│       ├── obd_service.dart       ← BLE + ELM327
│       └── ocr_service.dart
├── web/                           ← Flutter Web / PWA output
│   └── manifest.json
├── backend/                       ← Optional: Node.js or Dart Shelf
│   ├── routes/
│   └── services/
└── docs/
    ├── concept.md
    └── pitch.html
```
