import Foundation
struct Welcome: Codable {
    let foods: Foods
}

// MARK: - Foods
struct Foods: Codable {
    let food: [Food]
}

// MARK: - Food
struct Food: Codable {
    let food_Name: String
}
