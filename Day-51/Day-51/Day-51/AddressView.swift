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
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink(
                    destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Display details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
