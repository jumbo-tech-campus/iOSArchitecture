struct RecipesRawResponse: Codable, RawResponseType {
    var pagingData: PagingData
    let data: [RecipeData]

    enum CodingKeys: String, CodingKey {
        case pagingData = "pagingData"
        case data = "data"
    }
}
