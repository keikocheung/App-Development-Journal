import Foundation

// Property Wrapper to validate property price (ensure price is not negative)
@propertyWrapper
struct ValidatePrice {
    private var value: Double

    var wrappedValue: Double {
        get { value }
        set { value = max(newValue, 0) } // Ensure price is not negative
    }

    init(wrappedValue: Double) {
        self.value = max(wrappedValue, 0)
    }
}

// Structure representing a Property
struct Property {
    var address: String
    var size: Int // in square feet
    var propertyType: String // Example: "House", "Apartment"
    
    @ValidatePrice var price: Double

    func propertyDetails() -> String {
        return "\(propertyType) at \(address), \(size) sqft: $\(price)"
    }
}

// Base class for a Person
class Person {
    var name: String
    var contactNumber: String

    init(name: String, contactNumber: String) {
        self.name = name
        self.contactNumber = contactNumber
    }

    func contactInfo() -> String {
        return "Name: \(name), Contact: \(contactNumber)"
    }
}

// Subclass for a Buyer
class Buyer: Person {
    var purchasedProperties: [Property] = []

    func purchaseProperty(property: Property) {
        purchasedProperties.append(property)
    }

    func listPurchasedProperties() -> String {
        return purchasedProperties.map { $0.propertyDetails() }.joined(separator: "\n")
    }
}

// Subclass for a Real Estate Agent
class Agent: Person {
    var agentID: String
    var listedProperties: [Property] = []

    init(name: String, contactNumber: String, agentID: String) {
        self.agentID = agentID
        super.init(name: name, contactNumber: contactNumber)
    }

    func listProperty(property: Property) {
        listedProperties.append(property)
    }

    func showListedProperties() -> String {
        return listedProperties.isEmpty ? "No properties listed yet." :
            listedProperties.map { $0.propertyDetails() }.joined(separator: "\n")
    }

    override func contactInfo() -> String {
        return super.contactInfo() + ", Agent ID: \(agentID)"
    }
}

// Execution: Creating instances and testing
let property1 = Property(address: "123 Main St", size: 1500, propertyType: "House", price: 250000)
let property2 = Property(address: "456 Oak Ave", size: 900, propertyType: "Apartment", price: 180000)

let buyer = Buyer(name: "Alice Johnson", contactNumber: "555-1234")
let agent = Agent(name: "Bob Smith", contactNumber: "555-5678", agentID: "A789")

agent.listProperty(property: property1)
agent.listProperty(property: property2)

print("Agent Information:")
print(agent.contactInfo())

print("\nListed Properties:")
print(agent.showListedProperties())

buyer.purchaseProperty(property: property1)

print("\nBuyer Information:")
print(buyer.contactInfo())

print("\nPurchased Properties:")
print(buyer.listPurchasedProperties())
