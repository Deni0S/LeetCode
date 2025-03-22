import SwiftUI

@inlinable
func Localized(
    _ key: String,
    comment: String = ""
) -> String {
    NSLocalizedString(key, comment: comment)
}
