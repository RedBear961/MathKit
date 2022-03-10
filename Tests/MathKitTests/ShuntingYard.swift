//
//  ShuntingYard.swift
//  
//
//  Created by Черемных Георгий Алексеевич on 10.03.2022.
//

import XCTest
@testable import MathKit

class ShuntingYard: XCTestCase {

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
    }
    
    // MARK: - Helper

    func test(_ expression: TokenizedExpression, with expectedResult: TokenizedExpression) {
        let expectation = XCTestExpectation()
        
//        shuntingYard.postfixNotation(from: expression) { result in
//            switch result {
//            case .success(let expression):
//                XCTAssertEqual(expression, expectedResult)
//            case .fail(_):
//                XCTFail()
//            }
//
//            expectation.fulfill()
//        }
        
        wait(for: [expectation], timeout: kExpectationTimeout)
    }
}
