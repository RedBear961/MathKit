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

import Foundation

public class Calculator {
    
    private let converter: ShuntingYard
    
    public init() {
        self.converter = ShuntingYard()
    }
    
    // MARK: - Public
    
    public typealias CalculationResult = (Result<NSDecimalNumber>) -> Void
    
    public func calculate(_ expression: String, _ completion: @escaping CalculationResult) {
        converter.postfixNotation(from: expression) { result in
            switch result {
            case .success(let expression):
                calculate(expression, completion)
            case .fail:
                completion(.fail(.unknown))
            }
        }
    }
    
    public func calculate(_ expression: TokenizedExpression, _ completion: @escaping CalculationResult) {
        let stack = Stack<NSDecimalNumber>()
        
        while let token = expression.nextObject() {
            switch token {
            case .decimal(let number):
                stack.push(number)
            case .infix(let infix):
                guard let values = stack.pop(count: 2) else {
                    completion(.fail(.unknown))
                    return
                }
                
                let result = infix.action(values[0], values[1])
                stack.push(result)
            case .postfix(let postfix):
                guard let value = stack.pop() else {
                    completion(.fail(.unknown))
                    return
                }
                let result = postfix.action(value)
                stack.push(result)
            case .bracket(let bracket):
                break
            }
        }
        
        guard let result = stack.pop(), stack.isEmpty else {
            completion(.fail(.unknown))
            return
        }
        
        completion(.success(result))
    }
}
