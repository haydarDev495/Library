//
//  UserDefaultsManager.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import Foundation

class UserDefaultsManager {
    
    private let userDefaultsManager = UserDefaults()
    static let shared = UserDefaultsManager()
    
    enum Data: String {
        case onboarding
    }
    
    //MARK: - Funcs
    func getValue(data: Data) -> Bool {
        return userDefaultsManager.bool(forKey: data.rawValue)
    }
    
    func saveValue(value: Bool, data: Data) {
        userDefaultsManager.setValue(value, forKey: data.rawValue)
    }
}
