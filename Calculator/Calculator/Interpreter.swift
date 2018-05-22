//
//  Interpreter.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-21.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

public final class Interpreter {
    private let expr: Expr
    
    init(_ expr: Expr) {
        self.expr = expr
    }
    
    public func interpret() throws -> Double {
        return try emitExpr(expr)
    }
    
    public func emitExpr(_ expr: Expr) throws -> Double {
        switch expr {
            
        case .number(let value):
            return value
            
        case .binary(let lhs, let op, let rhs):
            let lhsVal = try emitExpr(lhs)
            let rhsVal = try emitExpr(rhs)
            
            switch op {
            case .plus:
                return lhsVal + rhsVal
            case .minus:
                return lhsVal - rhsVal
            case .divide:
                return lhsVal / rhsVal
            case .mod:
                return lhsVal.truncatingRemainder(dividingBy: rhsVal)
            case .times:
                return lhsVal * rhsVal
            }
        }
    }
}
