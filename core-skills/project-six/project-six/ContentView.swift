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
    
    static var default_wake_time: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var alert_title = ""
    @State private var alert_message = ""
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When you want to wake up ?")
                        .font(.system(size: 22, weight: .heavy))
                    DatePicker("Add Your Time", selection: $wake_up, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding(.top, 10)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep ?")
                        .font(.system(size: 22, weight: .heavy))
                    Stepper(sleep_amount == 1 ? "\(sleep_amount.formatted()) hour" : "\(sleep_amount.formatted()) hours", value: $sleep_amount, in: 1...12, step: 0.25)
                        .padding(.top, 10)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily amount of coffee ?")
                        .font(.system(size: 22, weight: .heavy))
                    Stepper(coffee_amount == 1 ? "\(coffee_amount) cup" : "\(coffee_amount) cups", value: $coffee_amount, in: 1...30, step: 1)
                        .padding(.top, 10)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculate_bedtime)
            }
            .alert(alert_title, isPresented: $showingAlert) {
                Button("Ok") {}
            } message: {
                Text(alert_message)
            }
        }
    }
    func calculate_bedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wake_up)
            let hour = (components.hour ?? 0) * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleep_amount, coffee: Double(coffee_amount))
            let sleep_time = wake_up - prediction.actualSleep
            
            alert_title = "Bedtime Status"
            alert_message = sleep_time.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alert_title = "Error"
            alert_message = "Error Occured While Calculating"
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
