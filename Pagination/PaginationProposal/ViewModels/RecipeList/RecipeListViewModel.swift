import Foundation

class RecipeListViewModel {
    let repository: RecipeListRepository
    lazy private var recipes: [RecipeData] = [RecipeData]()
    
    init(repository: RecipeListRepository = RecipeListRepository()) {
        self.repository = repository
    }

    func loadRecipes(searchTerm: String? = nil,
                     pageSize: Int = PagingData.defaultPageSize,
                     onComplete: @escaping () -> Void,
                     onDataEnd: @escaping () -> Void) {
        self.repository.getRecipes(searchTerm: searchTerm,
                                   pageSize: pageSize,
            onSuccess:{ [weak self] (recipes) in
                self?.refreshRecipeData(newRecipes: recipes, onComplete: onComplete) },
            onError:{ (error) in
                print(error)
        }, onDataEnd: onDataEnd)
    }

    func refreshRecipeData(newRecipes: [RecipeData], onComplete: @escaping () -> Void) {
        recipes.append(contentsOf: newRecipes)
        onComplete()
    }

    func displayableRecipe(at index: Int) -> RecipeDataDisplayable {
        return RecipeDataDisplayable(from: recipes[index])
    }

    func dataLenght() -> Int {
        return recipes.count
    }
}


extension RecipeListViewModel {
    public func debugPrintRecipes() {
        recipes.sorted(by: { $0.name > $1.name }).forEach{ print($0.name) }
        print("Total: \(recipes.count)")
    }
}
