//
//  Polar.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 26/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Polar {
    var name:   String
    var radius: Double
    var angle:  Double
    
    init?(vector: Vector) {
        if (vector.degree != 2) {return nil}
        self.name   = vector.name
        self.radius = sqrt(pow(vector.values[0], 2) + pow(vector.values[1], 2))
        self.angle  = atan(vector.values[1]/vector.values[0])
    }
    
    init(name: String, radius: Double, angle: Double) {
        self.name   = name
        self.radius = radius
        self.angle  = angle
    }
    
    init(radius: Double, angle: Double) {
        self.name   = ""
        self.radius = radius
        self.angle  = angle
    }
}
