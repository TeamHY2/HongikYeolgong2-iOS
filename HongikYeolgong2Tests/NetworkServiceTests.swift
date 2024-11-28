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
    // 기기 테스트 경우 기본 토큰값 저장 용도
    let testToken = Bundle.main.infoDictionary?["TestToken"] as? String ?? ""

    override func setUp() {
        // KeyChainManager accessToken 세팅
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        sut = NetworkService(session: session)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetStudyTimeRealNetwork() async throws {
        // given
        // 1. 엔드포인트 설정
        let endpoint = WeeklyEndpoint.getStudyTime
        
        // when
        // 2. 네트워크 요청 수행
        do {
            let response: BaseResponse<StudyTimeResponseDTO> = try await sut.request(endpoint: endpoint)
            
            // then
            // 3. 연결 상태 확인
            XCTAssertEqual(response.code, 200, "응답 코드 200 확인")
        } catch let error as NetworkError {
            XCTFail("Network request failed with error: \(error)")
        }
    }
}