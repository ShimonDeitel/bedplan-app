import SwiftUI

/// tilled-soil ochre on dark cedar brown
enum Theme {
    static let accent = Color(red: 0.5412, green: 0.4275, blue: 0.2314)
    static let accentSecondary = Color(red: 0.2314, green: 0.1804, blue: 0.0941)
    static let background = Color(red: 0.1020, green: 0.0824, blue: 0.0471)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
