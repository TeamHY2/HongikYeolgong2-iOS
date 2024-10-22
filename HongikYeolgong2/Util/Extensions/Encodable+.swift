//
//  Encodable+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/15/24.
//

import Foundation

extension Encodable {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            print("Failed to encode user: \(error.localizedDescription)")
            return nil
        }
    }
}

extension Dictionary {
    func toData() -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)            
            return data
        } catch {
            return nil
        }
    }
}
