// var nameVar = 'Jason'
// var nameVar = 'blah'
// console.log('nameVar', nameVar)

// let nameLet = 'Joe'
// nameLet = 'Julie'
// console.log('nameLet', nameLet)

// const nameConst = 'Frank'
// console.log('nameConst', nameConst)

// function getPetName() {
//     const petName = 'Hal'
//     return petName
// }

// const petName = getPetName();
// console.log(petName)

// Block scoping
var fullName = 'Jason Voll'

if (fullName) {
    const firstName = fullName.split(' ')[0]
    console.log(firstName)
}

// This won't work thanks to block scoping hooray!
// console.log(firstName)