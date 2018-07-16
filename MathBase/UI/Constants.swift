//
//  Constants.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 23/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit

public struct Subjects {
    static let polynomial = Subject(title:   "Polynomial",
                                    color:   UIColor(fromHexString: "#E32636"),
                                    actions: Actions.polynomialActions)
    static let matrix     = Subject(title:   "Matrix",
                                    color:   UIColor(fromHexString: "#4169E1"),
                                    actions: [])
    static let vector     = Subject(title:   "Vector",
                                    color:   UIColor(fromHexString: "#009E60"),
                                    actions: [])
    static let subjects   = [polynomial, matrix, vector]
}

public struct Actions {
    static let intersects = Action(title: "Intersects",
                                   description: "Calculate the intersects of two polynomials.")
    static let calculateRoots = Action(title: "Calculate roots",
                                       description: "Calculate the roots of a function (where the function value is zero).")
    static let calculateValue = Action(title: "Calculate value",
                                       description: "Calculate the value of the function at a given value.")
    static let getPrimitiveFunction = Action(title: "Get primitive function",
                                             description: "Get the primitive function of a polynomial.")
    static let calculateSurface = Action(title: "Calculate surface",
                                         description: "Calculate the surface underneath a polynomial")
    static let derivative = Action(title: "Get derivative",
                                   description: "Get the derivative function of a polynomial.")
    static let polynomialActions = [intersects, calculateRoots, calculateValue, getPrimitiveFunction, calculateSurface, derivative]
}
