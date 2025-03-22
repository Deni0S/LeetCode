import SwiftUI
#if os(macOS)
import AppKit
#endif

extension Color {

    static var backgroundColor: Color {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(.secondarySystemBackground)
        #elseif os(macOS)
        return Color(nsColor: .controlBackgroundColor)
        #endif
    }

    static var secondaryBackground: Color {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(.secondarySystemBackground)
        #elseif os(macOS)
        return Color(nsColor: .controlBackgroundColor)
        #endif
    }
}

// MARK: - Xcode Colors

extension Color {

    static let xcodeKeyword: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.988, green: 0.373, blue: 0.639, alpha: 1) // #FC5FA3
                : UIColor(red: 0.678, green: 0.239, blue: 0.643, alpha: 1) // #AD3DA4
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.988, green: 0.373, blue: 0.639, alpha: 1) // #FC5FA3
                : NSColor(red: 0.678, green: 0.239, blue: 0.643, alpha: 1) // #AD3DA4
        })
        #endif
    }()

    static let xcodeType: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.365, green: 0.847, blue: 1.000, alpha: 1) // #5DD8FF
                : UIColor(red: 0.294, green: 0.129, blue: 0.690, alpha: 1) // #4B21B0
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.365, green: 0.847, blue: 1.000, alpha: 1) // #5DD8FF
                : NSColor(red: 0.294, green: 0.129, blue: 0.690, alpha: 1) // #4B21B0
        })
        #endif
    }()

    static let xcodeString: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.988, green: 0.416, blue: 0.365, alpha: 1) // #FC6A5D
                : UIColor(red: 0.820, green: 0.184, blue: 0.106, alpha: 1) // #D12F1B
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.988, green: 0.416, blue: 0.365, alpha: 1) // #FC6A5D
                : NSColor(red: 0.820, green: 0.184, blue: 0.106, alpha: 1) // #D12F1B
        })
        #endif
    }()

    static let xcodeNumber: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.816, green: 0.749, blue: 0.412, alpha: 1) // #D0BF69
                : UIColor(red: 0.153, green: 0.165, blue: 0.847, alpha: 1) // #272AD8
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.816, green: 0.749, blue: 0.412, alpha: 1) // #D0BF69
                : NSColor(red: 0.153, green: 0.165, blue: 0.847, alpha: 1) // #272AD8
        })
        #endif
    }()

    static let xcodeComment: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.424, green: 0.475, blue: 0.525, alpha: 1) // #6C7986
                : UIColor(red: 0.325, green: 0.396, blue: 0.475, alpha: 1) // #536579
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.424, green: 0.475, blue: 0.525, alpha: 1) // #6C7986
                : NSColor(red: 0.325, green: 0.396, blue: 0.475, alpha: 1) // #536579
        })
        #endif
    }()

    static let xcodeFunction: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.404, green: 0.718, blue: 0.643, alpha: 1) // #67B7A4
                : UIColor(red: 0.196, green: 0.427, blue: 0.455, alpha: 1) // #326D74
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.404, green: 0.718, blue: 0.643, alpha: 1) // #67B7A4
                : NSColor(red: 0.196, green: 0.427, blue: 0.455, alpha: 1) // #326D74
        })
        #endif
    }()

    static let xcodeAttribute: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.718, green: 0.616, blue: 0.965, alpha: 1) // #B79DF6
                : UIColor(red: 0.482, green: 0.310, blue: 0.627, alpha: 1) // #7B4FA0
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(red: 0.718, green: 0.616, blue: 0.965, alpha: 1) // #B79DF6
                : NSColor(red: 0.482, green: 0.310, blue: 0.627, alpha: 1) // #7B4FA0
        })
        #endif
    }()

    static let xcodePlain: Color = {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? .white : .black
        })
        #elseif os(macOS)
        return Color(NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? .white : .black
        })
        #endif
    }()
}
