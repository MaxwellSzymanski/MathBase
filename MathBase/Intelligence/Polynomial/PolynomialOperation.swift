//
//  PolynomialExpression.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 15/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class PolynomialOperation {
    
    static public func clean(_ poly: Polynomial) -> Polynomial {
        var values        = poly.values
        var previousValue = Fraction.zero
        for i in (1 ..< values.endIndex).reversed() {
            let value = values[i]
            guard value == previousValue else {
                break
            }
            values.remove(at: i)
            previousValue = value
        }
        return Polynomial(poly.name, values)
    }
    
    static public func add(_ poly1: Polynomial, to poly2: Polynomial) -> Polynomial {
        let l = max(poly1.degree, poly2.degree)
        var newValue: [Fraction] = Array(repeating: Fraction.zero, count:l)
        for i in 0...l-1 {
            newValue[i] = poly1.values(ofLength: l)[i] + poly2.values(ofLength:l)[i]
        }
        return Polynomial("", newValue)
    }
    
    public static func add(_ poly: [Polynomial]) -> Polynomial {
        var polynomial: Polynomial = add(poly[0],to: poly[1])
        for i in 2..<poly.count {
            polynomial = add(polynomial, to: poly[i])
        }
        return clean(polynomial)
    }
    
    public static func subtract(_ poly1: Polynomial, _ poly2: Polynomial) -> Polynomial {
        return clean(add(poly1, to:Polynomial(poly2.values.map {$0 * -1.0})))
    }
    
    public static func multiplyWithNumber(polynomial poly: Polynomial, with number: Fraction, ofDegree degree: Int) -> Polynomial {
        var values: [Fraction] = poly.values
        for i in 0 ..< values.count {
            values[i] = values[i] * number
        }
        return clean(Polynomial(Array(repeating: Fraction.zero, count:degree) + values))
    }
    
    public static func multiplyWithNumber(polynomial poly: Polynomial, with number: Int, ofDegree degree: Int) -> Polynomial {
        return multiplyWithNumber(polynomial: poly, with: Fraction(from: number), ofDegree: degree)
    }
    
    public static func multiplyWithNumber(polynomial poly: Polynomial, with number: Double, ofDegree degree: Int) -> Polynomial {
        return multiplyWithNumber(polynomial: poly, with: Fraction(from: number), ofDegree: degree)
    }

    public static func multiply(_ poly1: Polynomial, with poly2: Polynomial) -> Polynomial {
        var polynomial: [Polynomial] = []
        if poly1.degree == 0
            { return clean(multiplyWithNumber(polynomial: poly2, with:poly1.values[0], ofDegree: 0)) }
        else if poly2.degree == 0
            { return clean(multiplyWithNumber(polynomial: poly1, with:poly2.values[0], ofDegree: 0)) }
        for i in 0..<poly1.degree {
            polynomial.append(multiplyWithNumber(polynomial: poly2, with:poly1.values[i], ofDegree: i))
        }
        return clean(add(polynomial))
    }
    
    public static func derive(_ poly: Polynomial) -> Polynomial {
        if poly.degree == 0 {
            if poly.name != "" {return Polynomial(poly.name + "'", [Fraction.zero])}
            else {return Polynomial([Fraction.zero])}
        }
        var values = Array(poly.values[1 ..< poly.degree + 1])
        for i in 0 ..< values.count {
            values[i] = values[i] * Double(i + 1)
        }
        if poly.name != "" {return Polynomial(poly.name + "'", values)}
        else {return Polynomial(values)}
    }
    
    public static func derive(_ poly: Polynomial, times t: Int) -> Polynomial {
        var polynomial = poly
        for _ in 1 ... t {
            polynomial = derive(polynomial)
        }
        return polynomial
    }
    
    public static func integral(_ poly: Polynomial) -> Polynomial {
        var values = multiplyWithNumber(polynomial: poly, with: 1.0, ofDegree: 1).values
        for i in 0 ... poly.degree {
            values[i] = values[i] * Fraction(1, i)
        }
        return Polynomial(values)
    }
    
    public static func integral(_ poly: Polynomial, from a: Fraction, to b: Fraction) -> Fraction {
        let integralPoly = integral(poly)
        return integralPoly.value(at: b) - integralPoly.value(at: a)
    }
    
    // What if denominator is zero
    // Make delta an external variable
    public static func root(_ poly: Polynomial) -> Fraction? {
        if poly.degree < 2
            {return nil}
        else if poly.degree == 2
            {return -1 * (poly.values[0] / poly.values[1])}
        let derivative = derive(poly)
        var root       = Fraction.one
        var delta      = Fraction(1000000, 1)
        var iter       = 0
        while delta > Fraction(1, 1000000) && iter < 1000 {
            if derivative.value(at: root) == Fraction.zero {
                print("error")
            }
            delta = Fraction.abs(poly.value(at: root)/derivative.value(at: root))
            root = root - poly.value(at: root) /  derivative.value(at: root)
            //root = Fraction(from: Double(round(100*root.doubleValue())/100))
            iter += 1
        }
        print("Delta: \(delta), with root: \(root)")
        if delta > Fraction(1, 1000000) {return nil}
        //if poly.value(at: root) == 0 {
        //    return root
        //}
        //else {
            print("Truncating \(root) to \(((round(root.doubleValue()*100)/100)))")
            return Fraction(from: ((round(root.doubleValue()*100)/100))).simplify()
        //}
    }
    
    public static func horner(_ poly: Polynomial, at root: Fraction) -> Polynomial {
        var values: [Fraction] = poly.values.reversed()
        var newValues: [Fraction] = [values[0]]
        for i in 1 ..< poly.degree {
            newValues.append(values[i] + newValues[i-1] * root)
        }
        return Polynomial(Array(newValues.reversed()[1..<poly.degree]))
    }
    
    public static func roots(_ poly: Polynomial) -> [Fraction] {
        var roots: [Fraction] = []
        var intermediate = poly
        while root(intermediate) != nil {
            roots.insert(root(intermediate)!, at: 0)
            print(intermediate)
            intermediate = horner(intermediate, at: roots[0])
        }
        return roots.sorted()
    }
    
    public static func intersects(_ poly1: Polynomial, _ poly2: Polynomial) -> ([(Fraction, Fraction)]) {
        let newPoly = subtract(poly1, poly2)
        let roots   = self.roots(newPoly)
        var points: [(Fraction, Fraction)]  = []
        for root in roots {
            points.append((root, poly1.value(at: root)))
        }
        return points
    }
}
