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

public protocol Action: Equatable {
    
    var stringValue: String { get }
}

public extension Action {

    static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }
}

internal class Resolver<T: Action> {
    
    private var container: [T] = []
    
    internal init(_ container: [T]) {
        self.container = container
    }
    
    internal func operation(from stringValue: String) -> T? {
        return container.first { $0.stringValue == stringValue }
    }
}

public class Container {
    
    static var infix: Resolver<InfixAction> = {
        Resolver([
            .infix("+", .low) { $0 + $1 },
            .infix("-", .low) { $0 - $1 },
            .infix("*", .medium) { $0 * $1 },
            .infix("/", .medium) { $0 / $1 },
            .infix("^", .high) { $0.raising(toPower: $1) }
        ])
    }()
    
    static var postfix: Resolver<PostfixAction> = {
        Resolver([
            .postfix("!") { ($0 + 1).gamma() }
        ])
    }()
    
    static func infix(from signature: String) -> InfixAction? {
        return infix.operation(from: signature)
    }
    
    static func postfix(from signature: String) -> PostfixAction? {
        return postfix.operation(from: signature)
    }
}
