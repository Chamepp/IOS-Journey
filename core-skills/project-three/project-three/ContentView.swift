//
//  ContentView.swift
//  project-three
//
//  Created by Ashkan Ebtekari on 7/26/22.
//

import SwiftUI


struct ContentView: View {
    
    // Measurements Data
    @State private var user_data = 0.0
    @State private var input_selected_measure = "Kilometer"
    @State private var output_selected_measure = "Kilometer"
    
    // Measurment Collection
    private let measures = ["Kilometer", "Meter", "Foot", "Mile"]
    
    // Decimal Keyboard Focus
    @FocusState private var keyboardIsFocused: Bool
    
    // Calculate Conversion
    var final_conversion: Double {
        switch(input_selected_measure, output_selected_measure) {
        // Kilometer Input
        case ("Kilometer", "Kilometer"):
            return user_data
        case ("Kilometer", "Meter"):
            return user_data * 1000
        case ("Kilometer", "Foot"):
            return user_data * 3281
        case ("Kilometer", "Mile"):
            return user_data / 1.609
            
        // Meter Input
        case ("Meter", "Meter"):
            return user_data
        case ("Meter", "Kilometer"):
            return user_data / 1000
        case ("Meter", "Foot"):
            return user_data * 3.281
        case ("Meter", "Mile"):
            return user_data / 1609
            
        // Foot Input
        case ("Foot", "Foot"):
            return user_data
        case ("Foot", "Kilometer"):
            return user_data / 3281
        case ("Foot", "Meter"):
            return user_data / 3.281
        case ("Foot", "Mile"):
            return user_data / 5280
            
        // Mile Input
        case ("Mile", "Mile"):
            return user_data
        case ("Mile", "Kilometer"):
            return user_data * 1.609
        case ("Mile", "Meter"):
            return user_data * 1609
        case ("Mile", "Foot"):
            return user_data * 5280
            
        default:
            return user_data
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                // User Data
                Section {
                    Group {
                        TextField("Enter your data", value: $user_data, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($keyboardIsFocused)
                            .padding()
                            .font(.system(size: 30))
                    }
                } header: {
                    Text("Enter Your Data")
                }
                // Input Conversion Units
                Section {
                    Group {
                        Picker("Select Unit", selection: $input_selected_measure) {
                            ForEach(measures, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("Select Your Input Unit")
                }
                // Output Conversion Units
                Section {
                    Group {
                        Picker("Select Unit", selection: $output_selected_measure) {
                            ForEach(measures, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("Select Your Output Unit")
                }
                // Final Conversion
                Section {
                    Group {
                        Text("-   \(final_conversion.formatted())   -")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 25))
                    }
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Convert Tool")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        keyboardIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
