import JNetworkingKit

typealias RecipeListRequestParser = AnyRequestParser<RecipesRawResponse>

final class RecipeListRequestOperation: NSObject, RequestOperationType {
    typealias Result = RecipesRawResponse

    var executor = RequestExecutor()
    var parser = RecipeListRequestParser()
    var request: Request

    init(searchTerm: String?, paging: (offset: Int, pageSize: Int)) {
        let route = Router.recipeList(searchTerm: searchTerm, paging: paging)
        request = Request(route: route)
    }
}
