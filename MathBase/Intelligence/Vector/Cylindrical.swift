//
//  Cillindrical.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 26/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Cylindrical {
    var name:    String
    var radius:  Double
    var angle:   Double
    var azimuth: Double
    
    init?(vector: Vector) {
        if (vector.degree != 3) {return nil}
        let (x,y,z)  = (vector.values[0], vector.values[1], vector.values[2])
        self.name    = vector.name
        self.radius  = sqrt(pow(x, 2) + pow(y, 2))
        self.angle   = atan(y/x)
        self.azimuth = z
    }
    
    init(spherical: Spherical) {
        let (r, theta, phi) = (spherical.radius, spherical.angle, spherical.azimuth)
        self.name    = spherical.name
        self.radius  = r * sin(theta)
        self.angle   = r * cos(theta)
        self.azimuth = phi
    }
    
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
