protocol PagingRepositoryType {
    var pagingData: PagingData { get set }

    func nextPage(pageSize: Int) -> (offset: Int, pageSize: Int)
    func needsMoreData() -> Bool
    mutating func extractData<T>(pageable: PageableType,
                                         onSuccess: @escaping (T) -> Void,
                                         onDataEnd: @escaping () -> Void)
}

extension PagingRepositoryType {
    func needsMoreData() -> Bool {
        return (pagingData.offset == 0
            || pagingData.offset < pagingData.totalCount)
    }

    func nextPage(pageSize: Int) -> (offset: Int, pageSize: Int) {
        let offset = pagingData.offset + pagingData.count
        let pageSize = pagingData.offset == 0 ? pageSize : min(pageSize, pagingData.totalCount - pagingData.offset)
        return (offset: offset, pageSize: pageSize)
    }

    mutating func extractData<T>(pageable: PageableType, onSuccess: @escaping (T) -> Void, onDataEnd: @escaping () -> Void){
        pagingData = pageable.pagingData
        if (!needsMoreData()) {
            onDataEnd()
        }
        onSuccess(pageable.getData())
    }
}
