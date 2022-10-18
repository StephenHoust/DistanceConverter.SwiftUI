//
//  ContentView.swift
//  DistanceConversion
//
//  Created by Stephen Houst on 10/17/22.
//

import SwiftUI

struct ContentView: View {
    enum unitTypeSystem: String, CaseIterable, Identifiable {
        case imperial   = "Imperial (US)"
        case metric     = "Metric (World)"
        
        var id: unitTypeSystem { self }
    }
    
    enum units: String, CaseIterable, Identifiable {
        case inches
        case feet
        case yards
        case miles
        case millimeters
        case centimeters
        case meters
        case kilometers
        
        var id: units { self }
        static let metric: [units] = [.millimeters, .centimeters, .meters, .kilometers]
        static let imperial: [units] = [.inches, .feet, .yards, .miles]
    }
    
    @State var inputUnitSystem = unitTypeSystem.imperial
    @State var outputUnitSystem = unitTypeSystem.imperial
    @State var inputUnits = units.inches
    @State var outputUnits = units.inches
    @State var inputNumber = 0.0
    
    var result: Double {
        if inputUnits == outputUnits {
            return inputNumber
        }
        
        let distanceInMillimeters = convertToMillimeters(from: inputUnits)
        print(distanceInMillimeters)
        var result = convertFromMillimeters(toUnit: outputUnits, millimeters: distanceInMillimeters)
        
        return result
    }
    
    func convertToMillimeters(from originalUnits: units) -> Double {
        switch originalUnits {
        case .inches:
            return inputNumber * 25.4
        case .feet:
            return inputNumber * 12 * 25.4
        case .yards:
            return inputNumber * 36 * 25.4
        case .miles:
            return inputNumber * 63360 * 25.4
        case .millimeters:
            return inputNumber
        case .centimeters:
            return inputNumber * 10
        case .meters:
            return inputNumber * 1000
        case .kilometers:
            return inputNumber * 1000000
        }
    }
    
    func convertFromMillimeters(toUnit: units, millimeters: Double) -> Double {
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
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.minimumIntegerDigits = 1
        return formatter
    }
    
    func filterUnitsFor(unitSystem: unitTypeSystem) -> [units] {
        switch unitSystem {
        case .imperial: return units.imperial
        case .metric: return units.metric
        }
    }
    
    var body: some View {
        NavigationView() {
            Form {
                Section("Input Units") {
                    Picker("Measurement System", selection: $inputUnitSystem) {
                        ForEach(unitTypeSystem.allCases, id: \.self) { unitType in
                            Text(unitType.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: inputUnitSystem) { newValue in
                        if newValue == .imperial {
                            inputUnits = .inches
                        } else {
                            inputUnits = .millimeters
                        }
                    }
                    
                    Picker("Units", selection: $inputUnits) {
                        ForEach(filterUnitsFor(unitSystem: inputUnitSystem), id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    
                    TextField("Amount", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("Output Units") {
                    Picker("Measurement System", selection: $outputUnitSystem) {
                        ForEach(unitTypeSystem.allCases, id: \.self) { unitType in
                            Text(unitType.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: outputUnitSystem) { newValue in
                        if newValue == .imperial {
                            outputUnits = .inches
                        } else {
                            outputUnits = .millimeters
                        }
                    }
                    
                    Picker("Units", selection: $outputUnits) {
                        ForEach(filterUnitsFor(unitSystem: outputUnitSystem), id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                }
                
                Section("Results") {
                    Text("""
                            \(formatter.string(from: inputNumber as NSNumber)!) \(inputUnits.rawValue)\n
                            converts into\n
                            \(formatter.string(from: result as NSNumber)!) \(outputUnits.rawValue)
                            """)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                }
                
            }
            .navigationTitle("Distance Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
