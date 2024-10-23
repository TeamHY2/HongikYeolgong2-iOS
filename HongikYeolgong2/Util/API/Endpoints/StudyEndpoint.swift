import Foundation

/// Study 관련 엔드포인트 정의
enum StudyEndpoint: EndpointProtocol {

    /// 모든 학습 기록 수 조회
    case countAll
    case duration
}

extension StudyEndpoint {
    var baseURL: URL? {
        URL(string: "\(baseUrl)/study")
    }
    
    var path: String {
        switch self {
        case .countAll:
            return "/count-all"
        case .duration:
            return "/duration"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .countAll:
            return .get
        case .duration:
            return .get
        }
    }
    
    var parameters: [URLQueryItem]? {
        
        return nil
    }
    
    var headers: [String: String]? {
        return ["accept": "application/json"]
    }
    
    var body: Data? {
        return nil
    }
}
