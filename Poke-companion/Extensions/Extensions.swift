//
//  Extensions.swift
//  Poke-companion
//
//  Created by Tsenguun on 20/10/22.
//

import Foundation
import SwiftUI

// MARK: Cache images from api
extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}

// MARK: Screen sizes
extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

// MARK: Capitalize Pokemon names etc...
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// MARK: Custom Rounded Corners
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
// MARK: End

// MARK: Converting Pokemon Stats
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}


// MARK: Cache pokemnos list
extension UserDefaults {
    func get(forKey defaultName: String) -> [Pokemon]? {
        guard let data = data(forKey: defaultName) else { return nil }
        do {
            return try JSONDecoder().decode([Pokemon].self, from: data)
        } catch { print(error); return nil }
    }

    func set(_ value: [Pokemon], forKey defaultName: String) {
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
}

// MARK: random color generator
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 0.4)
    }
}
