typealias RecipeID = String

struct RecipeData: Codable {
    let id, name: String
    let image: String
    let totalTime, numberOfIngredients: Int
    let tags: [String]
}
