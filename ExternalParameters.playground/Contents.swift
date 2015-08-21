// Progress: Page 115
//
// Questions:
//
// - Xcode gives error when use a hash symbol (#) as shorthand for sharing a Named Parameter with both an Internal Name and an External Name (page 115). What is the approach that replaces this?

/* External Parameter Names where each parameter has two names provides clarity and remove ambiguity on the purpose of each argument (such as which argument is the expected value) from the context of its usage. For each Parameter:
        - First Name: External Name used by the Caller
        - Second Name: Internal Name used in the function body
*/

func checkAreEqual(#value: String, #expected: String, #message: String) {
//func checkAreEqual(value val: String, expected exp: String, message msg: String) {
    if exp != val {
        print(msg)
    }
}

/* Use External Named Parameters requires the function arguments to be provided in the correct order. Use a hash (#) as shorthand for sharing a Named Parameter with both an Internal Name and an External Name
*/
checkAreEqual(value: "dog", expected: "cat", message: "Incorrect input")
