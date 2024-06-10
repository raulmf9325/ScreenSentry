import SwiftUI

public struct AppTheme {
    public struct Colors {
        public static let accentUIColor = UIColor(#colorLiteral(red: 0.07450980392, green: 0.0862745098, blue: 0.1215686275, alpha: 1))
        public static let primaryTextUIColor = UIColor(#colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.9019607843, alpha: 1))
        public static let sectionViewUIColor = UIColor(#colorLiteral(red: 0.1098039216, green: 0.1215686275, blue: 0.1529411765, alpha: 1))
    }
}

public struct Images {
    public static let home = Image("home", bundle: .module)
}

public extension AppTheme.Colors {
    static var accentColor: Color { Color(uiColor: accentUIColor) }
    static var primaryTextColor: Color { Color(uiColor: primaryTextUIColor) }
    static var sectionViewColor: Color { Color(uiColor: sectionViewUIColor) }
}
