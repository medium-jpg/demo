// Navbar.swift
// Renamed from DSNavigationBar.swift to match Figma component name "Navbar"
// Figma node: 29:675
// https://www.figma.com/design/cJ8OmSmwIOX0kMV9bmVgic/Library?node-id=29-675

import SwiftUI

public enum NavbarCenterType { case title(String), titleAndSubtitle(String, String) }

/// Matches the Figma "Navbar" component (node 29:675).
/// Previously named DSNavigationBar.
public struct Navbar: View {
    public var isSheet: Bool
    public var centerContent: NavbarCenterType
    public var leadingAction: (() -> Void)?
    public var trailingAction: (() -> Void)?
    public var leadingLabel: String?
    public var trailingLabel: String?

    public init(
        isSheet: Bool = false,
        centerContent: NavbarCenterType = .title("Title"),
        leadingAction: (() -> Void)? = nil,
        trailingAction: (() -> Void)? = nil,
        leadingLabel: String? = nil,
        trailingLabel: String? = nil
    ) {
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
            Text(t).font(.system(size: 17, weight: .semibold)).foregroundColor(.labelPrimary)
        case .titleAndSubtitle(let t, let s):
            VStack(spacing: 0) {
                Text(t).font(.system(size: 17, weight: .semibold)).foregroundColor(.labelPrimary)
                Text(s).font(.system(size: 12)).foregroundColor(.secondary)
            }
        }
    }

    @ViewBuilder private func navBtn(label: String?, action: (() -> Void)?, isLeading: Bool) -> some View {
        if let label, let action {
            Button(action: action) { Text(label).font(.system(size: 17)).foregroundColor(.backgroundAccent) }
                .frame(width: 44, height: 44)
        } else if let action {
            Button(action: action) {
                Image(systemName: isLeading ? "chevron.left" : "xmark")
                    .font(.system(size: 17, weight: .medium)).foregroundColor(.backgroundAccent)
            }.frame(width: 44, height: 44)
        } else {
            Color.clear.frame(width: 44, height: 44)
        }
    }
}

/// Standalone navbar button. Previously named DSNavigationBarButton.
public struct NavbarButton: View {
    public var isDisabled: Bool
    public var icon: Image
    public var action: () -> Void

    public init(isDisabled: Bool = false, icon: Image = Image(systemName: "ellipsis"), action: @escaping () -> Void) {
        self.isDisabled = isDisabled; self.icon = icon; self.action = action
    }

    public var body: some View {
        Button(action: { if !isDisabled { action() } }) {
            icon.font(.system(size: 17, weight: .medium))
                .foregroundColor(isDisabled ? .secondary : .backgroundAccent)
                .frame(width: 44, height: 44)
        }.disabled(isDisabled)
    }
}

// Typealiases for backwards compatibility
public typealias DSNavigationBar = Navbar
public typealias DSNavigationBarButton = NavbarButton
public typealias DSNavCenterType = NavbarCenterType

#if DEBUG
#Preview("Navbar") {
    VStack(spacing: 24) {
        Navbar(centerContent: .title("My App"), leadingAction: {}, trailingAction: {}, trailingLabel: "Done")
            .background(Color(white: 0.97)).clipShape(RoundedRectangle(cornerRadius: 12))
        Navbar(isSheet: true, centerContent: .titleAndSubtitle("Settings", "Account"), trailingAction: {}, trailingLabel: "Done")
            .background(Color(white: 0.97)).clipShape(RoundedRectangle(cornerRadius: 12))
    }.padding(24).background(Color(white: 0.93))
}
#endif
