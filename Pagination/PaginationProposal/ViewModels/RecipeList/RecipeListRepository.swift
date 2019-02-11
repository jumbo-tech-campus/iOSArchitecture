import Foundation

class RecipeListRepository: PagingRepositoryType {

    var pagingData: PagingData = PagingData()

    init() {
    }

    func getRecipes(searchTerm: String?,
                    pageSize: Int = PagingData.defaultPageSize,
                    onSuccess: @escaping ([RecipeData]) -> Void,
                    onError: @escaping (Error) -> Void,
                    onDataEnd: @escaping () -> Void) {

        DispatchQueue.global(qos: .background).async {
            Gateway().recipeList(searchTerm: searchTerm,
                                 paging: self.nextPage(pageSize: pageSize),
                                 onSuccess: { [weak self] (recipeData) in
                                    self?.extractData(pageable: RecipesPageable(from: recipeData),
                                                      onSuccess: onSuccess,
                                                      onDataEnd: onDataEnd) },
                                 onError: onError)
        }
    }
}
