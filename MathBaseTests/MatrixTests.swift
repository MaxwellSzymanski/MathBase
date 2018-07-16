//
//  MatrixTests.swift
//  MathBaseTests
//
//  Created by Maxwell Szymanski on 22/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMatrixMultiplication() {
        let A = Matrix([[2, 3], [4, 5]])
        let B = Matrix([[4, 3], [2, 6]])
        let result: [[Fraction]] = (MatrixOperations.multiply(A, with: B)?.values)!
        for i in 0 ..< result.count {
            assert(result[i] == Matrix([[14, 24], [26, 42]]).values[i])
        }
    }
    
    func testTranspose() {
        let matrix = Matrix([[2, 4, 1, 2], [2, 1, 0, 0]])
        let result = MatrixOperations.transpose(matrix).values
        let knownResult = Matrix([[2, 2], [4, 1], [1, 0], [2, 0]])
        for i in 0 ..< result.count {
            assert(result[i] == knownResult.values[i])
        }
    }
    
    func testSubtractRow() {
        let matrix = Matrix([[2, 4, 1, 2], [2, 1, 0, 0], [3, 2, 3, 3]])
        MatrixOperations.subtractRow(matrix, subtract: 1, from: 0)
        let knownResult = Matrix([[0, 3, 1, 2], [2, 1, 0, 0], [3, 2, 3, 3]])
        print(matrix.values)
        for i in 0 ..< knownResult.values.count {
            assert(matrix.values[i] == knownResult.values[i])
        }
    }
    
    func testSubtractRowNTimes() {
        let matrix = Matrix([[2, 4, 1, 2], [2, 1, 0, 0], [3, 2, 3, 3]])
        MatrixOperations.subtractRow(matrix, subtract: 1, from: 0, times: 3)
        let knownResult = Matrix([[-4, 1, 1, 2], [2, 1, 0, 0], [3, 2, 3, 3]])
        print(matrix.values)
        for i in 0 ..< knownResult.values.count {
            assert(matrix.values[i] == knownResult.values[i])
        }
    }
    
    func testGaussianElimination() {
        let matrix = Matrix([[2, 4, 1, 2], [2, 1, 3, 3], [3, 2, 3, 3], [3, 2, 3, 2]])
        MatrixOperations.gaussianElimination(matrix)
        print(matrix.values)
        let matrix2 = Matrix([[1, -2, 1], [2, 1, -3], [4, -7, 1]])
        MatrixOperations.gaussianElimination(matrix2)
        print(matrix2.values)
    }
    
    func testBacksubstitute() {
        let matrix = Matrix([[1, -2, 1], [2, 1, -3], [4, -7, 1]])
        let solutions = Matrix([[0, 5,-1]])
        MatrixOperations.backsubstitute(matrix, solution: solutions)
        print(solutions.values)
    }
    
    func testMatrixgeneration() {
        let zeros = Matrix.zeros(3, 4)
        print(zeros)
        let ones = Matrix.ones(1, 1)
        print(ones)
        let random = Matrix.random(4, 4, bound:5)
        print(random)
    }
    
    func testDeterminantPerformance() {
        let n: Int = 5
        var times: [Double] = Array<Double>(repeating: 0.0, count: n)
        for i in 1 ... n {
            print("Matrix of size: \(5 * Int(pow(2.0,Double(i))))")
            let matrix = Matrix.nonZeroRandom(5*Int(pow(2.0,Double(i))), 5*Int(pow(2.0,Double(i))), bound: 10)
            let start = NSDate()
            MatrixOperations.determinant(matrix)
            let end = NSDate()
            times[i-1] = end.timeIntervalSince(start as Date)
        }
        print(times)
    }
    
    
    func testLUDecomposition() {
        var m = Matrix([[Fraction(1, 3), Fraction(1, 3)], [Fraction(4, 3), Fraction(1, 5)]])
        // print(MatrixOperations.LUDecomposition(m).values)
    }
    
}

