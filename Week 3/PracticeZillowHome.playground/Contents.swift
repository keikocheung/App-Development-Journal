import Foundation

// Problem: Design a data structure for a real estate app that helps users compare houses based on their preferences. Then, write a function that takes a list of houses and a user's preferences and ranks the houses based on a scoring system
// Similar to Car Max problem

struct House {
    let name : String
    let price : Double
    let squareFootage : Double
    let numberOfBedrooms : Int
    let petFriendly : Bool
    let neighborhoodRating : Int
}

struct UserPreferences {
    let budgetFriendly : Bool
    let desireSpaciousHome : Bool
    let goodNeighborhood: Bool
    let isPetFriendly : Bool
    let desiredBedrooms : Int
}

func calculateScore (house: House, preferences: UserPreferences) -> Double {
    var score = 0.0
    
    // budget friendly, if it is budget friendly add to score, if over budget deduct points
    if preferences.budgetFriendly {
        if house.price <= 300_000 {
            score += 10 // Give a fixed score for staying under budget
        } else {
            score -= 5 // Penalize if over budget
        }
    }
        
    // if they desire spacious home, the larger the square footage the greater the points
    if preferences.desireSpaciousHome {
        score += house.squareFootage / 100
    }
    
    // if they desire good neighborhood, the safer/better neighborhood the greater points
    if preferences.goodNeighborhood {
        score += Double(house.neighborhoodRating)
    }
    
    // if it is pet friendly, add a fixed amount of points
    if preferences.isPetFriendly {
        score += (house.petFriendly) ? 10 : 0
    }
    
    // if it have desired number of bedrooms add 10 points, if within 1 bedroom then add 5 points, if more than 2 bedrooms off, no points
    if preferences.desiredBedrooms == house.numberOfBedrooms {
        score += 10
    }
    else if (preferences.desiredBedrooms == house.numberOfBedrooms + 1) || (preferences.desiredBedrooms == house.numberOfBedrooms - 1) {
        score += 5
    }
    
    
    return score
}


func rankHouses(houses: [House], preferences: UserPreferences) {
    // Calculate scores and pair each house with its score
    let scoredHouses = houses.map { house in
        (house, calculateScore(house: house, preferences: preferences))
    }
    
    // Sort homes based on score, in descending order
    let rankedHomes = scoredHouses.sorted { $0.1 > $1.1 }
    
    // Print the ranked homes
    for (index, (house, score)) in rankedHomes.enumerated() {
        print("\(index + 1). \(house.name) - Score: \(score)")
    }
}


// CHAT GPT GENERATED Testing code below
// Define some sample houses
let house1 = House(name: "Cozy Cottage", price: 250_000, squareFootage: 1200, numberOfBedrooms: 3, petFriendly: true, neighborhoodRating: 8)
let house2 = House(name: "Luxury Villa", price: 450_000, squareFootage: 3500, numberOfBedrooms: 5, petFriendly: false, neighborhoodRating: 10)
let house3 = House(name: "Suburban Home", price: 300_000, squareFootage: 2200, numberOfBedrooms: 4, petFriendly: true, neighborhoodRating: 7)
let house4 = House(name: "Modern Apartment", price: 350_000, squareFootage: 1800, numberOfBedrooms: 2, petFriendly: true, neighborhoodRating: 9)
let house5 = House(name: "Old Bungalow", price: 150_000, squareFootage: 1000, numberOfBedrooms: 2, petFriendly: false, neighborhoodRating: 6)

// Define some sample user preferences
let userPreferences1 = UserPreferences(budgetFriendly: true, desireSpaciousHome: true, goodNeighborhood: true, isPetFriendly: true, desiredBedrooms: 3)
let userPreferences2 = UserPreferences(budgetFriendly: false, desireSpaciousHome: true, goodNeighborhood: true, isPetFriendly: false, desiredBedrooms: 4)
let userPreferences3 = UserPreferences(budgetFriendly: true, desireSpaciousHome: false, goodNeighborhood: true, isPetFriendly: true, desiredBedrooms: 2)

// Call the rankHouses function with the different user preferences
print("User Preferences 1:")
rankHouses(houses: [house1, house2, house3, house4, house5], preferences: userPreferences1)
print("\nUser Preferences 2:")
rankHouses(houses: [house1, house2, house3, house4, house5], preferences: userPreferences2)
print("\nUser Preferences 3:")
rankHouses(houses: [house1, house2, house3, house4, house5], preferences: userPreferences3)
