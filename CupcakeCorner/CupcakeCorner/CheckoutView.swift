//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by David Evans on 22/4/2022.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    @State private var showingOrderFailed = false

    
    var body: some View {
        
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233) // reserve space for the image and then it wont snap in
                .accessibilityHidden(true)

                Text("Your total is \(order.orderDetails.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        do {
                            try await placeOrder()
                        } catch {
                            confirmationMessage = "Your order for \(order.orderDetails.quantity)x \(Order.types[order.orderDetails.type].lowercased()) failed!  \(error.localizedDescription)"
                            showingOrderFailed = true
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Order Failed!", isPresented: $showingOrderFailed) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }

    }
    
    func placeOrder() async throws {
        
        guard let encoded = try? JSONEncoder().encode(order.orderDetails) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            let decodedOrder = try JSONDecoder().decode(OrderDetails.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch {
            print("Checkout failed.")
            
            //
            /// SHOULD HAVE DONE ALL THE WORK HERE!!!!! Not passed on the error !!!!
            //
            throw error
        }
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
