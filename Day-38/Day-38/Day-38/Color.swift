//
//  Color.swift
//  Day-38
//
//  Created by Ranjit on 09/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI
import UIKit

let systemColor = Color.red
let color = Color(red: 0.3, green: 0.5, blue: 1)

extension Color {

    var hexRepresentation: String? {
        let children = Mirror(reflecting: color).children
        let _provider = children.filter { $0.label == "provider" }.first
        guard let provider = _provider?.value else {
            return nil
        }
        let providerChildren = Mirror(reflecting: provider).children
        let _base = providerChildren.filter { $0.label == "base" }.first
        guard let base = _base?.value else {
            return nil
        }
        var baseValue: String = ""
        dump(base, to: &baseValue)
        guard let firstLine = baseValue.split(separator: "\n").first,
              let hexString = firstLine.split(separator: " ")[1] as Substring? else {
            return nil
        }
        return hexString.trimmingCharacters(in: .newlines)
    }

}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
