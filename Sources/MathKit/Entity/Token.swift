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

public enum Token: Equatable {
    
    public enum Bracket: String, RawRepresentable {
        
        case open = "("
        
        case close = ")"
    }
    
    case decimal(NSDecimalNumber)
    
    case infix(InfixAction)
    
    case postfix(PostfixAction)
    
    case bracket(Bracket)
}

extension Token: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .decimal(let decimal):     return "\(decimal, format: "%g")"
        case .infix(let action):        return "\(action.stringValue)"
        case .postfix(let action):      return "\(action.stringValue)"
        case .bracket(let bracket):     return "\(bracket.rawValue)"
        }
    }
}

//public struct Token: Equatable {
//    
//    public let stringValue: String
//    
//    public let type: TokenType
//    
//    public enum TokenType: Equatable {
//        
//        public enum Bracket {
//            case open
//            case close
//        }
//        
//        case decimal(NSDecimalNumber)
//        
//        case infix(InfixAction)
//        
//        case postfix(PostfixAction)
//        
//        case bracket(Bracket)
//    }
//    
//    public init(stringValue: String, type: TokenType) {
//        self.stringValue = stringValue
//        self.type = type
//    }
//    
//    public init(constant: NSDecimalNumber) {
//        self.init(stringValue: "\(constant.doubleValue, format: "%g")", type: .decimal(constant))
//    }
//}
