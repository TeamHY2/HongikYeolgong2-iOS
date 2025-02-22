//
//  Publisher.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/14/24.
//

import Combine


extension Publisher {
    /// 전역 데이터 전용 loadble
    /// - loadableSubject: loadable타입 바인딩용
    /// - receiveValueHandler: 통신 성공 시 전역 데이터 관리용 -> 없을 경우 Loadable만 관리 일반용으로 사용
    ///
    /// receiveValueHandler를 사용하는 경우에는 Loadable<Bool>로 success의 value값은
    func sinkToLoadble<LoadableType, HandlerType>(
        _ loadableSubject: LoadableSubject<LoadableType>,
        receiveValueHandler: ((HandlerType) -> Void)? = nil
    ) -> AnyCancellable where Output == HandlerType {
        // 로딩 상태로 전환
        loadableSubject.wrappedValue.setLoading()
        
        return sink { completion in
            switch completion {
            case .failure(let error):
                    loadableSubject.wrappedValue.setError(error: error as! NetworkError)
            case .finished:
                break
            }
        } receiveValue: { value in
            // receiveValueHandler가 있을 경우에는 loadable -> true로 반환
            if let handler = receiveValueHandler {
                // 상태 체크 용도, handler 사용할 경우
                handler(value)
                loadableSubject.wrappedValue.setSuccess(value: true as! LoadableType)
            } else {
                // 데이터 전달 용도, handler 사용 x
                loadableSubject.wrappedValue.setSuccess(value: value as! LoadableType)
            }
        }
    }
    
    /// 로딩 상태 외부 처리 용도
    func sinkToLoadbleWithoutLoding<LoadableType, HandlerType>(
        _ loadableSubject: LoadableSubject<LoadableType>,
        receiveValueHandler: ((HandlerType) -> Void)? = nil
    ) -> AnyCancellable where Output == HandlerType {
        return sink { completion in
            switch completion {
            case .failure(let error):
                    loadableSubject.wrappedValue.setError(error: error as! NetworkError)
            case .finished:
                break
            }
        } receiveValue: { value in
            // receiveValueHandler가 있을 경우에는 loadable -> true로 반환
            if let handler = receiveValueHandler {
                // 상태 체크 용도, handler 사용할 경우
                handler(value)
                loadableSubject.wrappedValue.setSuccess(value: true as! LoadableType)
            } else {
                // 데이터 전달 용도, handler 사용 x
                loadableSubject.wrappedValue.setSuccess(value: value as! LoadableType)
            }
        }
    }
}
