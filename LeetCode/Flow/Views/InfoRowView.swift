import SwiftUI

struct InfoRowView: View {

    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title).bold()
            Text(value)
        }
    }
}

#Preview {
    InfoRowView(
        title: "",
        value: "")
}
