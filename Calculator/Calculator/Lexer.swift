//
//  Lexer.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-17.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

public enum BinaryOperator: Character {
    case plus = "+"
    case minus = "-"
    case times = "*"
    case divide = "/"
    case mod = "%"
}

public enum Token: Equatable {
    case leftParen, rightParen
    case identifier(String)
    case number(Double)
    case `operator`(BinaryOperator)
    
    public static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.leftParen, .leftParen), (.rightParen, .rightParen):
            return true
        case let (.identifier(id1), .identifier(id2)):
            return id1 == id2
        case let (.number(n1), .number(n2)):
            return n1 == n2
        case let (.operator(op1), .operator(op2)):
            return op1 == op2
        default:
            return false
        }
    }
}

public final class Lexer {
    private let input: String
    private var index: String.Index
    
    public init(input: String) {
        self.input = input
        self.index = input.startIndex
    }
    
    private var current: Character? {
        return index < input.endIndex ? input[index] : nil
    }
    
    private func advanceIndex() {
        index = input.index(after: index)
    }
    
    private func readIdentifierOrNumber() -> String {
        var str = ""
        while let c = current, c.isAlphanumeric || c == "." {
            str.append(c)
            advanceIndex()
        }
        return str
    }
    
    private func advanceNextToken() -> Token? {
        while let character = current, character.isSpace {
            advanceIndex()
        }
        
        guard let character = current else {
            return nil
        }
        
        let singleTokenMapping: [Character : Token] = [
            "+" : .operator(.plus),
            "-" : .operator(.minus),
            "*" : .operator(.times),
            "/" : .operator(.divide),
            "%" : .operator(.mod),
            "(" : .leftParen,
            ")" : .rightParen,
        ]
        
        if let token = singleTokenMapping[character] {
            advanceIndex()
            return token
        }
        
        if character.isAlphanumeric {
            
            let value = readIdentifierOrNumber()
            
            if let double = Double(value) {
                return .number(double)
            }
            
            return .identifier(value)
        }
        
        return nil
    }
    
    public func lex() -> [Token] {
        var tokens = [Token]()
        while let token = advanceNextToken() {
            tokens.append(token)
        }
        return tokens
    }
    
}
