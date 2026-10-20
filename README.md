# Quotes App

A small Flutter app that fetches a random inspirational quote from a public REST API each time you tap a button.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)

<!-- Add a screenshot here: ![screenshot](docs/screenshot.png) -->

## Features

- Tap **Get Quote** to load a new random quote and its author
- Loading spinner while the request is in flight, with a 10-second timeout
- Friendly error message if the request fails
- Gradient background, fade-in animation and Google Fonts typography (Playfair Display and Poppins)

## Tech

- **Flutter / Dart**
- [`http`](https://pub.dev/packages/http) for the REST call
- [`google_fonts`](https://pub.dev/packages/google_fonts)

## Run it

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install).

```bash
git clone https://github.com/malharp1906/flutter-quotes-app
cd flutter-quotes-app
flutter pub get
flutter run
```

## Project structure

```
lib/
├── main.dart              # App entry point
└── screens/
    └── home_screen.dart   # UI and the API call
```

## Ideas for next steps

- [ ] Dark mode
- [ ] Share / copy a quote
- [ ] Move the API call into its own service class and add tests
- [ ] Favourite quotes saved on the device

## License

[MIT](LICENSE)
