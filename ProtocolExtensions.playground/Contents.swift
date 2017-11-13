import Foundation

protocol Exercise : CustomStringConvertible {
    var name: String { get }
    var caloriesBurned: Double { get }
    var minutes: Double { get }
    var title: String {get}
}

extension Exercise {
    var caloriesBurnedPerMinute: Double {
        return caloriesBurned / minutes
    }
}

extension Exercise {
    var description: String {
        return "Exercise(\(name), burned \(caloriesBurned) calories in \(minutes) minutes)"
    }
}

struct EllipticalWorkout: Exercise {
    let name = "Elliptical Workout"
    let caloriesBurned: Double
    let minutes: Double
    let title = "Workout using the Go Fast Elliptical Trainer 3000"
}

struct TreadmillWorkout: Exercise {
    let name = "Treadmill Workout"
    let caloriesBurned: Double
    let minutes: Double
    let laps: Double
    let title = "Treadmill"
}

extension TreadmillWorkout {
    var description: String {
        return "TreadmillWorkout(\(caloriesBurned) calories and \(laps) laps in \(minutes) minutes)"
    }
}

let ellipticalWorkout = EllipticalWorkout(caloriesBurned: 335, minutes: 30)

let runningWorkout = TreadmillWorkout(caloriesBurned: 350, minutes: 25, laps: 10.5)

print(ellipticalWorkout.caloriesBurnedPerMinute)
print(runningWorkout.caloriesBurnedPerMinute)

extension Sequence where Iterator.Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}

let mondayWorkout: [Exercise] = [ellipticalWorkout, runningWorkout]
print(mondayWorkout.totalCaloriesBurned())
print(ellipticalWorkout)
print(runningWorkout)

extension Exercise {
    var title: String {
        return "\(name) - \(minutes) minutes"
    }
}

for exercise in mondayWorkout {
    print(exercise.title)
}

print(ellipticalWorkout.title)
