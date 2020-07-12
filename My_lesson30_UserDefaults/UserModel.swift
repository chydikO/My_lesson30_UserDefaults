//
//  UserModel.swift
//  My_lesson30_UserDefaults
//
//  Created by Oleg Chudnovskij on 08.07.2020.
//  Copyright © 2020 OlegChudnovskiy. All rights reserved.
//

import Foundation

class UserModel: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    let firstName: String
    let lastName: String
    let age: UInt
    
    override var description: String {
        return "\(firstName) \(lastName), \(age)"
    }
    
    private enum Keys {
        static let firstNameKey = "firstNameKey"
        static let lastNameKey = "lastNameKey"
        static let ageKey = "ageKey"
    }
    
    //MARK: - init
    init(firstName: String, lastName: String, age: UInt) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    // save
    // Model -(encode)> Data -> Save to UserDefaults
    
    // load
    // load from UserDefaults -> Data -(init(coder)> Model
    required convenience init?(coder: NSCoder) {
        guard
            let firstName = coder.decodeObject(forKey: UserModel.Keys.firstNameKey) as? String,
            let lastName = coder.decodeObject(forKey: UserModel.Keys.lastNameKey) as? String,
            let age = coder.decodeObject(forKey: UserModel.Keys.ageKey) as? UInt
            else {
                return nil
        }
        self.init(firstName: firstName, lastName: lastName, age: age)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(firstName, forKey: UserModel.Keys.firstNameKey)
        coder.encode(lastName, forKey: UserModel.Keys.lastNameKey)
        coder.encode(age, forKey: UserModel.Keys.ageKey)

    }
    
    
}

