import Foundation
import Darwin

class TemperaturConverter: ConverterProtocol {

    private(set) var celcius: Double = 0
    
    private(set) var farenheit: Double = -32
    
    var max: Double?
    var min: Double?
    private var precision: Int
    
    init(max: Double? = nil, min: Double? = nil, precision: Int = 3) {
        self.max = max
        self.min = min
        self.precision = precision
    }
    
    @discardableResult func convertTo(value: Double) -> Double {
        celcius = value
        var multiplier: Double = 10.0
        for _ in 0..<precision {
            multiplier = multiplier * 10.0
        }
        farenheit = round((value * (9/5) + 32) * multiplier) / multiplier
        checkValue()
        return farenheit
    }
    
    private func checkValue(){
        guard let maxCelciusValue = max,
              let minCelciusValue = min else { return }
        
        if celcius > maxCelciusValue {
            celcius = maxCelciusValue
            convertTo(value: celcius)
        } else if celcius < minCelciusValue {
            celcius = minCelciusValue
            convertTo(value: celcius)
        }
    }
    
    func convertFrom(value: Double) -> Double {
        var multiplier: Double = 10.0
        for _ in 0..<precision {
            multiplier = multiplier * 10.0
        }
        celcius = round((value - 32) * (5/9) * multiplier) / multiplier
        checkValue()
        return celcius
    }
}
