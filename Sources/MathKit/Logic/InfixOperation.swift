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

public typealias InfixOperationBlock = (_ rhs: Double, _ lhs: Double) -> Double

public struct InfixOperation: Action {
    
    public let stringValue: String
    
    public let formattedValue: String
    
    public let action: InfixOperationBlock
}

public extension InfixOperation {
    
    static func isOperation(_ signature: String) -> Bool {
        return InfixOperationContainer.shared.isOperation(signature)
    }
}

extension InfixOperation {
    
    init(_ stringValue: String, _ formattedValue: String, _ action: @escaping InfixOperationBlock) {
        self.stringValue = stringValue
        self.formattedValue = formattedValue
        self.action = action
    }
}

final class InfixOperationContainer: OperationContainer {
    
    public static var shared: InfixOperationContainer = InfixOperationContainer()
    
    public var characterSet: CharacterSet {
        var characterSet = CharacterSet()
        actions.forEach {
            characterSet.insert(charactersIn: $0.stringValue)
        }
        return characterSet
    }
    
    private var actions: [InfixOperation]
    
    private init() {
        self.actions = [
            InfixOperation("+", "+") { $0 + $1 },
            InfixOperation("-", "-") { $0 - $1 },
            InfixOperation("*", "*") { $0 * $1 },
            InfixOperation("/", "/") { $0 / $1 },
            InfixOperation("^", "") { pow($0, $1) }
        ]
    }
    
    func isOperation(_ signature: String) -> Bool {
        return actions.first(where: { $0.stringValue == signature }) != nil
    }
}