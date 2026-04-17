# AutoMate

A mobile + PWA companion app for car owners. Register your vehicle once and get
maintenance reminders tailored to your car, correct consumable specs, in-app
repair tutorials filtered for your exact model, AI-powered voice breakdown
assistance, and a generated workshop report you can hand to a mechanic.

Built with Flutter — one codebase ships to Android, iOS, and the web as an
installable PWA.

---

## Core design principle

**Skill level drives everything.** At registration, the user picks one of:

| Level          | What it changes                                                                 |
|----------------|---------------------------------------------------------------------------------|
| `beginner`     | Suggests workshops, simple language, avoids DIY for complex jobs.               |
| `intermediate` | Shows tutorials, explains fault codes, offers DIY with step-by-step guidance.   |
| `pro`          | Full technical detail, raw OBD-II data, minimal hand-holding.                   |

Every AI recommendation, tutorial filter, and repair suggestion branches on
this value.

---

## Features

### Vehicle management
- Multiple vehicles per account
- Optional OCR scan of the registration document to auto-fill fields
- Vehicle specs pulled from the free NHTSA vPIC API
- Skill level stored per user

### Maintenance reminders
- Triggered by date **or** mileage (whichever comes first)
- Types: oil change, TÜV/MOT, major service, minor service, seasonal tyre swap, custom
- Configurable notification offsets per reminder (e.g. 8 weeks / 4 weeks / 1 week before)
- Full maintenance history log (with delete)

### Consumables tracker
- Per vehicle: engine oil grade + volume, coolant, brake fluid, transmission fluid
- QR code of the spec to show at the shop
- Optional retailer deep links

### Repair tutorials
- YouTube Data API v3 search scoped to `{make} {model} {year} {issue}`
- In-app video player — no app switching
- Pre-repair checklist: tools, parts, estimated time

### Workshop report
- AI generates a clear technical summary of the diagnosed problem
- Export as PDF or plain text
- Multilingual output (DE/EN/FR/ES/IT) — useful when broken down abroad
- Approximate market repair cost estimate

### AI breakdown assistant
- Voice-first interface — fully hands-free
- Natural-language problem description via Google Gemini
- OBD-II fault code reader via Bluetooth ELM327 adapter (native only)
- Recommendations branch on skill level
- Nearby garage finder on an OpenStreetMap view, using actual GPS

---

## Tech stack

| Layer              | Choice                                                   |
|--------------------|----------------------------------------------------------|
| Mobile             | Flutter + Dart (iOS & Android)                           |
| Web / PWA          | Flutter Web — installable, offline-first service worker  |
| State management   | Riverpod                                                 |
| Routing            | go_router                                                |
| Local DB           | Drift (SQLite on native, WASM worker + IndexedDB on web) |
| AI / LLM           | Google Gemini (`gemini-2.5-flash`)                       |
| Voice              | `speech_to_text` + `flutter_tts` (native)                |
| Vehicle specs      | NHTSA vPIC (free, no key)                                |
| Tutorials          | YouTube Data API v3                                      |
| Maps               | `flutter_map` + OpenStreetMap tiles                      |
| Geolocation        | `geolocator`                                             |
| OCR                | Google ML Kit via `google_mlkit_text_recognition`        |
| OBD-II             | `flutter_bluetooth_serial` + ELM327                      |
| PDF export         | `pdf` + `printing`                                       |
| Notifications      | `flutter_local_notifications` (native), Web Notification API (PWA) |

---

## Getting started

### Prerequisites
- Flutter SDK ≥ 3.11
- Android Studio / command-line SDK tools (for Android builds)
- Xcode (for iOS builds)
- A Gemini API key — https://aistudio.google.com/app/apikey
- Optional: a YouTube Data API v3 key for the tutorials tab

### Install
```bash
git clone https://github.com/felixcrafter54/auto-mate.git
cd auto-mate
flutter pub get
```

API keys are **not** committed — users enter them once in Settings, and they
are stored locally via the `AppSettings` table in Drift.

### Run (dev)
```bash
flutter run                       # whichever device is connected
flutter run -d chrome             # fastest iteration on web
flutter run -d <device-id>        # pick a specific device
```

### Build Android
```bash
flutter build apk --release
flutter install -d <device-id>
```
The release build ships with ProGuard rules for
`flutter_local_notifications` — these are required. Without them, scheduled
notifications fail at runtime with `Missing type parameter` because R8 strips
Gson's generic signatures.

### Build the PWA
```bash
flutter build web --release
cd build/web && python3 -m http.server 8080
# open http://localhost:8080
```

Chrome only shows the "Install app" button for **release** builds —
`flutter run -d chrome` does not register a service worker.

---

## Platform-specific notes

### Android
- Notifications use `AlarmManager` (`inexactAllowWhileIdle` mode), no exact-alarm permission required.
- `RECEIVE_BOOT_COMPLETED` + `ScheduledNotificationBootReceiver` re-register alarms after reboot.
- `POST_NOTIFICATIONS` is requested at runtime on Android 13+.

### PWA
- Permission prompt and Notification API work in any Chromium/Firefox.
- Scheduled notifications only fire **while the PWA tab/window is open** — true background push would require Firebase Cloud Messaging + a server, which is intentionally out of scope for now.
- The browser Notification API is wrapped via `package:web` with a conditional import; native builds use a stub so `dart:js_interop` is never imported on non-web platforms.

### Graceful degradation
Features that need native APIs degrade cleanly on the PWA:
- Voice assistant, OBD-II BLE, camera OCR → native only; the app prompts to install the mobile app.
- Location → PWA asks for browser permission; falls back to a central-Germany view if denied.

---

## Folder layout

```
auto_mate/
├── lib/
│   ├── main.dart
│   ├── app.dart                        # MaterialApp + go_router
│   ├── core/
│   │   ├── providers/                  # Riverpod root providers
│   │   ├── router/
│   │   └── theme/
│   ├── features/
│   │   ├── vehicle_setup/
│   │   ├── vehicle_detail/
│   │   ├── dashboard/
│   │   ├── reminders/                  # list, add, history
│   │   ├── consumables/
│   │   ├── tutorials/                  # YouTube search + embed
│   │   ├── breakdown/                  # AI assistant + garage finder
│   │   ├── workshop_report/
│   │   ├── onboarding/
│   │   ├── profile/
│   │   └── settings/
│   └── services/
│       ├── database/                   # Drift tables + repositories
│       ├── gemini_service.dart
│       ├── youtube_service.dart
│       ├── nhtsa_service.dart
│       ├── notification_service.dart
│       ├── web_notification_stub.dart  # non-web stub
│       └── web_notification_web.dart   # package:web impl
├── android/
│   └── app/proguard-rules.pro          # flutter_local_notifications keeps
├── web/
│   ├── manifest.json                   # PWA manifest
│   ├── drift_worker.js                 # Drift WASM worker
│   └── sqlite3.wasm
└── CLAUDE.md                           # additional context for Claude Code
```

---

## Data model

```
User
  ├── name, email
  ├── skill_level: 'beginner' | 'intermediate' | 'pro'
  └── vehicles[]
        ├── make, model, year, vin, fuel_type
        ├── current_mileage
        ├── reminders[]
        │     ├── type: oil_change | tuev | major_service | minor_service | tyre_swap | custom
        │     ├── custom_label                # for type=custom
        │     ├── due_date
        │     ├── due_mileage
        │     ├── notify_offsets_days         # CSV, e.g. "56,28,7"
        │     └── notified
        ├── maintenance_history[]
        │     ├── type, completed_date, mileage_at_completion
        │     ├── notes, workshop_name, cost
        └── consumables
              ├── engine_oil_grade, engine_oil_volume
              ├── coolant_type, brake_fluid_spec, transmission_fluid
```

---

## License

No license chosen yet. All rights reserved by the author.
