import Foundation

protocol ConverterProtocol {
    func convertTo(value: Double) -> Double
    func convertFrom(value:Double) -> Double
    var min: Double? { get set }
    var max: Double? { get set }
}
