// Using a constant in a loop
let maxCount = 10 // Fixed variable that determines the loop limit

for number in 1...maxCount {
    print("Number: \(number)")
}

// Using a while loop with a constant limit
let startValue = 5 // Fixed starting value
var countdown = startValue

while countdown > 0 {
    print("Countdown: \(countdown)")
    countdown -= 1
}

print("Blast off!")
