import SwiftUI

enum SectionViewType {
    case code(_ texts: [String], language: String = "Swift")
    case text(_ value: String)
}

struct SectionView: View {
    let title: String
    let type: SectionViewType

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline)
            switch type {
            case let .code(value, language):
                CodeBlockView(codes: value, language: language)
            case let .text(value):
                Text(value)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.backgroundColor)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    SectionView(
        title: "",
        type: .text(""))
}
