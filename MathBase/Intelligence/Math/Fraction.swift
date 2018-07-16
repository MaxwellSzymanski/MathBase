//
//  Fraction.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 04/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Fraction: CustomStringConvertible, Hashable {
    var numerator:   Int
    var denominator: Int
    static let zero = Fraction(from:0)
    static let one  = Fraction(from: 1)
    
    public var description: String {
        return self.simplify().denominator == 1 ? "\(self.simplify().numerator)" : "\\frac{\(self.numerator)}{\(self.denominator)}"
    }
    
    public var hashValue: Int {
        return (Double(self.numerator) / Double(self.denominator)).hashValue
    }
    
    init(numerator: Int, denominator: Int) {
        var newNumerator:   Int64
        var newDenominator: Int64
        if denominator < 0 {
            newNumerator   = Int64(-numerator)
            newDenominator = Int64(-denominator)
        }
        else {
            newNumerator   = Int64(numerator)
            newDenominator = Int64(denominator)
        }
        while Int64.abs(newNumerator) > 99999999 || Int64.abs(newDenominator) > 99999999 {
            newNumerator   /= 10
            newDenominator /= 10
            if newDenominator == 0 {newDenominator = 1}
        }
        self.numerator   = Int(newNumerator)
        self.denominator = Int(newDenominator)
    }
    
    init(_ numerator: Int, _ denominator: Int) {
        var newNumerator:   Int64
        var newDenominator: Int64
        if denominator < 0 {
            newNumerator   = Int64(-numerator)
            newDenominator = Int64(-denominator)
        }
        else {
            newNumerator   = Int64(numerator)
            newDenominator = Int64(denominator)
        }
        while Int64.abs(newNumerator) > 99999999 || Int64.abs(newDenominator) > 99999999 {
            newNumerator   /= 10
            newDenominator /= 10
            if newDenominator == 0 {newDenominator = 1}
        }
        self.numerator   = Int(newNumerator)
        self.denominator = Int(newDenominator)
    }
    
    init(_ numerator: Int64, _ denominator: Int64) {
        var newNumerator:   Int64
        var newDenominator: Int64
        if denominator < 0 {
            newNumerator   = Int64(-numerator)
            newDenominator = Int64(-denominator)
        }
        else {
            newNumerator   = Int64(numerator)
            newDenominator = Int64(denominator)
        }
        while Int64.abs(newNumerator) > 99999999 || Int64.abs(newDenominator) > 99999999 {
            newNumerator   /= 10
            newDenominator /= 10
            if newDenominator == 0 {newDenominator = 1}
        }
        self.numerator   = Int(newNumerator)
        self.denominator = Int(newDenominator)
    }
    
    init(from double: Double) {
        let eps = 1.0E-10
        var x = double
        var a = x.rounded(.down)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)
        
        while x - a > eps * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = x.rounded(.down)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        var newNumerator:   Int64 = Int64(h)
        var newDenominator: Int64 = Int64(k)
        while Int64.abs(newNumerator) > 99999999 || Int64.abs(newDenominator) > 99999999 {
            newNumerator   /= 10
            newDenominator /= 10
            if newDenominator == 0 {newDenominator = 1}
        }
        self.numerator   = Int(newNumerator)
        self.denominator = Int(newDenominator)
    }
    
    init(from int: Int) {
        self.numerator   = int
        self.denominator = 1
    }

    
    public func doubleValue() -> Double {
        return Double(self.numerator) / Double(self.denominator)
    }

    public func inverse () -> Fraction {
        return Fraction(self.denominator, self.numerator)
    }
    
    public func simplify () -> Fraction {
        let gcd = Math.gcd(self.numerator, self.denominator)
        return Fraction(self.numerator / gcd,
                        self.denominator / gcd)
    }
    
    public func simplifySelf () {
        let gcd = Math.gcd(self.numerator, self.denominator)
        self.numerator   /= gcd
        self.denominator /= gcd
    }
    
    
}

extension Fraction {
    public static func +(left: Fraction, right: Fraction) -> Fraction {
        let lcm   = Math.lcm(left.denominator, right.denominator)
        return Fraction(left.numerator * (lcm/left.denominator) + right.numerator * (lcm/right.denominator), lcm).simplify()
    }
    
    public static func +(left: Int, right: Fraction) -> Fraction {
        return ((Fraction(from: left) + right).simplify())
    }
    
    public static func +(left: Fraction, right: Int) -> Fraction {
        return (left + Fraction(from: right)).simplify()
    }
}

extension Fraction {
    public static func -(left: Fraction, right: Fraction) -> Fraction {
        let lcm   = Math.lcm(left.denominator, right.denominator)
        return Fraction(left.numerator * (lcm/left.denominator) - right.numerator * (lcm/right.denominator), lcm).simplify()
    }
    
    public static func -(left: Int, right: Fraction) -> Fraction {
        return ((Fraction(from: left) - right).simplify())
    }
    
    public static func -(left: Fraction, right: Int) -> Fraction {
        return (left - Fraction(from: right)).simplify()
    }
}


extension Fraction {
    public static func *(left: Fraction, right: Fraction) -> Fraction {
        return Fraction(numerator:   left.numerator * right.numerator,
                        denominator: left.denominator * right.denominator)
    }
    
    public static func *(left: Fraction, right: Int) -> Fraction {
        return Fraction(numerator:   left.numerator * right,
                        denominator: left.denominator).simplify()
    }
    
    public static func *(left: Fraction, right: Double) -> Fraction {
        return (left * Fraction(from: right)).simplify()
    }
    
    public static func *(left: Int, right: Fraction) -> Fraction {
        return Fraction(numerator:   left * right.numerator,
                        denominator: right.denominator).simplify()
    }
    
    public static func *(left: Double, right: Fraction) -> Fraction {
        return (Fraction(from: left) * right).simplify()
    }
    
}

extension Fraction {
    public static func /(left: Fraction, right: Fraction) -> Fraction {
        return Fraction(numerator:   left.numerator   * right.denominator,
                        denominator: left.denominator * right.numerator).simplify()
    }
    
    public static func /(left: Fraction, right: Int) -> Fraction {
        return Fraction(numerator:   left.numerator,
                        denominator: left.denominator * right).simplify()
    }
    
    public static func /(left: Fraction, right: Double) -> Fraction {
        return (left * Fraction(from: right).inverse()).simplify()
    }
    
    public static func /(left: Int, right: Fraction) -> Fraction {
        return Fraction(numerator:   right.numerator,
                        denominator: left * right.denominator).simplify()
    }
    
    public static func /(left: Double, right: Fraction) -> Fraction {
        return (Fraction(from: left).inverse() * right).simplify()
    }
    
}

extension Fraction {
    public static func ^(left:Fraction, right: Int) -> Fraction {
        if right == 0 {return Fraction.one}
        var result = Fraction.one
        for _ in 1 ... right {
            result = result * left
        }
        return result.simplify()
    }
}

extension Fraction {
    public static func abs(_ frac: Fraction) -> Fraction {
        return frac.doubleValue() < 0 ? (frac * -1) : frac
    }
}


extension Fraction: Equatable {
    public static func ==(left: Fraction, right: Fraction) -> Bool {
        let frac1 = left.simplify()
        let frac2 = right.simplify()
        return ((frac1.numerator == frac2.numerator && frac1.denominator == frac2.denominator) ? true :  false)
    }
    
    public static func ==(left: Fraction, right: Int) -> Bool {
        let frac = left.simplify()
        return ((frac.numerator == right && frac.denominator == 1) ? true :  false)
    }
    
    public static func ==(left: Int, right: Fraction) -> Bool {
        let frac = right.simplify()
        return ((frac.numerator == left && frac.denominator == 1) ? true :  false)
    }
}

extension Fraction: Comparable {
    public static func <(left: Fraction, right: Fraction) -> Bool {
        return left.doubleValue() < right.doubleValue()
    }
    
    public static func <=(left: Fraction, right: Fraction) -> Bool {
        return left.doubleValue() <= right.doubleValue()
    }
    
    public static func >(left: Fraction, right: Fraction) -> Bool {
        return left.doubleValue() > right.doubleValue()
    }
    
    public static func >=(left: Fraction, right: Fraction) -> Bool {
        return left.doubleValue() >= right.doubleValue()
    }
}
