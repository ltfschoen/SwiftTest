//// Class
//class Person {
//    // Properties
//    var age = 34, name = "Luke"
//    
//    func growOlder() {
//        self.age++
//    }
//}

// Structures as passed by Value
struct Person {
    // Properties
    var age = 34, name = "Luke"

    // Mutating Methods change state of a Struct
    mutating func growOlder() {
        self.age++
    }
}

//// Class Instance passed as Reference as argument to function
//// Argument is Constant holding Reference to Persion Instance
//func celebrateBirthday(cumple: Person) {
//    print("Happy Birthday \(cumple.name)")
//    cumple.growOlder()
//}

//func celebrateBirthday(var cumple: Person) {
//    cumple = Person()
//    print("Happy Birthday \(cumple.name)")
//    cumple.growOlder()
//}

// Function must be marked as In-Out to mutate the age using growOlder
func celebrateBirthday(inout cumple: Person ) {
    print("Happy Birthday \(cumple.name)")
    cumple.growOlder()
}

//// Constant holding Reference to Person Instance
//let person = Person()
//celebrateBirthday(person)
//print(person.age)

// Variable holding Reference to Person Instance
var person = Person()
celebrateBirthday(&person)
print(person.age)

