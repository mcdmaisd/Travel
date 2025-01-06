//
//  UserDefaultsManager.swift
//  Travel
//
//  Created by ilim on 2025-01-06.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefault = UserDefaults.standard
    private let encoder: JSONEncoder = JSONEncoder()
    private let decoder: JSONDecoder = JSONDecoder()
    private let key = TravelConstants.arrayUserDefaultsKey

    private var savedList: [[ShoppingItem]] = [[], []]

    private init() { }
    
    func save(list: [[ShoppingItem]]) {
        do {
            let encodedData = try encoder.encode(list)
            userDefault.set(encodedData, forKey: key)
        } catch {
            print("Failed to save")
        }
    }
    
    func read() -> [[ShoppingItem]] {
        if let savedData = userDefault.object(forKey: key) as? Data {
            do{
                savedList = try decoder.decode([[ShoppingItem]].self, from: savedData)
                return savedList
            } catch {
                print("Failed to read")
            }
        }
        
        return savedList
    }
}
