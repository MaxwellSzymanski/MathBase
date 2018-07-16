//
//  Vector.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 22/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Vector {
    var values: [Double]
    var name:   String
    var degree: Int {return self.values.count}
    
    /// Creates a vector with a given name, and an array of values.
    ///
    /// - Parameters:
    ///   - name: The name of the vector.
    ///   - values: The values of the vector.
    init (_ name: String, _ values:[Double]) {
        self.name   = name
        self.values = values
    }
    
    /// Creates a vector with the given array of values.
    ///
    /// - Parameter values: The values of the vector.
    init (_ values:[Double]) {
        self.name   = ""
        self.values = values
    }
    
    //init (polar: Polar) {
    //    self.values = [polar.radius * cos(polar.angle), polar.radius * sin(polar.angle)]
    //}


}
