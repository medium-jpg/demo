// MainTabbar.swift
// Renamed from DSTabBar.swift to match Figma component name "Main Tabbar"
// Figma node: 31:683
// https://www.figma.com/design/cJ8OmSmwIOX0kMV9bmVgic/Library?node-id=31-683

import SwiftUI

public struct TabbarItem: Identifiable {
    public let id = UUID()
    public let icon: Image
    public let selectedIcon: Image
    public let label: String
    public init(icon: Image, selectedIcon: Image? = nil, label: String) {
        self.icon = icon; self.selectedIcon = selectedIcon ?? icon; self.label = label
    }
}

/// Matches the Figma "Main Tabbar" component (node 31:683).
/// Previously named DSTabBar.
public struct MainTabbar: View {
    public var items: [TabbarItem]
    @Binding public var selectedIndex: Int
    public var showHomeIndicator: Bool

    public init(items: [TabbarItem], selectedIndex: Binding<Int>, showHomeIndicator: Bool = true) {
        self.items = items; self._selectedIndex = selectedIndex; self.showHomeIndicator = showHomeIndicator
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { i in
                    Button { selectedIndex = i } label: {
                        (i == selectedIndex ? items[i].selectedIcon : items[i].icon)
                            .font(.system(size: 22))
                            .foregroundColor(i == selectedIndex ? .backgroundAccent : .secondary)
                            .frame(width: 44, height: 29)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 49)
            .background(.regularMaterial)
            .overlay(Rectangle().fill(Color.secondary.opacity(0.2)).frame(height: 0.5), alignment: .top)

            if showHomeIndicator {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 3).fill(Color.primary.opacity(0.2)).frame(width: 134, height: 5)
                    Spacer()
                }
                .frame(height: 21).background(.regularMaterial)
            }
        }
        .frame(width: 393)
    }
}

// Typealiases for backwards compatibility
public typealias DSTabBar = MainTabbar
public typealias DSTabItem = TabbarItem

#if DEBUG
#Preview("Main Tabbar") {
    @Previewable @State var selected = 0
    VStack {
        Spacer()
        MainTabbar(
            items: [
                TabbarItem(icon: Image(systemName: "house"), selectedIcon: Image(systemName: "house.fill"), label: "Home"),
                TabbarItem(icon: Image(systemName: "magnifyingglass"), label: "Search"),
                TabbarItem(icon: Image(systemName: "bell"), selectedIcon: Image(systemName: "bell.fill"), label: "Notifications"),
                TabbarItem(icon: Image(systemName: "person"), selectedIcon: Image(systemName: "person.fill"), label: "Profile"),
            ],
            selectedIndex: $selected
        )
    }.ignoresSafeArea(edges: .bottom)
}
#endif
