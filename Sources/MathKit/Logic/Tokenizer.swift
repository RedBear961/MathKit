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

public typealias TokenizedResult = (Result<TokenizedExpression>) -> Void

public protocol Tokenizing {
    
    func tokenize(_ expression: String, _ completion: TokenizedResult)
}

open class Tokenizer: Tokenizing {
    
    private let infixContainer: OperationContainer
    
    public init() {
        self.infixContainer = InfixOperationContainer.shared
    }
    
    // MARK: - Tokenizing
    
    public func tokenize(_ expression: String, _ completion: TokenizedResult) {
        let expression = expression.replacingOccurrences(of: " ", with: "")
        let scanner = Scanner(string: expression)
        
        var tokenizedExpression = TokenizedExpression()
        
        while scanner.currentIndex < expression.endIndex {
            let character = expression[scanner.currentIndex]
            
            if character.isNumber ||
                (character.isSign && !tokenizedExpression.last.isDecimal) {
                guard let number = scanner.scanDouble() else {
                    preconditionFailure()
                }
                
                let token = Token(constant: number)
                tokenizedExpression.add(token)
                continue
            }
            
            if infixContainer.isOperation(character.toString) {
                let token = Token(stringValue: character.toString, type: .infix)
                tokenizedExpression.add(token)
                scanner.incrementIndex()
                continue
            }
        }
        
        completion(.success(tokenizedExpression))
    }
}
