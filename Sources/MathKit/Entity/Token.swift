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

public struct Token: Equatable {
    
    let stringValue: String
    let constant: Double?
    let type: TokenType
    
    enum TokenType {
        
        case decimal
        case infix
        
        case unknown
    }
    
    init(stringValue: String, constant: Double? = nil, type: TokenType) {
        self.stringValue = stringValue
        self.constant = constant
        self.type = type
    }
    
    init(constant: Double) {
        self.init(stringValue: "\(constant, format: "%g")", constant: constant, type: .decimal)
    }
}

extension String.StringInterpolation {
    
    mutating func appendInterpolation(_ value: CVarArg, format: String) {
        appendLiteral(String(format: format, value))
    }
}
