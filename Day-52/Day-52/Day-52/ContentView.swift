//
//  ContentView.swift
//  Day-52
//
//  Created by Ranjit on 30/09/20.
//

import SwiftUI

//Day-52
//Challenge Project

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                //Section - 1
                Section {
                    Picker("Select your cup cake", selection: $order.order.type) {
                        ForEach(0..<Order.info.types.count) {
                            Text(Order.info.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.order.quantity)")
                    }
                }
                
                //Section - 2
                Section {
                    Toggle(isOn: $order.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.order.specialRequestEnabled {
                        Toggle(isOn: $order.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.order.addSprinkles) {
                            Text("Add extr sprinkles")
                        }
                    }
                }
                
                //Section - 3
                Section {
                    NavigationLink(
                        destination: AddressView(order: order)) {
                            Text("Delivery Address")
                        }
                }
            }
            
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
