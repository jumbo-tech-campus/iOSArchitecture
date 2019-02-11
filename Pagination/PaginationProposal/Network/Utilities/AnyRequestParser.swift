import JNetworkingKit

final class AnyRequestParser<ResultType: Codable>: RequestParserType {
    func parse(response: Response) throws -> ResultType {
        guard let data = response.data else {
            throw RequestParserError.noData
        }

        return try JSONDecoder().decode(ResultType.self, from: data)
    }
}
