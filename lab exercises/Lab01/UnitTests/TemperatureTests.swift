import XCTest

@testable import Lab01

//func convert(toCelsius: Double) -> Double {
//    // do something clever.
//    return 0.0
//}


class TemperatureTests: XCTestCase {
    
    func testHelloWorld() {
        print("Hello World!")
        let s = String(format: "Temperature is %.1f°", convert(toCelsius:32.0))
        print(s)
    }
    
    func testGoodbyeWorld() {
        print("Goodbye World!")
    }
}
