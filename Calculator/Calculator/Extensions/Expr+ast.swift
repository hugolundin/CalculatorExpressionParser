//
//  Expr+ast.swift
//  Calculator
//
//  Created by Hugo Lundin on 2018-05-22.
//  Copyright © 2018 Hugo Lundin. All rights reserved.
//

import Foundation

// Inspired by https://github.com/hashemi/slox/blob/master/slox/AstPrinter.swift

extension Expr {
    private func parenthesize(_ name: String, _ expressions: [Expr]) -> String {
        return "(\(name) " + expressions.map { $0.ast }.joined(separator: " ") + ")"
    }
    
    var ast: String {
        switch self {
        case .number(let value):
            return String(value)
        case .binary(let left, let op, let right):
            return parenthesize(String(op.rawValue), [left, right])
        }
    }
}


