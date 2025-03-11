class RealApiService : ApiService {
    func getData() async throws -> [String] {
        try await Task.sleep(nanoseconds: 1000000)
        return .init(["Hello", "World"])
    }    
}
