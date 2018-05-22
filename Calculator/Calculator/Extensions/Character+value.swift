//
//  Character+value.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-17.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

extension Character {
    var value: Int32 {
        return Int32(String(self).unicodeScalars.first!.value)
    }
}
