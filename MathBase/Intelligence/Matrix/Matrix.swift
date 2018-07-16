//
//  Matrix.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 22/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class Matrix: CustomStringConvertible {
    var values:  [[Fraction]]
    var name:    String
    var rows:    Int        {return values.count}
    var columns: Int        {return values[0].count}
    var dim:     (Int, Int) {return (rows, columns)}
    var square:  Bool       {return (values.count == values[0].count)}
    
    public var description: String {
        var string: String = "\\begin{bmatrix}\n"
        for i in 0 ..< self.rows {
            for j in 0 ..< self.columns-1 {
                string += values[i][j].description + " & "
            }
            string += values[i][self.columns-1].description + " \\\\ \n"
        }
        string += "\\end{bmatrix}"
        return string
    }
    
    init (_ name: String, _ values:[[Fraction]]) {
        self.name = ""
        self.values = values
    }
    
    init (_ values:[[Fraction]]) {
        self.name = ""
        self.values = values
    }
    
    init (_ values:[[Double]]) {
        self.name = ""
        let m: Matrix = Matrix.zeros(values.count, values[0].count)
        for i in 0 ..< values.count {
            for j in 0 ..< values[i].count {
                m.elem(i, j, setTo: Fraction(from: values[i][j]))
            }
        }
        self.values = m.values
    }
    
    init (_ values:[[Int]]) {
        self.name = ""
        let m: Matrix = Matrix.zeros(values.count, values[0].count)
        for i in 0 ..< values.count {
            for j in 0 ..< values[i].count {
                m.elem(i, j, setTo: Fraction(from: values[i][j]))
            }
        }
        self.values = m.values
    }
    
    func elem(_ row: Int, _ column: Int) -> Fraction {
        return self.values[row][column]
    }
    func elem(_ row: Int, _ column: Int, setTo elem: Fraction) {
        self.values[row][column] = elem
    }
    
    /// Creates a `m x n` matrix containing zeros (as fractions).
    ///
    /// - Parameters:
    ///   - m: The amount of rows the matrix needs to have.
    ///   - n: The amount of columns the matrix needs to have.
    /// - Returns: Returns a `m x n` matrix containing zeros.
    static func zeros(_ m: Int, _ n: Int) -> Matrix {
        return Matrix(Array<[Fraction]>(repeating:Array<Fraction>(repeating:Fraction.zero, count: n), count: m))
    }
    
    /// Creates a `m x n` matrix containing ones (as fractions).
    ///
    /// - Parameters:
    ///   - m: The amount of rows the matrix needs to have.
    ///   - n: The amount of columns the matrix needs to have.
    /// - Returns: Returns a `m x n` matrix containing ones.
    static func ones(_ m: Int, _ n: Int) -> Matrix {
        return Matrix(Array<[Fraction]>(repeating:Array<Fraction>(repeating:Fraction.one, count: n), count: m))
    }
    
    /// Creates a `m x n` matrix containing random numbers between 0 and the given `bound` (including).
    ///
    /// - Parameters:
    ///   - m: The amount of rows the matrix needs to have.
    ///   - n: The amount of columns the matrix needs to have.
    ///   - bound: The bound of the random numbers (including).
    /// - Returns: Returns a m x n matrix containing random numbers between 0 and `bound` (including).
    static func random(_ m: Int, _ n: Int, bound: Int) -> Matrix {
        assert(bound > 0)
        var values = Array<[Fraction]>(repeating:Array<Fraction>(repeating:Fraction.one, count: n), count: m)
        for i in 0 ..< m {
            for j in 0 ..< n {
                values[i][j] = Fraction(from: Int(arc4random_uniform(UInt32(bound+1))))
        }   }
        return Matrix(values)
    }
    
    /// Creates a `m x n` matrix containing random numbers between `lbound` and `ubound` (including).
    ///
    /// - Parameters:
    ///   - m: The amount of rows the matrix needs to have.
    ///   - n: The amount of columns the matrix needs to have.
    ///   - lbound: The lower bound of the random numbers (including).
    ///   - ubound: The upper bound of the random numbers (including).
    /// - Returns: Returns a `m x n` matrix containing random numbers between `lbound` and `ubound` (including).
    static func random(_ m: Int, _ n: Int, lbound: Int, ubound: Int) -> Matrix {
        assert(ubound > lbound)
        var values = Array<[Fraction]>(repeating:Array<Fraction>(repeating:Fraction.one, count: n), count: m)
        for i in 0 ..< m {
            for j in 0 ..< n {
                values[i][j] = Fraction(from: Int(arc4random_uniform(UInt32(ubound - lbound))) + lbound)
            }   }
        return Matrix(values)
    }
    
    /// Creates a `m x n` matrix containing random numbers between 1 and the given `bound` (including).
    ///
    /// - Parameters:
    ///   - m: The amount of rows the matrix needs to have.
    ///   - n: The amount of columns the matrix needs to have.
    ///   - bound: The bound of the random numbers (including).
    /// - Returns: Returns a `m x n` matrix containing random numbers between 0 and `bound` (including).
    static func nonZeroRandom(_ m: Int, _ n: Int, bound: Int) -> Matrix {
        assert(bound > 0)
        var values = Array<[Fraction]>(repeating:Array<Fraction>(repeating:Fraction.one, count: n), count: m)
        for i in 0 ..< m {
            for j in 0 ..< n {
                values[i][j] = Fraction(from: Int(arc4random_uniform(UInt32(bound)))+1)
            }   }
        return Matrix(values)
    }
    
    /// Creates a `m x n` matrix containing non-zero random numbers between `lbound` and `ubound` (including).
    ///
    /// - Parameters:
    ///   - m: The amount of rows the matrix needs to have.
    ///   - n: The amount of columns the matrix needs to have.
    ///   - lbound: The lower bound of the random numbers (including).
    ///   - ubound: The upper bound of the random numbers (including).
    /// - Returns: Returns a `m x n` matrix containing non-zero random numbers between `lbound` and `ubound` (including).
    static func nonZeroRandom(_ m: Int, _ n: Int, lbound: Int, ubound: Int) -> Matrix {
        assert(ubound > lbound)
        var values = Array<[Fraction]>(repeating:Array<Fraction>(repeating:Fraction.one, count: n), count: m)
        var x: Int
        for i in 0 ..< m {
            for j in 0 ..< n {
                repeat {x = Int(arc4random_uniform(UInt32(ubound - lbound))) + lbound}
                while (x == 0)
                values[i][j] = Fraction(from: x)
            }   }
        return Matrix(values)
    }
}
