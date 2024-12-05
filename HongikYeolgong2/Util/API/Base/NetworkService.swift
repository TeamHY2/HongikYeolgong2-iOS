
import Foundation

struct NetworkService: NetworkProtocol {
    let session: URLSessionProtocol
    let testToken: () -> String?
    
    static let shared: NetworkService = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return NetworkService(session: session)
    }()
    
    init(session: URLSessionProtocol, testToken: @escaping () -> String? = {nil}) {
        self.session = session
        self.testToken = testToken
    }
    
    func request<T: Decodable>(endpoint: EndpointProtocol) async throws -> T {
        guard let url = configUrl(endpoint: endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let request = configRequest(url: url, endpoint: endpoint)
        let (data, response) = try await session.data(for: request)
        if let responseString = String(data: data, encoding: .utf8) {
            print("📍 Response body: \(responseString)")
        }
        return try processResponse(data: data, response: response)
    }
    
    func plainRequest(endpoint: EndpointProtocol) async throws {
        guard let url = configUrl(endpoint: endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let request = configRequest(url: url, endpoint: endpoint)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}

extension NetworkService {
    private func configUrl(endpoint: EndpointProtocol) -> URL? {
        guard let url = endpoint.path.isEmpty ? endpoint.baseURL : endpoint.baseURL?.appendingPathComponent(endpoint.path) else {
            return nil
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = endpoint.parameters
        
        return components.url
    }
    
    private func configRequest(url: URL, endpoint: EndpointProtocol) -> URLRequest {
        var request = URLRequest(url, testToken: testToken())
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        return request
    }
    
    private func processResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
}
