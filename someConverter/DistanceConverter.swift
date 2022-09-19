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
    
    @discardableResult func convertTo(value: Double) -> Double {
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
        guard let maxKilometers = max,
              let minKilometers = min else { return }
        
        if kilometers > maxKilometers {
            kilometers = maxKilometers
            convertTo(value: kilometers)
        } else if kilometers < minKilometers {
            kilometers = minKilometers
            convertTo(value: kilometers)
        }
 
    }
    
    @discardableResult func convertFrom(value: Double) -> Double {
        milies = value
        var multiplier: Double = 10.0
        for _ in 0..<precision {
            multiplier = multiplier * 10.0
        }
        kilometers = (milies * 1.60934 * multiplier).rounded() / multiplier
        checkValue()
        return kilometers
    }
}
