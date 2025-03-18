import SwiftUI

// Enum to define different car types (like game types in Tic Tac Toe)
enum CarType: String, CaseIterable, Identifiable {
    case sedan = "Sedan"
    case suv = "SUV"
    case truck = "Truck"
    case convertible = "Convertible"
    case none = "Select a Car Type"
    
    var id: String { self.rawValue } // Unique identifier for each case
}

// Enum for purchase options (just like picking game mode)
enum PurchaseOption: String, CaseIterable, Identifiable {
    case finance = "Finance"
    case lease = "Lease"
    case cash = "Pay in Full"
    case none = "Select a Purchase Option"
    
    var id: String { self.rawValue }
}

// Main entry view for the app
struct ContentView: View {
    var body: some View {
        NavigationStack {
            CarSelectionView()
        }
    }
}

// View to handle user selection for CarMax
struct CarSelectionView: View {
    
    // State variables to track the selected car type and purchase option
    @State private var selectedCar: CarType = .none
    @State private var purchaseOption: PurchaseOption = .none
    @State private var customerName = "" // User inputs their name
    @State private var proceedToCheckout = false // Controls navigation to checkout screen
    
    @FocusState private var focus: Bool // Handles keyboard focus
    
    var body: some View {
        VStack {
            // Car type selection using a Picker (like game mode selection)
            Picker("Choose Your Car", selection: $selectedCar) {
                ForEach(CarType.allCases) { car in
                    Text(car.rawValue).tag(car)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10))
            
            // Purchase option selection
            Picker("Select Payment Method", selection: $purchaseOption) {
                ForEach(PurchaseOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10))
            
            // Text field for user to enter their name
            TextField("Enter Your Name", text: $customerName)
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width: 350)
            
            // Button to proceed to checkout (like Start Game in Tic Tac Toe)
            Button("Proceed to Checkout") {
                focus = false // Hide kKEIKOeyboard
                proceedToCheckout.toggle() // Trigger navigation
            }
            .buttonStyle(.borderedProminent)
            .disabled(selectedCar == .none || purchaseOption == .none || customerName.isEmpty) // Disable if inputs aren't valid
            
            Spacer()
        }
        .padding()
        .navigationTitle("CarMax Selection")
        .fullScreenCover(isPresented: $proceedToCheckout) {
            CheckoutView(car: selectedCar, option: purchaseOption, name: customerName)
        }
    }
}

// Checkout view to display user selections
struct CheckoutView: View {
    var car: CarType
    var option: PurchaseOption
    var name: String
    
    var body: some View {
        VStack {
            Text("Order Summary")
                .font(.largeTitle)
                .padding()
            
            Text("Customer: \(name)")
            Text("Selected Car: \(car.rawValue)")
            Text("Payment Method: \(option.rawValue)")
            
            Button("Confirm Purchase") {
                // Normally, we’d process the order here
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

// Preview for UI testing
#Preview {
    CarSelectionView()
}
