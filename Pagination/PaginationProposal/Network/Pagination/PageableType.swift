protocol PageableType {
    var pagingData: PagingData { get set }
    func getData<T>() -> T
    init(from raw: RawResponseType)
}
