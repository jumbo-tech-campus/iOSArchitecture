struct PagingData: Codable {
    static public let defaultPageSize = 10
    
    let totalCount, count, offset: Int

    init() {
        totalCount = 0
        count = 0
        offset = 0
    }
    
    init(totalCount: Int, count: Int, offset: Int) {
        self.totalCount = totalCount
        self.count = count
        self.offset = offset
    }
}
