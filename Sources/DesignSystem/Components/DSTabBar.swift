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
                ForEach(items.indices, id: \.self) { i in
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
