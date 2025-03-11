class MockApiService : ApiService {
    func getData() async throws -> [String] {
        return .init(["Hello", "World"])
    }    
}
