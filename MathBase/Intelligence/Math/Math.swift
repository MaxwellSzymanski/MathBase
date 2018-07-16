//
//  Math.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 05/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

class Math {
    public static func gcd(_ pa: Int, _ pb: Int) -> Int {
        let a = abs(pa)
        let b = abs(pb)
        let r = a % b
        if r != 0 {
            return gcd(b, r)
        } else {
            return b
        }
    }
    
    public static func lcm(_ a: Int, _ b: Int) -> Int {
        return (a * b) / gcd(a, b)
    }
}


extension Int64 {
    public static func abs(_ int: Int64) -> Int64 {
        return int < 0 ? (-1 * int) : int
    }
}
