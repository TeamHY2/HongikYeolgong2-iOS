//
//  UserRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import Combine

protocol UserRepositoryType {
    func createUser(_ user: User) -> AnyPublisher<User, Never>
    func fetchUser(with email: String) -> AnyPublisher<User, Error>
}

final class UserRepository: UserRepositoryType {
    
    func createUser(_ user: User) -> AnyPublisher<User, Never> {
        return Future<User, Never> { promise in
            Task {
                do {
                    let user = try await FirebaseService.shared.post(user, docId: user.email, to: .userCollection)
                    promise(.success(user))
                } catch {
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchUser(with email: String) -> AnyPublisher<User, Error> {
        let query = FirebaseService.shared.database
            .collection(FirebaseService.Collections.userCollection.rawValue)
            .whereField("email", isEqualTo: email)
        
        return Future<User, Error> { promise in
            Task {
                do {
                    let user = try await FirebaseService.shared.getOne(of: User.self , with: query)    
                    promise(.success(user))
                } catch let error {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
