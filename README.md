# DesignSystem

Auto-generated Swift Package from the [Figma Library](https://www.figma.com/design/cJ8OmSmwIOX0kMV9bmVgic/Library?node-id=6-419).

## Contents

### Tokens
| File | Exports |
|---|---|
| `ColorTokens.swift` | `Color.labelPrimary`, `.labelAccentSecondary`, `.backgroundAccent`, `.backgroundSecondary`, `.backgroundGlass`, `.black8`, `.white60` + `UIColor` equivalents |
| `TypographyTokens.swift` | `DSFont`, `DSSpacing`, `DSSize`, `DSRadius` |

### Components
| File | Figma Node | Variants |
|---|---|---|
| `DSButton.swift` | `29:730` | Prominence × Type × Material × Size × Disabled |
| `DSStatusBar.swift` | `9:432` | Device widths: 375s / 375 / 390 / 393 / 402 / 420 / 430 / 440 |
| `DSNavigationBar.swift` | `26:251`, `26:379`, `26:388` | Sheet / Regular, Title / Title+Subtitle, enabled/disabled buttons |
| `DSTabBar.swift` | `31:623`, `31:663`, `31:606` | Selected/Unselected tabs, Home Indicator |

## Installation

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/medium-jpg/demo", branch: "main")
],
targets: [
    .target(name: "YourTarget", dependencies: ["DesignSystem"])
]
```

## Usage

```swift
import DesignSystem

DSButton(label: "Continue", prominence: .primary, size: .large) { }
DSStatusBar(deviceWidth: .w393, time: "9:41")
DSNavigationBar(centerContent: .title("My Screen"), trailingAction: { }, trailingLabel: "Done")
```
