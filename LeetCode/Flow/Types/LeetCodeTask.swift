import SwiftUI

struct LeetCodeTask: Identifiable, Codable, Equatable {
    var id = UUID()
    var number: Int
    var title: String
    var difficulty: Difficulty
    var time: String
    var memory: String
    var link: String
    var code: String
    var alternative: [String]

    enum Difficulty: String, Codable, CaseIterable, Identifiable {
        var id: String {
            rawValue
        }

        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"

    }
}
