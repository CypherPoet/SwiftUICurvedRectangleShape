//
// CGRect+Utils.swift
// Shared
//
// Created by CypherPoet on 3/14/21.
// ✌️
//

import SwiftUI


extension CGRect {
    
    public var topLeading: CGPoint {
        .init(x: minX, y: minY)
    }
    
    public var topTrailing: CGPoint {
        .init(x: maxX, y: minY)
    }
    
    public var bottomTrailing: CGPoint {
        .init(x: maxX, y: maxY)
    }
    
    public var bottomLeading: CGPoint {
        .init(x: minX, y: maxY)
    }
    
    public var center: CGPoint {
        .init(x: midX, y: midY)
    }
}
