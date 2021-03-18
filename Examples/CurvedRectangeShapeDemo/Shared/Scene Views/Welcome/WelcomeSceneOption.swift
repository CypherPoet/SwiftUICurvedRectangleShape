//
// WelcomeSceneOption.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/17/21.
// ✌️
//

import SwiftUI


enum WelcomeSceneOption: Hashable, CaseIterable {
    case shaping
    case clipping
    case layering
    case animating
}


extension WelcomeSceneOption {
    
    var titleForDisplay: String {
        switch self {
        case .shaping:
            return "Shaping"
        case .clipping:
            return "Clipping"
        case .layering:
            return "Layering"
        case .animating:
            return "Animating"
        }
    }
}
