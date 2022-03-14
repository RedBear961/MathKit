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

final class ShuntingYardTest: XCTestCase {

    var shuntingYard: ShuntingYard!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        shuntingYard = ShuntingYard()
    }

    override func tearDownWithError() throws {
        shuntingYard = nil
    }
    
    // MARK: - Testing
    
    func test_thatShuntingYardConvertingInfixOperationSuccess() {
        let expression = TokenizedExpression(with: [
            .constant(2),
            .infix("+"),
            .constant(2)
        ])
        
        let expectedResult = TokenizedExpression(with: [
            .constant(2),
            .constant(2),
            .infix("+")
        ])
        
        test(expression, with: expectedResult)
    }
    
    func test_thatShuntingYardConvertingOperationWithDiffrentPrioritySuccess() {
        let expression = TokenizedExpression(with: [
            .constant(2),
            .infix("*"),
            .constant(3),
            .infix("+"),
            .constant(4)
        ])
        
        let expectedResult = TokenizedExpression(with: [
            .constant(2),
            .constant(3),
            .infix("*"),
            .constant(4),
            .infix("+")
        ])
        
        test(expression, with: expectedResult)
    }
    
    // MARK: - Helper

    func test(_ expression: TokenizedExpression, with expectedResult: TokenizedExpression) {
        let expectation = XCTestExpectation()
        
        shuntingYard.postfixNotation(from: expression) { result in
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
