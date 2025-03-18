import SwiftUI

// Enum to define different color names
enum ColorName: String, CaseIterable, Identifiable {
    case red = "Red"
    case green = "Green"
    case blue = "Blue"
    case yellow = "Yellow"
    case purple = "Purple"
    case none = "Select a Color"
    
    var id: String { self.rawValue } // Unique identifier for each case
}


// Main entry view for the app
struct ContentView: View {
    var body: some View {
        NavigationStack {
            ColorPickerView()
        }
    }
}

// View to handle user selection for Color Picker
struct ColorPickerView: View {
    
    // State variable to track the selected color
    @State private var selectedColor: ColorName = .none
    
    // View body to build the UI
    var body: some View {
        VStack {
            // Color selection using a Picker
            Picker("Select Color", selection: $selectedColor) {
                ForEach(ColorName.allCases) { color in
                    Text(color.rawValue).tag(color)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
            
            // Display the selected color as the background
            Rectangle()
                .fill(backgroundColor(for: selectedColor))
                .frame(height: 200)
                .cornerRadius(10)
                .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Color Picker")
    }
    
    // Function to return the background color based on selected color
    func backgroundColor(for color: ColorName) -> Color {
        switch color {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        default:
            return .gray
        }
    }
}

// Preview for UI testing
#Preview {
    ColorPickerView()
}
