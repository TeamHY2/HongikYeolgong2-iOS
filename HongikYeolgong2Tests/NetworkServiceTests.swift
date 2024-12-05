//
//  NetworkServiceTests.swift
//  HongikYeolgong2Tests
//
//  Created by 최주원 on 11/24/24.
//

import XCTest
import Combine
@testable import HongikYeolgong2

final class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!
    
    override func setUp() {
        // KeyChainManager 세팅
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // NetworkService 테스트 토큰으로 적용
        sut = NetworkService(session: session, testToken: {
            Bundle.main.infoDictionary?["TestToken"] as? String
        })
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // RecordView 네트워킹 상태 테스트
    func testGetStudyTimeRealNetwork() async throws {
        // given
        // 1. 엔드포인트 설정
        let endpoint = WeeklyEndpoint.getStudyTime
        
        // when
        // 2. 네트워크 요청 수행
        do {
            var response: BaseResponse<StudyTimeResponseDTO> = try await sut.request(endpoint: endpoint)
            
            // then
            // 3. 연결 상태 확인
            XCTAssertEqual(response.code, 200, "응답 코드 200 확인")
        } catch let error as NetworkError {
            XCTFail("Network request failed with error: \(error)")
        }
    }
}
