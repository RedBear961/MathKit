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

public typealias CalculationResult = (Result<Double>) -> Void

open class Calculator {
    
    private let converter: InfixNotationConverting
    
    public init(tokenizer: Tokenizing = Tokenizer()) {
        self.converter = RailYard(tokenizer: tokenizer)
    }
    
    // MARK: - Public
    
    public func calculate(_ expression: String, _ completion: @escaping CalculationResult) {
        converter.reversePolishNotation(from: expression) { result in
            switch result {
            case .success(let expression):
                calculate(expression, completion)
            case .fail(let fail):
                completion(.fail(fail))
            }
        }
    }
    
    public func calculate(_ expression: TokenizedExpression, _ completion: @escaping CalculationResult) {
        
    }
}
