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
