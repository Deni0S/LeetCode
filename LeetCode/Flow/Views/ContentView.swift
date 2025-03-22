import SwiftUI

struct ContentView: View {

    @StateObject private var store = TaskStoreManager()
    @State private var showingAdd = false
    @State private var taskToEdit: LeetCodeTask?

    var body: some View {
        NavigationView {
            List {
                ForEach(store.tasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskRowView(task: task)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            if let index = store.tasks.firstIndex(where: { $0.id == task.id }) {
                                store.delete(at: IndexSet(integer: index))
                            }
                        } label: {
                            Label(Localized("Remove"), systemImage: "trash")
                        }
                        Button {
                            taskToEdit = task
                        } label: {
                            Label(Localized("Сhange"), systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle(Localized("LeetCode problems"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showingAdd = true } label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showingAdd) {
                TaskEditView(store: store, task: nil)
            }
            .sheet(item: $taskToEdit) { task in
                TaskEditView(store: store, task: task)
            }
        }
    }
}

#Preview {
    ContentView()
}
