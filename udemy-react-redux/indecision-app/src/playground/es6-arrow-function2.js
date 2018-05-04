// arguments object - no longer bound with arrow functions
const add = (a, b) => {
    // console.log(arguments)
    return a + b
}
console.log(add(55, 1))

// this keyword - no longer bound with arrow functions -- uses the 'this' from it's parent scope
const user = {
    name: 'Jason',
    cities: ['Kitchener', 'Cambridge', 'Vancouver'],
    printPlacesLived() {
        return this.cities.map((city) => {
            return `${this.name} has lived in ${city}!`
        })
    }
}

console.log(user.printPlacesLived())


const multiplier = {
    numbers: [0, 2, 3, 5],
    multiplyBy: 3,
    multiply() {
        return this.numbers.map((num) => num * this.multiplyBy)
    }
}
console.log(multiplier.multiply())