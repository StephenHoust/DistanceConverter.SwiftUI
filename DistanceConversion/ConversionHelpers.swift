//
//  ConversionHelpers.swift
//  DistanceConversion
//
//  Created by Stephen Houst on 10/18/22.
//

func convertToMillimeters(from originalUnits: distanceUnits, distance: Double) -> Double {
    switch originalUnits {
    case .inches:
        return distance * 25.4
    case .feet:
        return distance * 12 * 25.4
    case .yards:
        return distance * 36 * 25.4
    case .miles:
        return distance * 63360 * 25.4
    case .millimeters:
        return distance
    case .centimeters:
        return distance * 10
    case .meters:
        return distance * 1000
    case .kilometers:
        return distance * 1000000
    }
}

func convertFromMillimeters(toUnit: distanceUnits, millimeters: Double) -> Double {
    switch toUnit {
    case .inches:
        return millimeters / 25.4
    case .feet:
        return millimeters / 12 / 25.4
    case .yards:
        return millimeters / 36 / 25.4
    case .miles:
        return millimeters / 63360 / 25.4
    case .millimeters:
        return millimeters
    case .centimeters:
        return millimeters / 10
    case .meters:
        return millimeters / 1000
    case .kilometers:
        return millimeters / 1000000
    }
}
