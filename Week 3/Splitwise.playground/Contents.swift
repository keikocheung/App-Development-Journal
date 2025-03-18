import UIKit

struct User { //creatng a user struct to store each new additional user in a party, with their respective information
    let id: Int
    let name: String
}

struct Expense { //a struct that tracks how much is owed, by whom, and split amongsts which user
    let amount: Double
    let paidBy: User
    let splitAmong: [User]
}

func calcBalances (expenses: [Expense]) -> [String: Double] {
    var balances: [String: Double] = [:] //a array of string with a double amount due attached to it, it is initially empty so we can fill it with balances using for loop before.
    
    for expense in expenses { //within this calculate hwo much is split amongst selected users, and keeps track of accumulated balances and assign/deducts it from the specific user
        let splitAmount = expense.amount / Double(expense.splitAmong.count)
        
        balances[expense.paidBy.name, default: 0] += expense.amount
        
        for user in expense.splitAmong {
            balances[user.name, default: 0] -= splitAmount
        }
    }
    
    return balances
}

// TESTING | Sample Users
let alice = User(id: 1, name: "Alice")
let bob = User(id: 2, name: "Bob")
let charlie = User(id: 3, name: "Charlie")

// TESTING | Sample Expenses
let expenses = [
    Expense(amount: 60, paidBy: alice, splitAmong: [alice, bob, charlie]),
    Expense(amount: 30, paidBy: bob, splitAmong: [bob, charlie])
]

// TESTING | Compute balances
let balances = calcBalances(expenses: expenses)

// TESTING | Print results
for (user, balance) in balances {
    print("\(user) balance: \(balance)")
}

