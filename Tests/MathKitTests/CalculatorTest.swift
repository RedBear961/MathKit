//
//  CalculatorTest.swift
//  
//
//  Created by Черемных Георгий Алексеевич on 07.03.2022.
//

import XCTest
@testable import MathKit

class CalculatorTest: XCTestCase {
    
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
        // Given
        let exp = "2 + 2"
        let expectation = XCTestExpectation()
        
        // When
        calculator.calculate(exp) { result in
            // Then
            switch result {
            case .success(let number):
                XCTAssertEqual(number, 4)
            case .fail(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
}
