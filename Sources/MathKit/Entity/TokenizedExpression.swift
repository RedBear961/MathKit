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

public class TokenizedExpression: Equatable {
    
    public private(set) var tokensArray: [Token] = []
    public private(set) var currentIndex: Int = 0
    
    @inlinable public var count: Int {
        return tokensArray.count
    }
    
    @inlinable public var last: Token? {
        return tokensArray.last
    }
    
    public func add(_ token: Token) {
        tokensArray.append(token)
    }
    
    public func nextObject() -> Token? {
        if currentIndex == count {
            currentIndex = 0
            return nil
        }
        
        let token = tokensArray[currentIndex]
        currentIndex += 1
        return token
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: TokenizedExpression, rhs: TokenizedExpression) -> Bool {
        return lhs.tokensArray == rhs.tokensArray
    }
}

public extension TokenizedExpression {
    
    convenience init(with tokens: [Token]) {
        self.init()
        self.tokensArray = tokens
    }
}

extension TokenizedExpression: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        var description = ""
        tokensArray.forEach { token in
            description.append(token.debugDescription)
            description.append(" ")
        }
        return description
    }
}
