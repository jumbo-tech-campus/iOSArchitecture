import Foundation

protocol RecipeListGateway {
    func recipeList(searchTerm: String?,
                    paging: (offset: Int, pageSize: Int),
                    onSuccess: @escaping (RecipesRawResponse) -> Void,
                    onError: @escaping (Error) -> Void)

}

extension Gateway: RecipeListGateway {
    func recipeList(searchTerm: String?,
                    paging: (offset: Int, pageSize: Int),
                    onSuccess: @escaping (RecipesRawResponse) -> Void,
                    onError: @escaping (Error) -> Void) {
        print("Requesting more: \(paging)")
        RecipeListRequestOperation(searchTerm: searchTerm, paging: paging).execute(onSuccess: onSuccess, onError: onError)
    }
}
