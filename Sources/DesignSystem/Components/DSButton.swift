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
