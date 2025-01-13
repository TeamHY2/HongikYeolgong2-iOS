//
//  APIManager.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/13/25.
//

import Foundation
import Alamofire

enum APIError: Error {
    case networkError(String)
    case parseError(String)
    case invalidUrl
    case invalidResponse
    case decodingError(String)
    case serverError(statusCode: Int)
}

final class APIManager {
    
    static let shared = APIManager()
    
    func performRequest<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async throws -> BaseResponse<T> {
        var result: Data = .init()
        do {
            let request = await self.requestData(endPoint: endPoint)
            result = try request.result.get()
        } catch {
            print("네트워크 에러" + (String(data: result, encoding: .utf8) ?? ""))
            throw APIError.networkError(error.localizedDescription)
        }
        
        do {
            let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
            return decodedData
        } catch {
            print("디코딩 에러" + (String(data: result, encoding: .utf8) ?? ""))
            throw APIError.parseError(error.localizedDescription)
        }
    }
    
    private func requestData(endPoint: EndPoint) async -> DataResponse<Data, AFError> {
        let response = await makeDataRequest(endPoint: endPoint).serializingData().response
        
        return response
    }
    
    private func makeDataRequest(endPoint: EndPoint) -> DataRequest {
        
        switch endPoint.task {
            
        case .requestPlain:
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                headers: endPoint.headers
            )
            
        case let .requestJSONEncodable(parameters):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoder: JSONParameterEncoder.default,
                headers: endPoint.headers
            )
            
        case let .requestCustomJSONEncodable(parameters, encoder):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoder: .json(encoder: encoder),
                headers: endPoint.headers                
            )
            
        case let .requestParameters(parameters, encoding):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoding: encoding,
                headers: endPoint.headers
            )
            
        case let .uploadImages(images, imageKeyName):
            return AF.upload(multipartFormData: { multipartFormData in
                for image in images {
                    if let image = image {
                        multipartFormData.append(image, withName: imageKeyName, fileName: "\(image).png", mimeType: "image/png")
                    }
                }
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers)
            
        case let .uploadImagesWithBody(images, body, imageKeyName):
            return AF.upload(multipartFormData: { multipartFormData in
                for image in images {
                    if let image = image {
                        multipartFormData.append(image, withName: imageKeyName, fileName: "\(image).jpeg", mimeType: "image/jpeg")
                    }
                }
                
                for (key, value) in body {
                    if let data = String(describing: value).data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers)
            
        case let .uploadImagesWithParameter(images, params, imageKeyName):
            return AF.upload(multipartFormData: { multipartFormData in
                for image in images {
                    if let image = image {
                        multipartFormData.append(image, withName: imageKeyName, fileName: "\(image).jpeg", mimeType: "image/jpeg")
                    }
                }
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)\(queryString(from: params))")!, method: endPoint.method, headers: endPoint.headers)
            
        case let .authRequestJSONEncodable(parameters):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoder: JSONParameterEncoder.default,
                headers: endPoint.headers
            )
            
        case .authRequestPlain:
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                headers: endPoint.headers
            )
            
        case let .requestParametersExAPI(parameters, encoding):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoding: encoding,
                headers: endPoint.headers
            )
        }
    }
    
    private func queryString(from parameters: [String: Any]) -> String {
        var components: [String] = []
        
        for (key, value) in parameters {
            if let arrayValue = value as? [Any] {
                for element in arrayValue {
                    components.append("\(key)=\(element)")
                }
            } else {
                components.append("\(key)=\(value)")
            }
        }
        print(components.isEmpty ? "" : "?" + components.joined(separator: "&"))
        return components.isEmpty ? "" : "?" + components.joined(separator: "&")
    }
}
