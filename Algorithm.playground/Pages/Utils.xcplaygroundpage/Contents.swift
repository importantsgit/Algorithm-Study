//: [Previous](@previous)

import Foundation

public func progressTime(_ measureProcess: () -> Void) -> TimeInterval {
    let start = CFAbsoluteTimeGetCurrent()
    print("start Measure")
    measureProcess()
    let duration = CFAbsoluteTimeGetCurrent() - start
    print("end Measure")
    return duration
}

//: [Next](@next)
