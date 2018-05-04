const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')

let ideas = {}
let ideaIndex = 0
const addIdea = (ideaName) => {
    ideaIndex++
    ideas[ideaIndex] = {
        id: ideaIndex,
        name: ideaName
    }
    return ideaIndex
}
const bootstrap = () => {
    addIdea('Ride a bike')
    addIdea('Learn something new')
    addIdea('Make Chai')
    addIdea('Go Climbing')
}
bootstrap()

const app = express()

// Needed to parse application/json request bodies
app.use(bodyParser.json())

app.use(cors())
const whitelist = ['http://localhost:8080']
var corsOptionsDelegate = function (req, callback) {
    var corsOptions;
    if (whitelist.indexOf(req.header('Origin')) !== -1) {
        corsOptions = { origin: true } // reflect (enable) the requested origin in the CORS response
    }else {
        corsOptions = { origin: false } // disable CORS for this request
    }
    callback(null, corsOptions) // callback expects two parameters: error and options
}

app.get('/', (req, res) => res.send('Hello Test reload!'))
app.post('/', (req, res) => {
    res.send('POST to /')
})

app.get('/ideas', cors(corsOptionsDelegate), (req, res) => {
  res.json(ideas)
})

app.get('/ideas/:id(\\d+)', cors(corsOptionsDelegate), (req, res) => {
    res.json(ideas[req.params.id])
})

app.post('/ideas', cors(corsOptionsDelegate), (req, res) => {
    if (req.body && req.body.idea) {
        const newIdeaId = addIdea(req.body.idea)
        res.status(201)
        res.json(ideas[newIdeaId])
    } else {
        // TODO pretty sure you are supposed to use an error handling middleware for this
        res.status(400)
        res.json({
            error: 'BAD REQUEST'
        })
    }
})

app.delete('/ideas', (req, res) => {
    ideas = {}
    res.json({
        msg: 'DELETED ALL IDEAS'
    })
})

app.listen(3000, () => console.log('Up and running on port 3000!'))