import SwiftUI

struct CodeBlockView: View {
    let codes: [String]
    var language: String

    @State private var isCopied = false

    var body: some View {
        ForEach(codes, id: \.self) { code in
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text(language)
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button {
                        copyToClipboard(text: code)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                                .font(.system(size: 14, weight: .regular))
                            Text(Localized(isCopied ? "Copied" : "Copy"))
                                .font(.system(size: 14))
                        }
                        .foregroundStyle(isCopied ? .green : .secondary)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .animation(.easeInOut(duration: 0.15), value: isCopied)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                Divider()
                    .background(Color.secondary.opacity(0.3))
                CodeHighlightView(code: code)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(
            Color(.secondarySystemBackground),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }

    private func copyToClipboard(text: String) {
        #if os(iOS)
        UIPasteboard.general.string = text
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        #endif

        isCopied = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isCopied = false
        }
    }
}

#Preview {
    CodeBlockView(
        codes: [],
        language: "Swift")
}
