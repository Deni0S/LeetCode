import SwiftUI

final class TaskStoreManager: ObservableObject {
    @Published var tasks: [LeetCodeTask] = []
    private let saveKey = "leetcode_tasks"

    init() {
        load()
    }

    public func save() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    public func add(_ task: LeetCodeTask) {
        tasks.append(task)
        save()
    }

    public func update(_ task: LeetCodeTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            save()
        }
    }

    public func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        save()
    }
}

private extension TaskStoreManager {

    func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            tasks = TaskData().tasks
            return
        }

        if let decoded = try? JSONDecoder().decode([LeetCodeTask].self, from: data) {
            tasks = decoded
        }
    }
}
