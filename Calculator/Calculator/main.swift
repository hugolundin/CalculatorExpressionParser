//
//  main.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-17.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

let tokens = Lexer(input: "2 % 5").lex()

do {
    let expr = try Parser(tokens: tokens).parse()
    let result = try Interpreter(expr).interpret()
    print(result)
} catch (let error) {
    print(error)
}


