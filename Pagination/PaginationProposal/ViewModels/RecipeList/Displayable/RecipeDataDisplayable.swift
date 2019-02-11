struct RecipeDataDisplayable: Codable {
    let name: String

    init(from recipe: RecipeData) {
        self.name = recipe.name
    }
}
