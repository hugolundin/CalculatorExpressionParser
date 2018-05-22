//
//  Character+isAlphanumeric.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-17.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

extension Character {
    var isAlphanumeric: Bool {
        return isalnum(value) != 0 || self == "_"
    }
}
