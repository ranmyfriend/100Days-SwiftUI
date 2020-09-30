//
//  AddressView.swift
//  Day-50
//
//  Created by Ranjit on 28/09/20.
//

import SwiftUI

//Checking for a valid address

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                    .border(order.order.name.isEmptyField ? Color.red : Color.clear, width: 1)
                
                TextField("Street Address", text: $order.order.streetAddress)
                    .border(order.order.streetAddress.isEmptyField ? Color.red : Color.clear, width: 1)

                TextField("City", text: $order.order.city)
                    .border(order.order.city.isEmptyField ? Color.red : Color.clear, width: 1)

                TextField("Zip", text: $order.order.zip)
                    .border(order.order.zip.isEmptyField ? Color.red : Color.clear, width: 1)
            }
            
            Section {
                NavigationLink(
                    destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            
            .disabled(order.order.hasValidAddress == false)
        }
        .navigationBarTitle("Display details", displayMode: .inline)
    }
    
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

extension StringProtocol where Index == String.Index {
    var isEmptyField: Bool {
        return trimmingCharacters(in: .whitespaces) == ""
    }
}

