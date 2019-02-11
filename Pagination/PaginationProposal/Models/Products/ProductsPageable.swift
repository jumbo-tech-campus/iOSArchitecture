struct ProductsPageable: PageableType {

    init(from raw: RawResponseType) {
        guard let productsRaw = raw as? ProductsRawResponse else {
            return
        }

        self.pagingData = PagingData(totalCount: productsRaw.products.total,
                                     count: productsRaw.products.data.count,
                                     offset: productsRaw.products.offset)

        self.data = productsRaw.products.data
    }

    func getData<T>() -> T {
        return data as! T
    }

    var pagingData: PagingData = PagingData()
    var data: [ProductsDatum] = [ProductsDatum]()
}
