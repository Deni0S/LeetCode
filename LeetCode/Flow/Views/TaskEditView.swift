import SwiftUI

struct TaskEditView: View {
    @ObservedObject var store: TaskStoreManager
    @Environment(\.dismiss) var dismiss
    var task: LeetCodeTask?

    @State private var number = ""
    @State private var title = ""
    @State private var difficulty: LeetCodeTask.Difficulty = .easy
    @State private var time = ""
    @State private var memory = ""
    @State private var link = ""
    @State private var code = ""
    @State private var alternatives: [AlternativeCode] = []

    var body: some View {
        NavigationView {
            Form {
                Section(Localized("Basic")) {
                    TextField(Localized("Number"), text: $number).keyboardType(.numberPad)
                    TextField(Localized("Title"), text: $title)
                    Picker(Localized("Complexity"), selection: $difficulty) {
                        ForEach(LeetCodeTask.Difficulty.allCases) { diff in
                            Text(diff.rawValue).tag(diff)
                        }
                    }
                }
                Section(Localized("Results")) {
                    TextField(Localized("Time"), text: $time)
                    TextField(Localized("Memory"), text: $memory)
                }
                Section(Localized("Link")) {
                    TextField(Localized("URL"), text: $link)
                        .keyboardType(.URL).autocapitalization(.none)
                }
                Section(Localized("Code")) {
                    TextEditor(text: $code)
                        .font(.system(.body, design: .monospaced))
                        .frame(minHeight: 120)
                }

                // Блок альтернативных реализаций
                Section {
                    ForEach($alternatives) { $alt in
                        TextEditor(text: $alt.code)
                            .font(.system(.body, design: .monospaced))
                            .frame(minHeight: 120)
                    }
                    .onDelete { indexSet in
                        alternatives.remove(atOffsets: indexSet)
                    }

                    Button {
                        alternatives.append(AlternativeCode(code: ""))
                    } label: {
                        Label(Localized("Add alternative"), systemImage: "plus")
                    }
                } header: {
                    Text(Localized("Alternative implementations"))
                }
            }
            .navigationTitle(Localized(task == nil ? "New task" : "Edit"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Localized("Cancel")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Localized("Save")) { save() }.disabled(title.isEmpty)
                }
            }
            .onAppear {
                if let task = task {
                    number = String(task.number)
                    title = task.title
                    difficulty = task.difficulty
                    time = task.time
                    memory = task.memory
                    link = task.link
                    code = task.code
                    // Преобразуем [String] в [AlternativeCode]
                    alternatives = task.alternative.map { AlternativeCode(code: $0) }
                    if alternatives.isEmpty {
                        alternatives = [AlternativeCode(code: "")]
                    }
                } else {
                    alternatives = [AlternativeCode(code: "")]
                }
            }
        }
    }

    private func save() {
        let alternativeStrings = alternatives.map { $0.code }

        let newTask = LeetCodeTask(
            id: task?.id ?? UUID(),
            number: Int(number) ?? 0,
            title: title,
            difficulty: difficulty,
            time: time,
            memory: memory,
            link: link,
            code: code,
            alternative: alternativeStrings
        )
        if task == nil {
            store.add(newTask)
        } else {
            store.update(newTask)
        }
        dismiss()
    }
}

#Preview {
    TaskEditView(
        store: TaskStoreManager(),
        task: TaskData().tasks.first)
}
