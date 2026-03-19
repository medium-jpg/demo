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
