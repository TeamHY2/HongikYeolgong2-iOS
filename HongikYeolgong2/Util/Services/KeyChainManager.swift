//
//  KeyChainManager.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import Foundation

struct KeyChainManager {
    
    /// KeyChainName을 enum으로 정의
    enum KeyChainName: String {
        case accessToken = "accessToken"
    }
    
    static let service = Bundle.main.bundleIdentifier ?? "com.teamHY2.HongikYeolgong2"
    
    /// 키체인에 값을 추가합니다.
    /// - Parameters:
    ///   - key: KeyChainName
    ///   - value: String
    static func addItem(key: KeyChainName, value: String) {
        
        let valueData = value.data(using: .utf8)!
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service,
                                kSecAttrAccount: key.rawValue,
                                  kSecValueData: valueData]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("add success")
        } else if status == errSecDuplicateItem {
            updateItem(key: key, value: value)
        } else {
            print("add failed")
        }
    }
    
    /// key에 해당하는 키체인 값을 가져옵니다.
    /// - Parameters:
    ///   - key: KeyChainName
    static func readItem(key: KeyChainName) -> String? {
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service,
                                kSecAttrAccount: key.rawValue,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            print("read failed")
            return nil
        }
        
        guard let existItem = item as? [String:Any],
              let data = existItem[kSecValueData as String] as? Data,
              let returnValue = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return returnValue
    }
    
    /// key에 해당하는 키값을 업데이트 합니다.
    /// - Parameters:
    ///   - key: KeyChainName
    ///   - value: String
    static func updateItem(key: KeyChainName, value: String) {
        
        let valueData = value.data(using: .utf8)!
        
        let previousQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: service,
                                        kSecAttrAccount: key.rawValue]
        
        let updateQuery: [CFString: Any] = [kSecValueData: valueData]
        
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
        
        if status == errSecSuccess {
            print("update complete")
        } else {
            print("not finished update")
        }
    }
    
    
    /// Key에 해당하는 키체인값을 삭제합니다.
    /// - Parameter key: KeyChainName
    static func deleteItem(key: KeyChainName) {
        
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: key.rawValue]
        
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess {
            print("remove key-value data complete")
        } else {
            print("remove key-value data failed")
        }
    }
}
