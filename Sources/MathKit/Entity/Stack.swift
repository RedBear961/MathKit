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

public class Stack<Element> {
    
    public private(set) var objects: [Element] = []
    
    public var count: Int {
        return objects.count
    }
    
    public var isEmpty: Bool {
        return objects.isEmpty
    }
    
    public func push(_ element: Element) {
        objects.append(element)
    }
    
    public func pop() -> Element? {
        return objects.popLast()
    }
    
    public func pop(count: Int) -> [Element]? {
        guard objects.count >= count else { return nil }
        
        let range = objects.count - count..<objects.count
        let values = objects[range]
        objects.removeSubrange(range)
        
        return Array(values)
    }
}

extension Stack: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        var description = ""
        objects.forEach { element in
            description.append("\(element) ")
        }
        return description
    }
}
