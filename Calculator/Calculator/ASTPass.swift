//
//  ASTPass.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-23.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

protocol ASTPass: class {
    func transform(_ expr: Expr) -> Expr
}

extension Expr {
    func apply(_ passes: [ASTPass]) -> Expr {
        var result = self
        
        for pass in passes {
            result = pass.transform(result)
        }
        
        return result
    }
}

public final class PrecendencePass: ASTPass {
    func transform(_ expr: Expr) -> Expr {
        
        switch expr {
        case .binary(let left, let op, let right):
            switch left {
                
                
                
            case .binary(let leftLeft, let leftOP, let leftRight):
                switch right {
                case .binary(let rightLeft, let rightOP, let rightRight):
                    
                    print(op)
                    print(leftOP)
                    print(rightOP)
                    
                    return expr
                    
                case .number(let rightValue):
                    return expr
                }
                
            case .number(let leftValue):
                switch right {
                case .binary(let rightLeft, let rightOP, let rightRight):
                    
                    print(op)
                    print(rightOP)
                    
                    return .binary(rightRight, op, .binary(.number(leftValue), op, rightLeft))
                    
                case .number(let rightValue):
                    return expr
                }
            }
            
        case .number(_):
            return expr
        }
    }
}

public final class EmptyPass: ASTPass {
    func transform(_ expr: Expr) -> Expr {
        return expr
    }
}
