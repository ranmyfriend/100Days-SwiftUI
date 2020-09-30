//
//  CheckoutView.swift
//  Day-50
//
//  Created by Ranjit on 28/09/20.
//

import SwiftUI

//Preparing for checkout

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationTitle = ""
    @State private var confirmationMsg = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }.padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMsg), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            return print("failed to encode")
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.confirmationTitle = "Error"
                self.confirmationMsg = error.localizedDescription
                self.showingConfirmation = true
                return
            }
            guard let data = data else {
                return print("No data in response: \(error?.localizedDescription ?? "Unknown error.")")
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.info.self, from: data) {
                self.confirmationTitle = "Thank you!"
                self.confirmationMsg = "Your order for \(decodedOrder.quantity)x \(Order.info.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
