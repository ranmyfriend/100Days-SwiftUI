//
//  ContentView.swift
//  Day-51
//
//  Created by Ranjit on 29/09/20.
//

import SwiftUI

//Day-51
//Day-50 continues here
//`Here i have enabled networking call on PlaceOrder button function`
//Here CupCake Corner App continues
//Taking basic order details

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                //Section - 1
                Section {
                    Picker("Select your cup cake", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                //Section - 2
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
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
