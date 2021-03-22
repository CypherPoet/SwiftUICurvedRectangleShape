//
// CustomGradients.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/22/21.
// ✌️
//

import SwiftUI


enum CustomGradients {
    
    static let screenBackground1 = Gradient(
        stops: [
            Gradient.Stop(color: .Theme2.background1, location: 0.0),
            Gradient.Stop(color: .Theme2.secondaryAccent2, location: 1.0),
        ]
    )
}
