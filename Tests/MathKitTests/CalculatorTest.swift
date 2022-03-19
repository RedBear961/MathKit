//
//  Copyright (c) 2022 Georgiy Cheremnykh
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import MathKit

final class CalculatorTest: XCTestCase {
    
    var calculator: Calculator!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        calculator = Calculator()
    }

    override func tearDownWithError() throws {
        calculator = nil
    }
    
    // MARK: - Testing
    
    func test_thatSumTwoNumbersSuccess() {
        let expression = TokenizedExpression(with: [
            .decimal(2),
            .decimal(3),
            .infix("*"),
            .decimal(4),
            .infix("+")
        ])
        let expectedResult: NSDecimalNumber = 10
        
        test(expression, with: expectedResult)
    }
    
    func test_thatTheMultipleOperationSuccess() {
        let expression = TokenizedExpression(with: [
            .decimal(2),
            .decimal(8),
            .decimal(3),
            .infix("^"),
            .infix("+"),
            .decimal(4),
            .decimal(-2),
            .infix("*"),
            .infix("-")
        ])
        let expectedResult: NSDecimalNumber = 522
        
        test(expression, with: expectedResult)
    }
    
    // MARK: - Helper

    func test(_ expression: TokenizedExpression, with expectedResult: NSDecimalNumber) {
        let expectation = XCTestExpectation()
        
        calculator.calculate(expression) { result in
            switch result {
            case .success(let expression):
                XCTAssertEqual(expression, expectedResult)
            case .fail(_):
                XCTFail()
            }

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: kExpectationTimeout)
    }
}
