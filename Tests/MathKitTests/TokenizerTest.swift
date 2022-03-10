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

final class TokenizerTest: XCTestCase {
    
    var tokenizer: Tokenizer!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        tokenizer = Tokenizer()
    }

    override func tearDownWithError() throws {
        tokenizer = nil
    }
    
    // MARK: - Testing
    
    func test_thatTokenizationTheSummaryOperationSuccess() {
        let expression = "2 + 2"
        let expectedResult = TokenizedExpression(with: [
            Token(constant: 2),
            Token(stringValue: "+", type: .infix),
            Token(constant: 2)
        ])
        
        test(expression, with: expectedResult)
    }
    
    func test_thatTokenizationTheUnaryOperationSuccess() {
        let expression = "2 / -2"
        let expectedResult = TokenizedExpression(with: [
            Token(constant: 2),
            Token(stringValue: "/", type: .infix),
            Token(constant: -2)
        ])
        
        test(expression, with: expectedResult)
    }
    
    func test_thatTokenizationMultipleOperationsSuccess() {
        let expression = "2 + 4 * 2"
        let expectedResult = TokenizedExpression(with: [
            Token(constant: 2),
            Token(stringValue: "+", type: .infix),
            Token(constant: 4),
            Token(stringValue: "*", type: .infix),
            Token(constant: 2)
        ])
        
        test(expression, with: expectedResult)
    }
    
    // MARK: - Helper
    
    func test(_ expression: String, with expectedResult: TokenizedExpression) {
        let expectation = XCTestExpectation()
        
        tokenizer.tokenize(expression) { result in
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
