# ClashOfGit

Flutter-приложение для просмотра статистики игроков и кланов в Clash of Clans.

## Описание

Приложение позволяет искать игроков и кланы по тегу, просматривать их статистику, состав армии, достижения и базы. Использует официальный API Clash of Clans.

## Технологии

- **Flutter 3.24.5** (Dart 3.5.4)
- **Firebase** — база данных и аналитика
- **flutter_bloc** — управление состоянием
- **provider** — зависимости
- **cached_network_image** — кэширование изображений

## Сборка

```bash
flutter pub get
flutter build apk --debug
flutter build apk --release
```

## CI/CD

Автоматическая сборка через GitHub Actions при пуше в main. Артефакты (APK) загружаются в Actions.

## Структура

- `lib/data/` — API, база данных, BLoC
- `lib/domain/` — модели данных
- `lib/presentation/` — экраны и виджеты
- `lib/internal/` — темы, константы, маршруты
- `assets/` — иконки ( troops, heroes, spells и т.д.)
