import SwiftUI

struct TaskDetailView: View {

    let task: LeetCodeTask

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("\(task.number)\(Localized("."))\(Localized(" "))\(task.title)")
                        .font(.title2)
                        .bold()
                    HStack {
                        Text(task.difficulty.rawValue)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(color(for: task.difficulty))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        Spacer()
                        if let url = URL(string: task.link) {
                            Link(Localized("LeetCode"), destination: url)
                                .foregroundColor(.blue)
                        }
                    }
                }
                Divider()
                InfoRowView(title: Localized("Time"), value: task.time)
                InfoRowView(title: Localized("Memory"), value: task.memory)
                Divider()
                SectionView(title: Localized("Code"), type: .code([task.code]))
                if !task.alternative.isEmpty {
                    SectionView(
                        title: Localized("Alternative implementations"),
                        type: .code(task.alternative)
                    )
                }
            }
            .padding()
        }
        .navigationTitle(task.title)
        #if os(iOS) || os(tvOS) || os(visionOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private func color(
        for difficulty: LeetCodeTask.Difficulty
    ) -> Color {
        switch difficulty {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}

#Preview {
    TaskDetailView(
        task: TaskData().tasks.first!)
}
