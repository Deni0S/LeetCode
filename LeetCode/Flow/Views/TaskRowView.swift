import SwiftUI

struct TaskRowView: View {

    let task: LeetCodeTask

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(task.number)\(Localized("."))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(task.title).font(.headline)
                Spacer()
                Text(Localized(task.difficulty.rawValue))
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(color(for: task.difficulty))
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            HStack(spacing: 6) {
                Image(systemName: "clock")
                Text(task.time)
                Image(systemName: "memorychip")
                    .padding(.leading, 10)
                Text(task.memory)
            }
            .font(.caption).foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
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
    TaskRowView(
        task: TaskData().tasks.first!)
}
