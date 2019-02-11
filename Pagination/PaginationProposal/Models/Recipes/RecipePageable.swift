struct RecipesPageable: PageableType {

    init(from raw: RawResponseType) {
        guard let recipesRaw = raw as? RecipesRawResponse else {
            return
        }
        self.pagingData = recipesRaw.pagingData
        self.data = recipesRaw.data
    }

    func getData<T>() -> T {
        return data as! T
    }

    var pagingData: PagingData = PagingData()
    var data: [RecipeData] = [RecipeData]()
}
