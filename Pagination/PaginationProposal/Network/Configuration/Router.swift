import JNetworkingKit

struct Router {
    private struct BasePath {
        static let recipes = "secret/recipes"
        static let products = "products"
    }

    static func recipeList(searchTerm: String?, paging: (offset: Int, pageSize: Int)) -> RequestRoute {
        if let term = searchTerm {
            let escapedSearchTerm = term.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
            let search = "q=\(escapedSearchTerm)"
            return RequestRoute(path: "\(BasePath.recipes)?\(search)&\(stringFor(paging: paging))")
        }else{
            return RequestRoute(path: "\(BasePath.recipes)?\(stringFor(paging: paging))")
        }
    }

    static func productList(searchTerm: String?, paging: (offset: Int, pageSize: Int)) -> RequestRoute {
        if let term = searchTerm {
            let escapedSearchTerm = term.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
            let search = "q=\(escapedSearchTerm)"
            return RequestRoute(path: "\(BasePath.products)?\(search)&\(stringFor(paging: paging))")
        }else{
            return RequestRoute(path: "\(BasePath.products)?\(stringFor(paging: paging))")
        }
    }

    static func stringFor(paging: (offset: Int, pageSize: Int)) -> String {
        return "count=\(paging.pageSize)&offset=\(paging.offset)"
    }
}
