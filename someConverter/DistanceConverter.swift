import Foundation
import Darwin

class DistanceConverter: ConverterProtocol {

    private(set) var kilometers: Double = 0
    
    private(set) var milies: Double = -32
    
    var max: Double?
    var min: Double?
    private var precision: Int
    
    init(max: Double? = nil, min: Double? = nil, precision: Int = 3) {
        self.max = max
        self.min = min
        self.precision = precision
    }
    
    func convertTo(value: Double) -> Double {
        kilometers = value
        var multiplier: Double = 10.0
        for _ in 0..<precision {
            multiplier = multiplier * 10.0
        }
        milies = (kilometers / 1.60934 * multiplier).rounded() / multiplier
        checkValue()
        return milies
    }
    
    private func checkValue(){
        if  let maxCelciusValue = max, kilometers > maxCelciusValue {
            kilometers = maxCelciusValue
            convertTo(value: kilometers)
        } else if let minCelciusValue = min, kilometers < minCelciusValue {
            kilometers = minCelciusValue
            convertTo(value: kilometers)
        }
    }
    
    func convertFrom(value: Double) -> Double {
        milies = value
        var multiplier: Double = 10.0
        for _ in 0..<precision {
            multiplier = multiplier * 10.0
        }
        kilometers = (kilometers * 1.60934 * multiplier).rounded() / multiplier
        checkValue()
        return kilometers
    }
}
