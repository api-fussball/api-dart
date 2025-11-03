# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2025-03-11

### Added
- Helper function `_parseGermanDouble()` in `TableResult` class to parse German-formatted decimal numbers (comma as separator)
- Helper function `_toNumOrInt()` in `TeamTableTransfer` class to intelligently convert doubles to integers when appropriate
- Comprehensive unit test with real HTML from fussball.de API including German decimal format validation
- Skip markers for problematic integration tests in CI/CD environment

### Changed
- **BREAKING**: Changed `TeamTableTransfer` field types from `int` to `double` for:
  - `games`, `won`, `draw`, `lost`, `goalDifference`, `points`
- Updated `toJson()` method in `TeamTableTransfer` to automatically convert whole number doubles to integers for cleaner JSON output
- Updated Dart SDK constraint from `^3.0.6` to `^3.9.0` in `pubspec.yaml`
- Upgraded dependencies:
  - `email_validator`: `^2.1.17` → `^3.0.0`
  - `sentry`: `^7.9.0` → `^9.0.0`
  - `lints`: `^2.0.0` → `^6.0.0`
  - `test`: `^1.21.0` → `^1.25.0`
- Fixed implicit call tearoff lint warning in `bin/server.dart`
- Fixed UTF-8 decoding in `test/api/server_test.dart`
- Updated test data to use 1. FC Köln instead of Fühlingen

### Fixed
- **Issue #11**: Fixed `FormatException: Invalid radix-10 number` when parsing team tables with German decimal format
  - API now correctly handles both integer values (`"5"`, `"10"`) and German float values (`"2,60"`, `"0,80"`)
  - Example endpoint: `/api/team/012TEDATMK000000VV0AG811VVETIMC3`
- Fixed JSON output to show integers for whole numbers instead of floats
  - Before: `"points": 44.0`, After: `"points": 44`
  - Decimal values remain as floats: `"points": 2.6`

### Technical Details

#### German Decimal Format Handling
The fussball.de API returns numeric values in two formats:
- **Standard format**: Integer strings like `"18"`, `"5"`, `"-51"`
- **German decimal format**: Float strings with comma separator like `"2,60"`, `"0,80"`, `"2,20"`

This typically occurs in "Punkte Ø" (Average Points) tables.

#### JSON Response Changes
Team table responses now return appropriate number types:

**Before** (all values as floats):
```json
{
  "games": 5.0,
  "won": 4.0,
  "points": 44.0,
  "goalDifference": -10.0
}
```

**After** (integers for whole numbers, floats for decimals):
```json
{
  "games": 5,
  "won": 4,
  "points": 44,
  "goalDifference": -10
}
```

**With decimal points** (Punkte Ø tables):
```json
{
  "games": 5,
  "won": 4,
  "points": 2.6,
  "goalDifference": 9
}
```

## [1.0.0] - Initial Release

- Initial version.
