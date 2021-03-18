//
// RectangleCorner.swift
// Shared
//
// Created by CypherPoet on 3/13/21.
// ✌️
//

import SwiftUI


public enum RectangleCorner: Hashable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}


extension RectangleCorner {
    
    public func opposite(alongAxis axis: Axis) -> Self {
        switch axis {
        case .horizontal:
            switch self {
            case .topLeading:
                return .bottomLeading
            case .topTrailing:
                return .bottomTrailing
            case .bottomLeading:
                return .topLeading
            case .bottomTrailing:
                return .bottomTrailing
            }
        case .vertical:
            switch self {
            case .topLeading:
                return .topTrailing
            case .topTrailing:
                return .topLeading
            case .bottomLeading:
                return .bottomTrailing
            case .bottomTrailing:
                return .bottomLeading
            }
        }
    }
}
