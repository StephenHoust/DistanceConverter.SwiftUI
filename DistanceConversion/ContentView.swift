//
//  ContentView.swift
//  DistanceConversion
//
//  Created by Stephen Houst on 10/17/22.
//

import SwiftUI

struct ContentView: View {
    @State var inputMeasurementSystem = measurementSystem.imperial
    @State var outputMeasurementSystem = measurementSystem.imperial
    @State var inputUnits = distanceUnits.inches
    @State var outputUnits = distanceUnits.inches
    @State var inputDistance = 0.0
    
    var result: Double {
        if inputUnits == outputUnits {
            return inputDistance
        }
        
        let distanceInMillimeters = convertToMillimeters(from: inputUnits, distance: inputDistance)
        return convertFromMillimeters(toUnit: outputUnits, millimeters: distanceInMillimeters)
    }
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.minimumIntegerDigits = 1
        return formatter
    }
    
    func filterUnitsFor(unitSystem: measurementSystem) -> [distanceUnits] {
        switch unitSystem {
        case .imperial: return distanceUnits.imperial
        case .metric: return distanceUnits.metric
        }
    }
    
    var body: some View {
        NavigationView() {
            Form {
                Section("Input Units") {
                    Picker("Measurement System", selection: $inputMeasurementSystem) {
                        ForEach(measurementSystem.allCases, id: \.self) { unitType in
                            Text(unitType.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: inputMeasurementSystem) { newValue in
                        if newValue == .imperial {
                            inputUnits = .inches
                        } else {
                            inputUnits = .millimeters
                        }
                    }
                    
                    Picker("Units", selection: $inputUnits) {
                        ForEach(filterUnitsFor(unitSystem: inputMeasurementSystem), id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    
                    TextField("Amount", value: $inputDistance, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("Output Units") {
                    Picker("Measurement System", selection: $outputMeasurementSystem) {
                        ForEach(measurementSystem.allCases, id: \.self) { unitType in
                            Text(unitType.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: outputMeasurementSystem) { newValue in
                        if newValue == .imperial {
                            outputUnits = .inches
                        } else {
                            outputUnits = .millimeters
                        }
                    }
                    
                    Picker("Units", selection: $outputUnits) {
                        ForEach(filterUnitsFor(unitSystem: outputMeasurementSystem), id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                }
                
                Section("Results") {
                    Text("""
                            \(formatter.string(from: inputDistance as NSNumber)!) \(inputUnits.rawValue)\n
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
