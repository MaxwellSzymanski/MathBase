//
//  VectorOperation.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 22/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class VectorOperation {
    
    static func normalise(_ vector: Vector) -> Vector {
        let sum = vector.values.reduce(0, +)
        return Vector(vector.values.map{$0 / sum })
    }
    
    static func angleBetween(_ v1: Vector, v2: Vector) -> Double {
        return cosh(dotProduct(v1: normalise(v1), v2: normalise(v2))!)
    }
    
    /// Calculates the cross product of two vectors of length 3.
    ///
    /// - Parameters:
    ///   - v1: A vector of length 3.
    ///   - v2: A vector of length 3.
    /// - Returns: The cross product of the two given vectors.
    static func crossProduct(_ v1: Vector, v2: Vector) -> Vector? {
        if (v1.degree != 3 && v2.degree != 3) {return nil}
        else {
            let x1: Double = v1.values[2]*v2.values[3] - v1.values[3]*v2.values[2]
            let x2: Double = v1.values[3]*v2.values[1] - v1.values[1]*v2.values[3]
            let x3: Double = v1.values[1]*v2.values[2] - v1.values[2]*v2.values[1]
            return Vector([x1, x2, x3])
        }
    }

    
    /// Returns the dot product of two equal length vectors.
    ///
    /// - Parameters:
    ///   - v1: A vector of degree n.
    ///   - v2: A vector of degree n.
    /// - Returns: The dot product of the two given vectors.
    static func dotProduct(v1: Vector,v2: Vector) -> Double? {
        if (v1.degree != v2.degree) {return nil}
        else {
            var result: Double = 0.0
            for i in 0...v1.degree {
                result += v1.values[i] * v2.values[i]
            }
            return result
        }
    }
}
