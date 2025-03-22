import SwiftUI

struct CodeHighlightView: View {
    let code: String

    private let fontSize: CGFloat = 14

    private var baseFont: Font {
        .system(size: fontSize, design: .monospaced)
    }

    private var italicFont: Font {
        .system(size: fontSize, design: .monospaced).italic()
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(highlightedCode)
                .font(baseFont)
                .textSelection(.enabled)
                .padding(12)
        }
        .background(Color.secondaryBackground)
        .cornerRadius(8)
    }

    // MARK: - Подсветка
    private var highlightedCode: AttributedString {
        var result = AttributedString(code)
        result.foregroundColor = .xcodePlain

        var occupied: [Range<String.Index>] = []

        // Порядок важен: комментарии и строки должны идти первыми,
        // чтобы их содержимое не перекрашивалось другими правилами.

        // 1. Комментарии (// ...)
        apply(#"//[^\n]*"#, color: .xcodeComment, italic: true,
              in: &result, occupied: &occupied)

        // 2. Строки "..." с учётом экранирования
        apply(#""(?:\\.|[^"\\])*""#, color: .xcodeString,
              in: &result, occupied: &occupied)

        // 3. Атрибуты (@State, @Binding, @Published и т.п.)
        apply(#"@[A-Za-z_][A-Za-z0-9_]*"#, color: .xcodeAttribute,
              in: &result, occupied: &occupied)

        // 4. Числа
        apply(#"\b\d+(\.\d+)?\b"#, color: .xcodeNumber,
              in: &result, occupied: &occupied)

        // 5. Ключевые слова Swift
        let keywords = [
            "func", "let", "var", "if", "else", "for", "in", "return",
            "class", "struct", "enum", "guard", "while", "switch", "case",
            "break", "continue", "import", "self", "Self", "nil", "true", "false",
            "init", "deinit", "extension", "protocol", "public", "private",
            "fileprivate", "internal", "open", "static", "final", "mutating",
            "nonmutating", "where", "as", "is", "throw", "throws", "rethrows",
            "do", "try", "catch", "defer", "repeat", "default", "typealias",
            "associatedtype", "subscript", "some", "any", "inout", "lazy",
            "weak", "unowned", "convenience", "required", "override",
            "indirect", "dynamic", "optional"
        ]
        let keywordPattern = "\\b(" + keywords.joined(separator: "|") + ")\\b"
        apply(keywordPattern, color: .xcodeKeyword,
              in: &result, occupied: &occupied)

        // 6. Типы: слова с большой буквы (Int, String, Solution, Dictionary)
        apply(#"\b[A-Z][A-Za-z0-9_]*\b"#, color: .xcodeType,
              in: &result, occupied: &occupied)

        // 7. Имена функций/методов: идентификатор перед "("
        apply(#"\b[a-z_][A-Za-z0-9_]*(?=\()"#, color: .xcodeFunction,
              in: &result, occupied: &occupied)

        return result
    }

    private func apply(
        _ pattern: String,
        color: Color,
        italic: Bool = false,
        in result: inout AttributedString,
        occupied: inout [Range<String.Index>]
    ) {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
        let ns = code as NSString
        let fullRange = NSRange(location: 0, length: ns.length)
        let matches = regex.matches(in: code, range: fullRange)

        for match in matches {
            guard let range = Range(match.range, in: code) else { continue }

            // Пропускаем пересечения с уже подсвеченными диапазонами
            if occupied.contains(where: { $0.overlaps(range) }) { continue }

            if let lower = AttributedString.Index(range.lowerBound, within: result),
               let upper = AttributedString.Index(range.upperBound, within: result) {
                result[lower..<upper].foregroundColor = color
                if italic {
                    result[lower..<upper].font = italicFont
                }
            }
            occupied.append(range)
        }
    }
}
