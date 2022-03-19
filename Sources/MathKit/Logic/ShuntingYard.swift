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
    func postfixNotation(from expression: String, _ completion: TokenizedResult)
}

open class ShuntingYard: InfixNotationConverting {
    
    private let tokenizer: Tokenizing
    
    public init() {
        self.tokenizer = Tokenizer()
    }
    
    // MARK: - InfixNotationConverting
    
    public func postfixNotation(from expression: TokenizedExpression, _ completion: TokenizedResult) {
        let postfixNotation = TokenizedExpression()
        let stack = Stack<Token>()
        
        while let token = expression.nextObject() {
            switch token.type {
            case .decimal:
                postfixNotation.add(token)
            case .infix:
                processInfixOperation(
                    token,
                    expression: postfixNotation,
                    stack: stack
                )
            case .postfix:
                stack.push(token)
            }
        }
        
        while let token = stack.pop() {
            postfixNotation.add(token)
        }
        
        completion(.success(postfixNotation))
    }
    
    public func postfixNotation(from expression: String, _ completion: TokenizedResult) {
        tokenizer.tokenize(expression) { result in
            switch result {
            case .success(let expression):
                postfixNotation(from: expression, completion)
            case .fail:
                completion(.fail(.unknown))
            }
        }
    }
    
    // MARK: - Private
    
    private func processInfixOperation(
        _ token: Token,
        expression: TokenizedExpression,
        stack: Stack<Token>
    ) {
        guard case .infix(let action) = token.type else {
            preconditionFailure()
        }
        
        if stack.count > 0 {
            var topToken = stack.pop()

            while case .infix(let otherAction) = topToken?.type,
                  otherAction.priority >= action.priority {
                expression.add(topToken!)
                topToken = stack.pop()
            }
            
            if let topToken = topToken {
                stack.push(topToken)
            }
        }
        
        stack.push(token)
    }
}
