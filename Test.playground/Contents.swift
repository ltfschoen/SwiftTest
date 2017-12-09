
class MyClass {
    var foo: Double = 0.0
}

var classA = MyClass()
let classB = MyClass()
classA.foo = 1.0
classB.foo = 1.0
classB.foo = 2.0
classB = classA

