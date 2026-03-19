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
