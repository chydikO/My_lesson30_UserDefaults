//
//  UserModel.swift
//  My_lesson30_UserDefaults
//
//  Created by Oleg Chudnovskij on 08.07.2020.
//  Copyright © 2020 OlegChudnovskiy. All rights reserved.
//

import Foundation

class UserModel: NSCoding {
    
    
    let firstName: String
    let lastName: String
    let age: UInt
    
    var description: String {
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
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func encode(with coder: NSCoder) {
        
    }
    
    
}

