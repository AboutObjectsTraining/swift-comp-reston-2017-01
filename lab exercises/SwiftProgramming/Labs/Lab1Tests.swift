// Copyright (C) 2015 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest

let fahrenheitValues: [Double] = [-10, 0, 10, 32, 72, 100]

func convertedToCelsius(fahrenheit: Double) -> Double
{
    return (fahrenheit - 32) * (5/9)
}

class Lab1Tests: XCTestCase
{
    func testConvertFahrenheitToCelsiusUsingForLoop()
    {
        for fahrenheit in fahrenheitValues
        {
            let celsius = convertedToCelsius(fahrenheit: fahrenheit)
            
            let formattedValue = String(format: "%.1f", celsius)
            print("\(fahrenheit)°F equals \(formattedValue)°C")
        }
    }
}


struct FahrenheitTemperature {
    let degrees: Double
    
    var celsius: Double {
        return  (degrees - 32) * (5/9)
    }
}

enum TemperatureScale {
    case kelvin
    case celsius
    case fahrenheit
}

struct Temperature {
    let degrees: Double
    let scale: TemperatureScale
    
    var celsius: Double {
        return  (degrees - 32) * (5/9)
    }
    
    init(degrees: Double, scale: TemperatureScale = .fahrenheit) {
        self.degrees = degrees
        self.scale = scale
    }
}

@objc protocol Foo {
    @objc optional func bar()
    func baz()
}

extension Lab1Tests
{
    func testConvertToCelsius()
    {
        let fahrenheit = FahrenheitTemperature(degrees: 32.0)
        print(fahrenheit.degrees)
        print(fahrenheit.celsius)
    }
    
    
//    func testStructs() {
//        let foo = FahrenheitTemperature(degrees: 32)
//        let temp = Temperature(degrees: 12, scale: .kelvin)
//        let temp2 = Temperature(degrees: 90)
//    }
    
    func testFoo()
    {
//        let a: [Any] = ["apple", "banana", 12]
//        print(a)
        
        let calculatedVal = calculateDiscount(originalPrice: 12.99, percentage: 0.5)
        print(calculatedVal)
        print(calculatedVal.discount)
        
        let (foo, _) = calculateDiscount(originalPrice: 12.99, percentage: 0.5)
        print(foo)
    }
    
    
    typealias Dude = (name: String, age: Int)
    
    func testTuples() {
        
        let foo = ("Fred", 32)
        print(foo.0)
        
        let dude = foo as Dude
        print(dude.age)
        
        let otherDude: Dude = foo
        print(otherDude.name)
        
        let (dudesName, dudesAge) = foo
        print(dudesAge)
        print(dudesName)
    }
}

func calculateDiscount(originalPrice: Double, percentage: Double)
    -> (price: Double, discount: Double) {
        let amount = originalPrice * percentage
        let price = originalPrice - amount
        return (price, amount)
}






//
//    func testConvertFahrenheitToCelsiusUsingMap()
//    {
//        let celsiusValues = fahrenheitValues.map { convertedToCelsius($0) }
//        print(celsiusValues)
//        
//        let formattedValues = celsiusValues.map { String(format: "%.1f", $0) }
//        print(formattedValues)
//    }
//    
//    let format = "\n%5.1f°F equals %5.1f°C "
//
//    func testConvertFahrenheitToCelsiusUsingMapReduce1()
//    {
//        let formattedValues = fahrenheitValues.map {
//            String(format: format, $0, convertedToCelsius($0))
//        }
//        let text = formattedValues.reduce("") { $0 + $1 }
//        print(text)
//    }
//
//    
//    func testConvertFahrenheitToCelsiusUsingMapReduce2()
//    {
//        print(fahrenheitValues
//            .map { String(format: format, $0, convertedToCelsius($0)) }
//            .reduce("") { $0 + $1 })
//    }
//    
//    func testConvertFahrenheitToCelsiusUsingTuples()
//    {
//        let tuples = fahrenheitValues.map { return (F: $0, C: convertedToCelsius($0)) }
//        
//        let text = tuples.reduce("") {
//            $0 + String(format: format, $1.F, $1.C)
//        }
//        print(text)
//    }
//}


