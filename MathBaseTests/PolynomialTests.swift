//
//  PolynomialTests.swift
//  PolynomialTests
//
//  Created by Maxwell Szymanski on 10/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import XCTest
class PolynomialTests: XCTestCase {
    
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
    
    func testPolynomialAddition() {
        self.measure {
            let poly1 = Polynomial([1, 2])
            let poly2 = Polynomial([1, 3])
            let result = PolynomialOperation.add(poly1, to:poly2)
            XCTAssert(result.values == [2, 5].fractionArray)
        }
    }
    
    func testVariableLengthPolynomialAddition() {
        self.measure {
            let poly1 = Polynomial([1, 2, 3])
            let poly2 = Polynomial([1, 3])
            let result = PolynomialOperation.add(poly1, to:poly2)
            XCTAssert(result.values == [2, 5, 3].fractionArray)
        }
    }
    
    func testPolynomialSubtract() {
        self.measure {
            let poly1 = Polynomial([1, 2])
            let poly2 = Polynomial([1, 3])
            let result = PolynomialOperation.subtract(poly1, poly2)
            XCTAssert(result.values == [0, -1].fractionArray)
        }
    }
    
    func testVariableLengthPolynomialSubtraction() {
        self.measure {
            let poly1 = Polynomial([1, 2, 3])
            let poly2 = Polynomial([1, 3])
            let result = PolynomialOperation.subtract(poly1, poly2)
            XCTAssert(result.values == [0, -1, 3].fractionArray)
        }
    }
    
    func testPolynomialArrayAddition() {
        let poly1 = Polynomial([3, 0, 2, 3])
        let poly2 = Polynomial([0, 4, 3])
        let poly3 = Polynomial([2, 2, 0, 2])
        let result = PolynomialOperation.add([poly1, poly2, poly3])
        XCTAssert(result.values == [5, 6, 5, 5].fractionArray)
    }
    
    func testMultiplyWithNumber() {
        self.measure {
            let poly1 = Polynomial([1, 2, 3])
            let poly2 = Polynomial([0, 1, 3])
            let poly3 = Polynomial([0, 1, 3])
            var result = PolynomialOperation.multiplyWithNumber(polynomial: poly1, with: 3, ofDegree: 3)
            XCTAssert(result.values == [0, 0, 0, 3, 6, 9].fractionArray)
            result = PolynomialOperation.multiplyWithNumber(polynomial: poly2, with: 1, ofDegree: 2)
            XCTAssert(result.values == [0, 0, 0, 1, 3].fractionArray)
            result = PolynomialOperation.multiplyWithNumber(polynomial: poly3, with: 2, ofDegree: 0)
            XCTAssert(result.values == [0, 2, 6].fractionArray)
            
        }
    }
    
    func testMultiply() {
        self.measure {
            let poly1 = Polynomial([3, 0, 6])
            let poly2 = Polynomial([0, 5, 4])
            let result = PolynomialOperation.multiply(poly1, with:poly2)
            XCTAssert(result.values == [0, 15, 12, 30, 24].fractionArray)
        }
    }
    
    func testStringPrinting() {
        let poly1 = Polynomial([1, 2, 3])
        let poly2 = Polynomial([0, 1, 3])
        print("The polynomials:")
        print(poly1)
        print(poly2)
    }
    
    func testCleanPolynomial() {
        let poly1 = Polynomial([1, 3])
        XCTAssertEqual(poly1.values, PolynomialOperation.clean(poly1).values)
        let poly2 = Polynomial([1, 3, 0, 0])
        XCTAssertEqual([1, 3].fractionArray, PolynomialOperation.clean(poly2).values)
        let poly3 = Polynomial([0, 0, 0, 0])
        XCTAssertEqual([0].fractionArray, PolynomialOperation.clean(poly3).values)
    }
    
    func testPolynomialDivision() {
        let poly1 = Polynomial([0, 1, 2].fractionArray)
        let poly2 = Polynomial([1, 2].fractionArray)
        let result = PolynomialOperation.divide(poly1, by: poly2)
        print(result.quotient)
        print(result.remainder)
        let poly3 = Polynomial([6, -2, 0, 6])
        let poly4 = Polynomial([2, 1])
        let result2 = PolynomialOperation.divide(poly3, by: poly4)
        print(result2.quotient)
        print(result2.remainder)
    }
    
    func testPolynomialValue() {
        let poly = Polynomial([2, 4, 2, 8, 5])
        XCTAssert(poly.value(at: 3) == Fraction(from: 653))
    }
    
    func testDerivative() {
        let poly = Polynomial("g", [5, 0, 4, 6])
        let derivative = PolynomialOperation.derive(poly)
        XCTAssert(derivative.values == [0, 8, 18].fractionArray)
        let thirdDerivative = PolynomialOperation.derive(poly, times: 3)
        XCTAssert(thirdDerivative.values == [36].fractionArray)
        let poly2 = Polynomial([0, 1])
        XCTAssert(PolynomialOperation.derive(poly2).values == [1].fractionArray)
        print("\n\nThe derivative of \(poly) is \(derivative)\n\n" )
    }
    
    func testHorner() {
        let poly = Polynomial([0, 4, -3, -1])
        let hornerPoly = PolynomialOperation.horner(poly, at: Fraction.one)
        XCTAssert(hornerPoly.values == [0, -4, -1].fractionArray)
        let poly2 = Polynomial([0, 0, 1])
        let hornerPoly2 = PolynomialOperation.horner(poly2, at: Fraction.zero)
        XCTAssert(hornerPoly2.values == [0, 1].fractionArray)
    }
    
    func testNoRoot() {
        let poly = Polynomial([10, 4, -3, 0, 1])
        for _ in 0 ... 10 {
            let root: Fraction? = PolynomialOperation.root(poly)
            XCTAssert(root == nil)
        }
    }
    
    func testFindRoots() {
        self.measure{
            let poly = Polynomial([0, 0, -1, 1])
            XCTAssert(PolynomialOperation.roots(poly) == [0, 0, 1].fractionArray)
        }
    }
    
    func testIntersects() {
        let poly1 = Polynomial([2, 0, -4])
        let poly2 = Polynomial([0, 2])
        print(PolynomialOperation.intersects(poly1, poly2))
        XCTAssert(PolynomialOperation.intersects(poly1, poly2)[0] == (Fraction(from:-1), Fraction(from:-2)))
        XCTAssert(PolynomialOperation.intersects(poly1, poly2)[1] == (Fraction(1, 2), Fraction(from:1)))
        let poly3 = Polynomial([2, 1, 4])
        let poly4 = Polynomial([0, 2])
        print(PolynomialOperation.intersects(poly3, poly4))
        XCTAssert(PolynomialOperation.intersects(poly3, poly4).count == 0)
    }
    
    func testFromRoots() {
        let poly = Polynomial(fromZeros: [-300, -250, -120, 30, 60])
        print(poly)
    }
    
    func testMultiplySingleton() {
        let poly1 = Polynomial([1])
        let poly2 = Polynomial([2])
        let result = PolynomialOperation.multiply(poly1, with: poly2)
        print(result)
    }
    

}

extension Collection where Iterator.Element == Int {
    var fractionArray: [Fraction] {
        return compactMap{ Fraction(from: $0) }
    }
}
