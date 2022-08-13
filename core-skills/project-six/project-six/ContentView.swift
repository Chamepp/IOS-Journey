//
//  ContentView.swift
//  project-six
//
//  Created by Ashkan Ebtekari on 8/5/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wake_up = default_wake_time
    @State private var sleep_amount = 1.0
    @State private var coffee_amount = 1
    
    @State private var coffee_selected_amount = 1
    @State private var coffee_cups = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    static var default_wake_time: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("When you want to wake up") {
                        DatePicker("Add Your Time", selection: $wake_up, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Section("Desired amount of sleep") {
                        Stepper(sleep_amount == 1 ? "\(sleep_amount.formatted()) hour" : "\(sleep_amount.formatted()) hours", value: $sleep_amount, in: 1...12, step: 0.25)
                    }
                    Section("Daily amount of coffee") {
                        Picker("Select Smount of Coffee", selection: $coffee_selected_amount) {
                            ForEach(1...30, id: \.self) {
                                Text("\($0) \($0 == 1 ? "cup" : "cups")")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    Section {
                        Text("\(calculate_bedtime)")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding()
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    var calculate_bedtime: String {
        var result: String
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wake_up)
            let hour = (components.hour ?? 0) * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleep_amount, coffee: Double(coffee_selected_amount))
            let sleep_time = wake_up - prediction.actualSleep

            result = sleep_time.formatted(date: .omitted, time: .shortened)
        } catch {
            result = "Error Occured While Calculating"
        }
        
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
