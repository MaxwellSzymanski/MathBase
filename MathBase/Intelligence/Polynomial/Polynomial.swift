//
//  Polynomial.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 09/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Polynomial: CustomStringConvertible {
    var name: String
    var values: [Fraction]
    var degree: Int {
        return values.count - 1
    }
    //Variable in _ needs to be added
    public var description: String {
        // Add title if present
        var string: String = ""
        if name != "" { string = name + "(x): "}
        // Add first value if not zero
        if values[0] == Fraction.zero && values.count == 1 {return (string + "0")}
        string += (values[0] == Fraction.zero) ? "" : values[0].description
        if degree > 1 && values[0] != Fraction.zero {string += " + "}
        // Add second value if not zero
        if values.count > 1 {
            if values[0] != Fraction.zero && values[1] != Fraction.zero {string += " + "}
            if values[1] == Fraction.one {string += "x"}
            else if values[1] != Fraction.zero {string += String(values[1].description) + "x"}
        }
        // Add other values
        if values.count > 2 {
            for i in 2..<values.count {
                if values[i-1] != Fraction.zero {string += " + "}
                if values[i] != Fraction.zero {
                    if values[i] == Fraction.one {string += "x^\(i)"}
                    else {string += String(values[i].description) + "x^\(i)"}
                }
            }
        }
        return string
    }
    
    public init(_ name: String, _ values: [Fraction]) {
        self.name   = name
        self.values = values
    }
    
    public init(_ values: [Fraction]) {
        self.name   = ""
        self.values = values
    }
    
    public init(_ name: String, _ values: [Int]) {
        self.name   = name
        self.values = values.map{Fraction(from: $0)}
    }
    
    public init(_ values: [Int]) {
        self.name   = ""
        self.values = values.map{Fraction(from: $0)}
    }
    
    public init(fromZeros zeros: [Int]) {
        var poly = Polynomial([1])
        for i in zeros {
            poly = PolynomialOperation.multiply(poly, with: Polynomial([1, -i]))
        }
        self.values = poly.values
        self.name   = ""
    }
    
    /// Returns the values of the polynomial of the given length, or the original length, whichever one is bigger.
    ///
    /// - Parameter degree: The length of which the array should be.
    /// - Returns: The array of values of the polynomial of the given length, or the original length, whichever one is bigger.
    func values(ofLength degree: Int) -> [Fraction] {
        if degree <= self.degree {return self.values}
        var newValue = self.values
        newValue.append(contentsOf: Array<Fraction>(repeating: Fraction.zero, count: degree - self.degree))
        return newValue
    }
    
    /// Returns the value of the polynomial in a given point (evaluates f(x)).
    ///
    /// - Parameter x: The point for which f(x) should be calculated.
    /// - Returns: The result of f(x) in a given point x.
    func value(at x:Fraction) -> Fraction {
        var result: Fraction = Fraction.zero
        for i in 0 ..< degree {
            result = result + (values[i] * (x^i))
        }
        return result
    }
    
    /// Returns the value of the polynomial in a given point (evaluates f(x)).
    ///
    /// - Parameter x: The point for which f(x) should be calculated.
    /// - Returns: The result of f(x) in a given point x.
    func value(at x:Int) -> Fraction {
        var result: Fraction = Fraction.zero
        for i in 0 ..< degree {
            result = result + values[i] * Int(pow(Double(x),Double(i)))
        }
        return result
    }
}


extension Polynomial {
    public static func *(left: Polynomial, right: Polynomial) -> Polynomial {
        var values = left.values
        for i in 0 ..< values.count {
            values[i] = values[i] * right
        }
        return Polynomial(left.name, values)
    }
    
    public static func *(left: Polynomial, right: Fraction) -> Polynomial {
        var values = left.values
        for i in 0 ..< values.count {
            values[i] = values[i] * right
        }
        return Polynomial(left.name, values)
    }
    
    public static func *(left: Fraction, right: Polynomial) -> Polynomial {
        var values = right.values
        for i in 0 ..< values.count {
            values[i] = values[i] * left
        }
        return Polynomial(right.name, values)
    }
    
    public static func *(left: Polynomial, right: Double) -> Polynomial {
        var values = left.values
        for i in 0 ..< values.count {
            values[i] = values[i] * right
        }
        return Polynomial(left.name, values)
    }
    
    public static func *(left: Double, right: Polynomial) -> Polynomial {
        var values = right.values
        for i in 0 ..< values.count {
            values[i] = values[i] * left
        }
        return Polynomial(right.name, values)
    }
    
    public static func *(left: Polynomial, right: Int) -> Polynomial {
        return left * Double(right)
    }
    
    public static func *(left: Int, right: Polynomial) -> Polynomial {
        return Double(left) * right
    }
}

extension Polynomial {
    
    public static func /(left: Polynomial, right: Polynomial)  -> (quotient: Polynomial, remainder: Polynomial) {
        var values: [Fraction] = []
        let l: Int = left.degree - right.degree
        var intermediatePoly: Polynomial = left
        for i in 0 ... l {
            let highestPoly1: Fraction = intermediatePoly.values(ofLength:right.degree).reversed()[0]
            let highestPoly2: Fraction = right.values.reversed()[0]
            values.append(highestPoly1/highestPoly2)
            intermediatePoly = subtract(intermediatePoly, multiplyWithNumber(polynomial: right, with: values[i], ofDegree: l - i))
        }
        return (clean(Polynomial("Quotient", values.reversed())), Polynomial("Remainder", clean(intermediatePoly).values))
    }
    
    public static func /(left: Polynomial, right: Fraction) -> Polynomial {
        var values = left.values
        for i in 0 ..< values.count {
            values[i] = values[i] / right
        }
        return Polynomial(left.name, values)
    }
    
    public static func /(left: Polynomial, right: Double) -> Polynomial {
        var values = left.values
        for i in 0 ..< values.count {
            values[i] = values[i] / right
        }
        return Polynomial(left.name, values)
    }
    
    public static func /(left: Polynomial, right: Int) -> Polynomial {
        return left * Double(right)
    }
    
}

