//
//  Parser.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-21.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

public indirect enum Expr {
    case number(Double)
    case binary(Expr, BinaryOperator, Expr)
}

enum ParseError: Error {
    case unexpectedToken(Token)
    case unexpectedEOF
}

public final class Parser {
    private let tokens: [Token]
    private var index = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    private var currentToken: Token? {
        return index < tokens.count ? tokens[index] : nil
    }
    
    private func consumeToken(n: Int = 1) {
        index += n
    }
    
    public func parse() throws -> Expr {
        return try parseExpr()
    }
    
    private func parseExpr() throws -> Expr {
        guard let token = currentToken else {
            throw ParseError.unexpectedEOF
        }
        
        var expr: Expr
        
        switch token {
        case .leftParen:
            consumeToken()
            expr = try parseExpr()
            try consume(.rightParen)
            
        case .number(let value):
            consumeToken()
            expr = .number(value)
        
        default:
            throw ParseError.unexpectedToken(token)
        }
        
        if case .operator(let op)? = currentToken {
            consumeToken()
            let rhs = try parseExpr()
            expr = .binary(expr, op, rhs)
        }
        
        return expr
    }
    
    private func consume(_ token: Token) throws {
        guard let tok = currentToken else {
            throw ParseError.unexpectedToken(token)
        }
        
        guard token == tok else {
            throw ParseError.unexpectedToken(token)
        }
        
        consumeToken()
    }
}

