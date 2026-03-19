#!/usr/bin/env python3
"""
Pushes the DesignSystem Swift package to GitHub via the REST API.
No git installation required — just Python 3 (pre-installed on macOS).

Usage:
    python3 push_to_github.py

You will be prompted for your GitHub Personal Access Token.
The token needs the 'repo' scope.
"""

import urllib.request
import urllib.error
import json
import base64
import getpass
import os

# ── Config ────────────────────────────────────────────────────────────────────
REPO  = "medium-jpg/demo"
BRANCH = "main"
COMMIT_MESSAGE = "feat: add DesignSystem Swift package from Figma Library"

FILES = {
    "Package.swift": """\
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            path: "Sources/DesignSystem"
        ),
    ]
)
""",

    "README.md": """\
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
""",

    "Sources/DesignSystem/DesignSystem.swift": """\
// DesignSystem.swift
@_exported import SwiftUI
""",

    "Sources/DesignSystem/Tokens/ColorTokens.swift": """\
// ColorTokens.swift
// Auto-generated from Figma Library — Node 6:419 (Elements)

import SwiftUI

public extension Color {
    static let labelPrimary = Color(UIColor { t in
        t.userInterfaceStyle == .dark ? UIColor(white: 1, alpha: 0.9) : UIColor(white: 0, alpha: 0.9)
    })
    static let labelAccentSecondary = Color.white
    static let backgroundAccent     = Color(red: 0.071, green: 0.506, blue: 0.984)
    static let backgroundSecondary  = Color(UIColor { t in
        t.userInterfaceStyle == .dark ? UIColor(white: 0.18, alpha: 0.9) : UIColor(white: 1, alpha: 0.9)
    })
    static let backgroundGlass      = Color(UIColor { t in
        t.userInterfaceStyle == .dark ? UIColor(white: 1, alpha: 0.15) : UIColor(white: 1, alpha: 0.3)
    })
    static let black8  = Color.black.opacity(0.08)
    static let white60 = Color.white.opacity(0.6)
}

public extension UIColor {
    static let labelPrimary       = UIColor { t in t.userInterfaceStyle == .dark ? UIColor(white:1,alpha:0.9) : UIColor(white:0,alpha:0.9) }
    static let backgroundAccent   = UIColor(red:0.071, green:0.506, blue:0.984, alpha:1)
    static let backgroundSecondary = UIColor { t in t.userInterfaceStyle == .dark ? UIColor(white:0.18,alpha:0.9) : UIColor(white:1,alpha:0.9) }
    static let backgroundGlass    = UIColor { t in t.userInterfaceStyle == .dark ? UIColor(white:1,alpha:0.15) : UIColor(white:1,alpha:0.3) }
}
""",

    "Sources/DesignSystem/Tokens/TypographyTokens.swift": """\
// TypographyTokens.swift
// Auto-generated from Figma Library — Node 6:419 (Elements)

import SwiftUI

public struct DSFont {
    public static let bodyMedium        = Font.system(size: 17, weight: .medium)
    public static let bodyMediumKerning: CGFloat = -0.31
    public static let caption           = Font.system(size: 12, weight: .medium)
    public static let captionKerning: CGFloat = 0
    public static let statusBarTime     = Font.system(size: 17, weight: .semibold)
    public static let statusBarTimeSmall = Font.system(size: 12, weight: .semibold)
}

public struct DSSpacing {
    public static let size4:  CGFloat = 4
    public static let size12: CGFloat = 12
    public static let size16: CGFloat = 16
}

public struct DSSize {
    public static let buttonSmall:    CGFloat = 44
    public static let buttonLarge:    CGFloat = 52
    public static let buttonMinWidth: CGFloat = 56
    public static let iconButtonSmall: CGFloat = 44
    public static let iconButtonLarge: CGFloat = 52
    public static let buttonIcon:     CGFloat = 36
}

public struct DSRadius {
    public static let round: CGFloat = 1000
}
""",

    "Sources/DesignSystem/Components/DSButton.swift": """\
// DSButton.swift
// Auto-generated from Figma Library — Node 29:730 (Button)

import SwiftUI

public enum DSButtonProminence { case primary, secondary }
public enum DSButtonType       { case label, icon }
public enum DSButtonMaterial   { case `default`, liquidGlass }
public enum DSButtonSize       { case small, large }

public struct DSButton: View {
    public var label: String            = "Label"
    public var prominence: DSButtonProminence = .primary
    public var type: DSButtonType       = .label
    public var material: DSButtonMaterial = .liquidGlass
    public var size: DSButtonSize       = .small
    public var isDisabled: Bool         = false
    public var leadingIcon: Image?      = nil
    public var trailingIcon: Image?     = nil
    public var action: () -> Void

    public init(label: String = "Label", prominence: DSButtonProminence = .primary,
                type: DSButtonType = .label, material: DSButtonMaterial = .liquidGlass,
                size: DSButtonSize = .small, isDisabled: Bool = false,
                leadingIcon: Image? = nil, trailingIcon: Image? = nil,
                action: @escaping () -> Void) {
        self.label = label; self.prominence = prominence; self.type = type
        self.material = material; self.size = size; self.isDisabled = isDisabled
        self.leadingIcon = leadingIcon; self.trailingIcon = trailingIcon; self.action = action
    }

    private var backgroundColor: Color {
        switch prominence {
        case .primary:   return .backgroundAccent
        case .secondary: return material == .liquidGlass ? .backgroundGlass : .backgroundSecondary
        }
    }
    private var foregroundColor: Color { prominence == .primary ? .labelAccentSecondary : .labelPrimary }
    private var buttonHeight: CGFloat  { size == .small ? DSSize.buttonSmall : DSSize.buttonLarge }
    private var iconSize: CGFloat      { size == .small ? DSSize.iconButtonSmall : DSSize.iconButtonLarge }
    private var hasGlass: Bool         { material == .liquidGlass }

    public var body: some View {
        Button(action: { if !isDisabled { action() } }) {
            Group {
                if type == .icon { iconContent } else { labelContent }
            }
            .background(backgroundColor)
            .clipShape(Capsule())
            .overlay(hasGlass ? AnyView(Capsule().strokeBorder(.white60, lineWidth: 1)) : AnyView(EmptyView()))
            .shadow(color: hasGlass ? .black8 : .clear, radius: 8, x: 0, y: 2)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
    }

    private var labelContent: some View {
        HStack(spacing: DSSpacing.size4) {
            if let l = leadingIcon { l.font(DSFont.caption).foregroundColor(foregroundColor).frame(width: DSSize.buttonIcon, height: DSSize.buttonIcon).clipped() }
            Text(label).font(DSFont.bodyMedium).kerning(DSFont.bodyMediumKerning).foregroundColor(foregroundColor)
            if let t = trailingIcon { t.font(DSFont.caption).foregroundColor(foregroundColor).frame(width: DSSize.buttonIcon, height: DSSize.buttonIcon).clipped() }
        }
        .frame(height: buttonHeight)
        .frame(minWidth: DSSize.buttonMinWidth)
        .padding(.horizontal, DSSpacing.size16)
    }

    private var iconContent: some View {
        (leadingIcon ?? Image(systemName: "circle"))
            .font(DSFont.caption)
            .foregroundColor(foregroundColor)
            .frame(width: iconSize, height: iconSize)
    }
}

#if DEBUG
#Preview {
    VStack(spacing: 12) {
        DSButton(label: "Primary Large", prominence: .primary, size: .large) {}
        DSButton(label: "Secondary Small", prominence: .secondary, size: .small) {}
        DSButton(prominence: .primary, type: .icon, size: .small) {}
        DSButton(label: "Disabled", isDisabled: true) {}
    }.padding().background(Color(white:0.93))
}
#endif
""",

    "Sources/DesignSystem/Components/DSStatusBar.swift": """\
// DSStatusBar.swift
// Auto-generated from Figma Library — Node 9:432 ([System] Status Bar)

import SwiftUI

public enum DSStatusBarDevice: CGFloat {
    case w375s=375, w375=375, w390=390, w393=393, w402=402, w420=420, w430=430, w440=440
    public var height: CGFloat {
        switch self {
        case .w375s: return 20; case .w375: return 44; case .w390: return 47
        case .w393: return 52; default: return 54
        }
    }
    public var isDynamicIsland: Bool { [.w393,.w402,.w420,.w430,.w440].contains(self) }
}

public struct DSStatusBar: View {
    public var deviceWidth: DSStatusBarDevice
    public var time: String
    public init(deviceWidth: DSStatusBarDevice = .w393, time: String = "9:41") {
        self.deviceWidth = deviceWidth; self.time = time
    }
    public var body: some View {
        ZStack {
            if deviceWidth.isDynamicIsland { dynamicLayout } else { legacyLayout }
        }
        .frame(width: deviceWidth.rawValue, height: deviceWidth.height)
    }
    private var dynamicLayout: some View {
        HStack {
            Text(time).font(DSFont.statusBarTime).foregroundColor(.labelPrimary).padding(.leading, 16)
            Spacer()
            HStack(spacing: 6) {
                Image(systemName: "cellularbars"); Image(systemName: "wifi"); Image(systemName: "battery.100")
            }.font(.system(size:12,weight:.semibold)).foregroundColor(.labelPrimary).padding(.trailing, 16)
        }
    }
    private var legacyLayout: some View {
        HStack {
            Text(time)
                .font(deviceWidth == .w375s ? DSFont.statusBarTimeSmall : DSFont.statusBarTime)
                .foregroundColor(.labelPrimary).padding(.leading, 15)
            Spacer()
            HStack(spacing:6) {
                Image(systemName:"cellularbars"); Image(systemName:"wifi"); Image(systemName:"battery.100")
            }.font(.system(size:12,weight:.semibold)).foregroundColor(.labelPrimary).padding(.trailing, 15)
        }
    }
}
""",

    "Sources/DesignSystem/Components/DSNavigationBar.swift": """\
// DSNavigationBar.swift
// Auto-generated from Figma Library — Nodes 26:251, 26:379, 26:388

import SwiftUI

public enum DSNavCenterType { case title(String), titleAndSubtitle(String, String) }

public struct DSNavigationBar: View {
    public var isSheet: Bool
    public var centerContent: DSNavCenterType
    public var leadingAction: (() -> Void)?
    public var trailingAction: (() -> Void)?
    public var leadingLabel: String?
    public var trailingLabel: String?

    public init(isSheet: Bool = false, centerContent: DSNavCenterType = .title("Title"),
                leadingAction: (() -> Void)? = nil, trailingAction: (() -> Void)? = nil,
                leadingLabel: String? = nil, trailingLabel: String? = nil) {
        self.isSheet = isSheet; self.centerContent = centerContent
        self.leadingAction = leadingAction; self.trailingAction = trailingAction
        self.leadingLabel = leadingLabel; self.trailingLabel = trailingLabel
    }

    public var body: some View {
        VStack(spacing: 0) {
            if isSheet {
                RoundedRectangle(cornerRadius: 3).fill(Color.secondary.opacity(0.4))
                    .frame(width: 36, height: 5).padding(.top, 8).padding(.bottom, 4)
            }
            HStack(alignment: .center, spacing: 0) {
                navBtn(label: leadingLabel, action: leadingAction, isLeading: true)
                centerView.frame(maxWidth: .infinity)
                navBtn(label: trailingLabel, action: trailingAction, isLeading: false)
            }
            .frame(height: 44).padding(.horizontal, 16)
        }
        .frame(width: 393)
    }

    @ViewBuilder private var centerView: some View {
        switch centerContent {
        case .title(let t):
            Text(t).font(.system(size:17,weight:.semibold)).foregroundColor(.labelPrimary)
        case .titleAndSubtitle(let t, let s):
            VStack(spacing:0) {
                Text(t).font(.system(size:17,weight:.semibold)).foregroundColor(.labelPrimary)
                Text(s).font(.system(size:12)).foregroundColor(.secondary)
            }
        }
    }

    @ViewBuilder private func navBtn(label: String?, action: (() -> Void)?, isLeading: Bool) -> some View {
        if let label, let action {
            Button(action: action) { Text(label).font(.system(size:17)).foregroundColor(.backgroundAccent) }
                .frame(width:44, height:44)
        } else if let action {
            Button(action: action) {
                Image(systemName: isLeading ? "chevron.left" : "xmark")
                    .font(.system(size:17,weight:.medium)).foregroundColor(.backgroundAccent)
            }.frame(width:44, height:44)
        } else {
            Color.clear.frame(width:44, height:44)
        }
    }
}
""",

    "Sources/DesignSystem/Components/DSTabBar.swift": """\
// DSTabBar.swift
// Auto-generated from Figma Library — Nodes 31:623, 31:663, 31:606

import SwiftUI

public struct DSTabItem: Identifiable {
    public let id = UUID()
    public let icon: Image
    public let selectedIcon: Image
    public let label: String
    public init(icon: Image, selectedIcon: Image? = nil, label: String) {
        self.icon = icon; self.selectedIcon = selectedIcon ?? icon; self.label = label
    }
}

public struct DSTabBar: View {
    public var items: [DSTabItem]
    @Binding public var selectedIndex: Int
    public var showHomeIndicator: Bool

    public init(items: [DSTabItem], selectedIndex: Binding<Int>, showHomeIndicator: Bool = true) {
        self.items = items; self._selectedIndex = selectedIndex; self.showHomeIndicator = showHomeIndicator
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(items.indices, id: \\.self) { i in
                    Button { selectedIndex = i } label: {
                        (i == selectedIndex ? items[i].selectedIcon : items[i].icon)
                            .font(.system(size:22))
                            .foregroundColor(i == selectedIndex ? .backgroundAccent : .secondary)
                            .frame(width:44, height:29)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 49)
            .background(.regularMaterial)
            .overlay(Rectangle().fill(Color.secondary.opacity(0.2)).frame(height:0.5), alignment:.top)

            if showHomeIndicator {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius:3).fill(Color.primary.opacity(0.2)).frame(width:134, height:5)
                    Spacer()
                }
                .frame(height: 21).background(.regularMaterial)
            }
        }
        .frame(width: 393)
    }
}
""",
}

# ── GitHub API helpers ─────────────────────────────────────────────────────────

def api(method, path, token, body=None):
    url = f"https://api.github.com{path}"
    data = json.dumps(body).encode() if body else None
    req = urllib.request.Request(url, data=data, method=method, headers={
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github+json",
        "User-Agent": "DesignSystem-pusher",
        "Content-Type": "application/json",
    })
    try:
        with urllib.request.urlopen(req, timeout=15) as r:
            return json.loads(r.read()), r.status
    except urllib.error.HTTPError as e:
        return json.loads(e.read()), e.code

def get_sha(path, token):
    resp, status = api("GET", f"/repos/{REPO}/contents/{path}", token)
    return resp.get("sha") if status == 200 else None

def push_file(path, content, token):
    sha = get_sha(path, token)
    body = {
        "message": COMMIT_MESSAGE,
        "content": base64.b64encode(content.encode()).decode(),
        "branch": BRANCH,
    }
    if sha:
        body["sha"] = sha
    resp, status = api("PUT", f"/repos/{REPO}/contents/{path}", token, body)
    return status in (200, 201)

# ── Main ───────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    print("GitHub DesignSystem Pusher")
    print("-" * 40)
    token = getpass.getpass("Paste your GitHub PAT (input hidden): ").strip()

    # Verify token
    info, status = api("GET", f"/repos/{REPO}", token)
    if status != 200:
        print(f"❌  Could not access repo: {info.get('message','unknown error')}")
        exit(1)
    print(f"✅  Connected to: {info['full_name']}")

    # Push each file
    total = len(FILES)
    for i, (path, content) in enumerate(FILES.items(), 1):
        print(f"[{i}/{total}] Pushing {path} ...", end=" ", flush=True)
        ok = push_file(path, content, token)
        print("✅" if ok else "❌ FAILED")

    print("\nDone! View your repo at https://github.com/medium-jpg/demo")
