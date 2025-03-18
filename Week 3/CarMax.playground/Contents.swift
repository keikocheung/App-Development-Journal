import Foundation

// Struct Car model with most important attributes
struct Car {
    let name: String
    let horsepower: Int
    let fuelEfficiency: Double
    let price: Double
    let type: String  // e.g., "Sports", "SUV", "Sedan"
}

// User preferences for scoring
struct UserPreferences {
    let preferredCarModel: Bool //sports, suv, etc.
    let caresAboutFuelEfficiency: Bool
    let isBudgetConscious: Bool
}

// Function to compute a score based on user preferences
func calculateCarScore(car: Car, preferences: UserPreferences) -> Double {
    var score = 0.0
    
    // Higher score for sports cars if the user prefers them
    if preferences.preferredCarModel {
        //if they prefer sports car then add 50 points, if not dont add any points
        score += (car.type == "Sports") ? 50 : 0
    }
    
    // Higher score for fuel-efficient cars if the user cares about it
    if preferences.caresAboutFuelEfficiency {
        //if they prefer fuel efficiency then add 2 times their desired fuel efficiecy, if not dont add any points
        score += car.fuelEfficiency * 2
    }
    
    // Higher score for cheaper cars if the user is budget-conscious
    if preferences.isBudgetConscious {
        //we have a basic target price to simplify things ($50000), if it is greater than 0 meaning it is cheaper than $50000, we divide by 1000 and assign points to car!
        score += max(0, (50_000 - car.price) / 1000)  // More points for cheaper cars
    }
    
    // Horsepower always adds to score (but less than other factors), this is always a plus
    score += Double(car.horsepower) / 5
    
    return score
}

// Function to compare 3 cars
func compareCars(cars: [Car], preferences: UserPreferences) {
    // goes through each car in car array and calculates a score using map function and user preferences
    let scoredCars = cars.map { (car: Car) -> (Car, Double) in
        return (car, calculateCarScore(car: car, preferences: preferences))
    }
    
    // Sort cars based on score, accessing the second element of the array, comparing first car and second car score
    let rankedCars = scoredCars.sorted { $0.1 > $1.1 }
    
    // Print comparison
    var rank = 1
    rankedCars.forEach { (car, score) in
        print("\(rank). \(car.name) - Score: \(score)")
        rank += 1
    }
}

// TESTING | Sample Cars
let car1 = Car(name: "Porsche 911", horsepower: 443, fuelEfficiency: 20, price: 120000, type: "Sports")
let car2 = Car(name: "Honda Civic", horsepower: 158, fuelEfficiency: 35, price: 25000, type: "Sedan")
let car3 = Car(name: "Ford Mustang", horsepower: 450, fuelEfficiency: 22, price: 55000, type: "Sports")

// TESTING | Sample User Preferences
let userPreferences = UserPreferences(preferredCarModel: true, caresAboutFuelEfficiency: false, isBudgetConscious: false)

// TESTING | Compare cars
compareCars(cars: [car1, car2, car3], preferences: userPreferences)
