
import Foundation

enum CalendarEndpoint: EndpointProtocol {
    
    case getAllStudy
}


extension CalendarEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)")
    }
    var path: String {
        switch self {
        case .getAllStudy:
            "/study/count-all"
        default:
            "/study"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .getAllStudy:
                .get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
}
