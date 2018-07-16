//
//  MatrixOperation.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 22/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import Foundation

public class MatrixOperations {
    
    
    // Add column implementation, and use (row, 0) call in determinant.
    static func minor(_ matrix: Matrix, row: Int) -> Matrix {
        var values: [[Fraction]] = []
        for i in 0 ..< matrix.rows {
            if (i != row) {values.append(Array(matrix.values[i][1 ..< matrix.columns]))}
        }
        return Matrix(values)
    }
    
    /// Returns a transpose of the given matrix.
    ///
    /// - Parameter matrix: The matrix that needs to be transposed.
    /// - Returns: The transpose of the given matrix.
    static func transpose(_ matrix: Matrix) -> Matrix {
        let m = Matrix.zeros(matrix.columns, matrix.rows)
        for i in 0 ..< matrix.rows {
            for j in 0 ..<  matrix.columns {
                m.elem(j, i, setTo: matrix.elem(i, j))
        }   }
        return m
    }
    
    /// Returns the result of the multiplication of two given matrices.
    /// The first matrix should have as many columns as the second matrix has rows.
    ///
    /// - Parameters:
    ///   - m1: The first matrix of the multiplication.
    ///   - m2: The second matrix of the multiplication.
    /// - Returns: The result of the multiplication.
    static func multiply(_ m1: Matrix, with m2: Matrix) -> Matrix? {
        assert(m1.columns == m2.rows, "The first matrix should have as many columns as the second matrix has rows in order to be multiplied.")
        let n = m1.columns
        let C = Matrix.zeros(m1.rows, m2.columns)
        for i in 0 ..< n {
            for j in 0 ..< n {
                for k in 0 ..< n {
                    C.elem(i, j, setTo: C.elem(i, j) + m1.elem(i, k) * m2.elem(k, j))
        }   }   }
        return C
    }
    
    /// Swaps two rows of the given matrix.
    ///
    /// - Parameters:
    ///   - matrix: The matrix of which the rows should be switched.
    ///   - r1: The first row to be switched.
    ///   - r2: The second row to be switched.
    static func swapRows(_ matrix: Matrix, _ r1: Int, _ r2: Int) {
        let row = matrix.values[r1]
        for i in 0 ..< matrix.columns {
            matrix.elem(r1, i, setTo: matrix.elem(r2, i))
            matrix.elem(r2, i, setTo: row[i])
    }   }
    
    
    /// Swaps two columns of the given matrix.
    ///
    /// - Parameters:
    ///   - matrix: The matrix of which the columns should be switched.
    ///   - c1: The first column to be switched.
    ///   - c2: The second column to be switched.
    static func swapColumns(_ matrix: Matrix, _ c1: Int, _ c2: Int) {
        var col = Array(repeating: Fraction.zero, count: matrix.rows)
        for i in 0 ..< matrix.rows {
            col[i] = matrix.elem(i, c1)
            matrix.elem(i, c1, setTo: matrix.elem(i, c2))
            matrix.elem(i, c2, setTo: col[i])
    }   }
    
    /// Multiplies the matrix with a given value.
    ///
    /// - Parameters:
    ///   - matrix: The matrix that needs to be multiplied.
    ///   - x: The value used for multiplying the matrix with.
    static func multiply(_ matrix: Matrix, withValue x: Fraction){
        for i in 0 ..< matrix.rows {
            for j in 0 ..< matrix.columns {
                matrix.elem(i, j, setTo: matrix.elem(i, j) * x)
    }   }   }
    
    /// Multiplies one given row the matrix with a given value.
    ///
    /// - Parameters:
    ///   - matrix: The matrix that needs to have its row multiplied.
    ///   - row: The row that needs to be multiplied.
    ///   - x: The value used for multiplying the matrix with.
    static func multiply(_ matrix: Matrix, row: Int, withValue x: Fraction){
        for j in 0 ..< matrix.columns {
            matrix.elem(row, j, setTo: matrix.elem(row, j) * x)
    }   }
    
    /// Multiplies one given column the matrix with a given value.
    ///
    /// - Parameters:
    ///   - matrix: The matrix that needs to have its row multiplied.
    ///   - row: The row that needs to be multiplied.
    ///   - x: The value used for multiplying the matrix with.
    static func multiply(_ matrix: Matrix, column: Int, withValue x: Fraction){
        for i in 0 ..< matrix.rows {
            matrix.elem(i, column, setTo: matrix.elem(i, column) * x)
    }   }
    
    /// Multiplies the matrix with a given integer.
    ///
    /// - Parameters:
    ///   - matrix: The matrix that needs to be multiplied.
    ///   - x: The value used for multiplying the matrix with as an integer.
    static func multiply(_ matrix: Matrix, withValue x: Int){
        for i in 0 ..< matrix.rows {
            for j in 0 ..< matrix.columns {
                matrix.elem(i, j, setTo: matrix.elem(i, j) * x)
            }   }   }
    
    /// Multiplies one given row the matrix with a given integer.
    ///
    /// - Parameters:
    ///   - matrix: The matrix that needs to have its row multiplied.
    ///   - row: The row that needs to be multiplied.
    ///   - x: The value used for multiplying the matrix with as an integer.
    static func multiply(_ matrix: Matrix, row: Int, withValue x: Int) {
        for j in 0 ..< matrix.columns {
            matrix.elem(row, j, setTo: matrix.elem(row, j) * x)
        }   }
    
    /// Multiplies one given column the matrix with a given integer.
    ///
    /// - Parameters:
    ///   - matrix: The matrix that needs to have its row multiplied.
    ///   - row: The row that needs to be multiplied.
    ///   - x: The value used for multiplying the matrix with as an integer.
    static func multiply(_ matrix: Matrix, column: Int, withValue x: Int) {
        for i in 0 ..< matrix.rows {
            matrix.elem(i, column, setTo: matrix.elem(i, column) * x)
        }   }
    
    /// Returns the sum of two matrices. The given matrices need to have
    /// the same dimensions.
    ///
    /// - Parameters:
    ///   - m1: The first matrix for the addition.
    ///   - m2: The second matrix for the addition.
    /// - Returns: The sum of two matrices.
    static func add(_ m1: Matrix, to m2: Matrix) -> Matrix? {
        assert(m1.dim == m2.dim, "The dimensions of the two matrices should be the same in order to be added.")
        var matrix = m1.values
        for i in 0 ..< m1.rows {
            for j in 0 ..< m1.columns {
                matrix[i][j] = matrix[i][j] + m2.values[i][j]
        }   }
        return Matrix(matrix)
    }
    
    /// Returns the difference of two matrices. The given matrices need to have
    /// the same dimensions.
    ///
    /// - Parameters:
    ///   - m1: The first matrix for the subtraction.
    ///   - m2: The second matrix for the subtraction.
    /// - Returns: The sum of two matrices.
    static func subtract(_ m1: Matrix, to m2: Matrix) -> Matrix? {
        assert(m1.dim == m2.dim, "The dimensions of the two matrices should be the same in order to be subtracted.")
        var matrix = m1.values
        for i in 0 ..< m1.rows {
            for j in 0 ..< m1.columns {
                matrix[i][j] = matrix[i][j] - m2.values[i][j]
            }   }
        return Matrix(matrix)
    }
    
    /// Subtracts the `r2`-th row from the `r1`-th one of a given matrix.
    ///
    /// - Parameters:
    ///   - matrix: The matrix on which the operations should be performed.
    ///   - r2: The row that will be subtracted.
    ///   - r1: The row that will be subtracted from.
    static func subtractRow(_ matrix: Matrix, subtract r2: Int, from r1: Int) {
        assert(r1 < matrix.rows, "The parameter r1 with value \(r1) exeeds the matrix size (\(matrix.rows) rows).")
        assert(r2 < matrix.rows, "The parameter r2 with value \(r2) exeeds the matrix size (\(matrix.rows) rows).")
        for j in 0 ..< matrix.rows {
            matrix.elem(r1, j, setTo: matrix.elem(r1, j) - matrix.elem(r2, j))
    }   }
    
    /// Subtracts the `r2`-th row `n` times from the `r1`-th one of a given matrix.
    /// - Parameters:
    ///   - matrix: The matrix on which the operations should be performed.
    ///   - r2: The row that will be subtracted.
    ///   - r1: The row that will be subtracted from.
    static func subtractRow(_ matrix: Matrix, subtract r2: Int, from r1: Int, times n: Fraction) {
        assert(r1 < matrix.rows, "The parameter r1 with value \(r1) exeeds the matrix size (\(matrix.rows) rows).")
        assert(r2 < matrix.rows, "The parameter r2 with value \(r2) exeeds the matrix size (\(matrix.rows) rows).")
        for j in 0 ..< matrix.columns {
            matrix.elem(r1, j, setTo: matrix.elem(r1, j) - n * matrix.elem(r2, j))
    }   }
    
    /// Subtracts the `r2`-th row `n` times from the `r1`-th one of a given matrix.
    ///
    /// - Parameters:
    ///   - matrix: The matrix on which the operations should be performed.
    ///   - r2: The row that will be subtracted.
    ///   - r1: The row that will be subtracted from.
    static func subtractRow(_ matrix: Matrix, subtract r2: Int, from r1: Int, times n: Int) {
        let k: Fraction = Fraction(from: n)
        for j in 0 ..< matrix.columns {
            matrix.elem(r1, j, setTo: matrix.elem(r1, j) - k * matrix.elem(r2, j))
    }   }
    
    /// Transforms the matrix to its upper-triangular form.
    ///
    /// - Parameter matrix: The coefficients of the variables.
    static func gaussianElimination(_ matrix: Matrix) {
        for j in 0 ..< matrix.columns {
            for i in j+1 ..< matrix.rows {
                subtractRow(matrix, subtract: j, from: i, times: matrix.elem(i, j)/matrix.elem(j, j))
    }   }   }
    
    /// Transforms the augmented matrix to its upper-triangular form.
    ///
    /// - Parameters:
    ///   - matrix: The coefficients of the variables.
    ///   - solution: The coefficients after the equals sign.
    static func gaussianElimination(_ matrix: Matrix, solution: Matrix) {
        assert(solution.dim == (matrix.rows, 1))
        for j in 0 ..< matrix.columns {
            for i in j+1 ..< matrix.rows {
                subtractRow(solution, subtract: j, from: i, times: matrix.elem(i, j)/matrix.elem(j, j))
                subtractRow(matrix,   subtract: j, from: i, times: matrix.elem(i, j)/matrix.elem(j, j))
    }   }   }
    
    
    /// Solves a matrix using gaussian elimination and backsubstitution.
    ///
    /// - Parameters:
    ///   - matrix: The matrix containing the coefficients.
    ///   - solution: The matrix containing the constants.
    static func backsubstitute(_ matrix: Matrix, solution: Matrix) {
        if (solution.rows == 1) {solution.values = transpose(solution).values}
        gaussianElimination(matrix, solution: solution)
        print(solution.values)
        print(matrix.values)
        let n: Int = matrix.rows
        for i in (0 ..< n).reversed() {
            solution.elem(i, 0, setTo: solution.elem(i, 0) / matrix.elem(i, i))
            for k in (0 ..< i) {
                solution.elem(k, 0, setTo: solution.elem(k, 0) - matrix.elem(k, i) * solution.elem(i, 0))
    }   }   }
    
    /// Returns the determinant of the matrix
    ///
    /// - Parameter matrix: The matrix of which the determinant should be calculated.
    /// - Returns: The determinant of the given matrix.
    static func determinant(_ matrix: Matrix) -> Fraction {
        assert(matrix.rows == matrix.columns)
        let m = Matrix(matrix.values)
        gaussianElimination(m)
        var det: Fraction = Fraction.one
        for i in 0 ..< m.rows {
            det = det * m.elem(i, i)
        }
        return det
    }
    
    /*
    static func LUDecomposition(_ matrix: Matrix) -> Matrix {
        var m: Matrix = Matrix(matrix.values)
        var a:Fraction = Fraction.zero
        for i in 0 ..< m.rows {
            for j in 0 ..< i {
                a = m.elem(i, j)
                for p in 0 ..< j {
                    a = a - m.elem(i, p) * m.elem(p, j)
                }
                m.elem(i, j, setTo: (a/m.elem(j, j)) )
            }
            for j in i ..< m.rows {
                a = m.elem(i, j)
                for p in 0 ..< i {
                    a = a - m.elem(i, p) * m.elem(p, j)
                }
                m.elem(i, j, setTo: a )
        }   }
        return m
    }
 */
    
    
    
}
