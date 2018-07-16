//
//  Spherical.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 26/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Spherical {
    var name:    String
    var radius:  Double // Rho, r
    var angle:   Double // Theta
    var azimuth: Double // Phi
    
    init?(vector: Vector) {
        if (vector.degree != 3) {return nil}
        let (x,y,z)  = (vector.values[0], vector.values[1], vector.values[2])
        self.name    = vector.name
        self.radius  = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
        self.angle   = atan(sqrt(pow(x, 2) + pow(y, 2))/z)
        self.azimuth = atan(y/x)
    }
    
    //init(cylindrical: Cylindrical) {
    //    let (
    //}
    
    init(radius: Double, angle: Double, azimuth: Double) {
        self.name    = ""
        self.radius  = radius
        self.angle   = angle
        self.azimuth = azimuth
    }
    
    init(name: String, radius: Double, angle: Double, azimuth: Double) {
        self.name    = name
        self.radius  = radius
        self.angle   = angle
        self.azimuth = azimuth
    }
}
