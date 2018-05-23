//
//  main.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-17.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

let tokens = Lexer(input: "2 * 3 + 4").lex()

do {
    let expr = try Parser(tokens: tokens).parse()
    let transformed = expr.apply([PrecendencePass()])
    let result = try Interpreter(transformed).interpret()
    print(result)
} catch (let error) {
    print(error)
}

do {
    print(try Parser(tokens: tokens).parse().ast)
} catch (let error) {
    print(error)
}


