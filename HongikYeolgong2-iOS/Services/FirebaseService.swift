//
//  FirebaseService.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

enum FIrebaseError: Error {
    case documentNotFount
}

protocol FirebaseIdentifiable: Hashable, Codable {
    var id: String { get set }
}

final class FirebaseService {
    
    static let shared = FirebaseService()
    let database = Firestore.firestore()
    
    private init() {}
    
    enum Collections: String {
        case userCollection = "User"
        case studyDayCollection = "StudyDay"
    }
}

// MARK: - GET
extension FirebaseService {    
    
    func getOne<T: Decodable>(of type: T.Type, with query: Query) async throws -> T {
           do {
               
               let querySnapshot = try await query.getDocuments()
               if let document = querySnapshot.documents.first {
               
                   let data = try document.data(as: T.self)
                   return data
               } else {
                   print("Warning: \(#function) document not found")
                   throw FIrebaseError.documentNotFount
               }
           } catch let error {
               print("Error: \(#function) couldn't access snapshot, \(error)")
               throw error
           }
       }
    
    func getMany<T: Decodable>(of type: T.Type,with query: Query) async throws -> [T] {
        do {
            var response: [T] = []
            let querySnapshot = try await query.getDocuments()
            
            for document in querySnapshot.documents {
                do {
                    
                    let data = try document.data(as: T.self)
                    response.append(data)
                } catch let error {
                    print("Error: \(#function) document(s) not decoded from data, \(error)")
                    throw error
                }
            }
            
            return response
        } catch let error {
            print("Error: couldn't access snapshot, \(error)")
            throw error
        }
    }
}

// MARK: - POST
extension FirebaseService {
    
    @discardableResult
    func post<T: FirebaseIdentifiable>(_ value: T, with ref: CollectionReference) async throws -> T {
        let valueToWrite: T = value
        do {
            try ref.addDocument(from: valueToWrite)
            return valueToWrite
        } catch let error {            
            throw error
        }
    }
    @discardableResult
    func post<T: FirebaseIdentifiable>(_ value: T, to collection: Collections) async throws -> T {
        
        let ref = database.collection(collection.rawValue).document()
        var valueToWrite: T = value
        valueToWrite.id = ref.documentID
        do {
            
            try ref.setData(from: valueToWrite)
            return valueToWrite
        } catch let error {
            print("Error: \(#function) in collection: \(collection), \(error)")
            throw error
        }
    }
    
    @discardableResult
    func post<T: FirebaseIdentifiable>(_ value: T, docId: String, to collection: Collections) async throws -> T {
        
        let ref = database.collection(collection.rawValue).document(docId)
        let valueToWrite: T = value
        
        do {
        
            try ref.setData(from: valueToWrite)
            return valueToWrite
        } catch let error {
            print("Error: \(#function) in collection: \(collection), \(error)")
            throw error
        }
    }

}

// MARK: - DELETE
extension FirebaseService {
    func delete<T: FirebaseIdentifiable>(_ value: T, in collection: String) async throws {
        let ref = database.collection(collection).document(value.id)
        do {
            // 1.
            try await ref.delete()
        } catch let error {
            print("Error: \(#function) in \(collection) for id: \(value.id), \(error)")
            throw error
        }
    }
}
