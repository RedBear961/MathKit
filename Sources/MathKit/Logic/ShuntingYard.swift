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

public protocol InfixNotationConverting {
    
    func postfixNotation(from expression: TokenizedExpression, _ completion: TokenizedResult)
}

open class ShuntingYard: InfixNotationConverting {
    
    private let tokenizer: Tokenizing
    private let infixContainer = InfixOperationContainer.shared
    
    public init(tokenizer: Tokenizing = Tokenizer()) {
        self.tokenizer = tokenizer
    }
    
    // MARK: - InfixNotationConverting
    
    public func postfixNotation(from expression: TokenizedExpression, _ completion: TokenizedResult) {
        let postfixNotation = TokenizedExpression()
        let stack = Stack<Token>()
        
        var index = 0
        while index < expression.count {
            let token = postfixNotation.nextObject()
            
            switch token.type {
            case .decimal:
                postfixNotation.add(token)
            case .infix:
                processInfixOperation(
                    token,
                    expression: expression,
                    stack: stack
                )
            case .unknown:
                completion(.fail(.unknown))
            }
            
            index += 1
        }
    }
    
    // MARK: - Private
    
    private func processInfixOperation(
        _ token: Token,
        expression: TokenizedExpression,
        stack: Stack<Token>
    ) {
        if stack.count > 0 {
            var topToken: Token? = stack.pop()

            while let tmpToken = topToken, tmpToken.type == .infix,
                  infixContainer.operation(token, hasHigherPriorityThan: tmpToken) {
                expression.add(tmpToken)
                topToken = stack.pop()
            }
            
            if let topToken = topToken {
                stack.push(topToken)
            }
        }
        
        stack.push(token)
    }
}
