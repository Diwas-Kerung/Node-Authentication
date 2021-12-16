console.log('Welcome to Door Backend!');
const mongoose = require('mongoose');
var jwt = require('jsonwebtoken');
const express = require('express');
const app = express();
require('dotenv').config();
const port = process.env.PORT || 8000
// localhost with android 192.168.1.64

mongoose.connect(process.env.url)
.then(()=>{
    console.log('Connected to database');
}).catch((err)=>{
    console.log(err);
});

app.use(express.json({ extended: false }))

app.get('/', (req, res)=> {
    res.send('Welcome to Door!\nThe authentication app.');
})

app.listen(port, ()=> {
    console.log('Server is running on port 8000.');
})

let schema = mongoose.Schema({
    email: 'String',
    password: 'String'
})
let User = mongoose.model('User', schema)

app.post('/register', async (req, res)=> {

    const {email, password} = req.body;
    let user = await User.findOne({email})
    if(user){
        console.log('Email already exists!');
        return res.json({msg: 'Email already exists!'})
    }
    user = new User({
        email,
        password
    })
    
    await user.save();
    var token = jwt.sign({id: user.id}, 'dreams')
    console.log(token);
    return res.json({token: token})
})


app.post('/login', async (req, res)=> {
    const {email, password} = req.body;
    
    let user = await User.findOne({email}).then((user)=>{
        console.log(user);
        if(user == null){
            console.log('No user found!');
           return res.json({msg: 'No user found!'});
        } else if (user.password !== password){
            console.log('Password is incorrect!');
            return res.json({msg: 'Password is incorrect!'})
        } else {
            var token = jwt.sign({id: user.id}, 'dreams')
            console.log(token);
            return res.json({
                msg: 'User logged in successfully!',
                token: token});
        }
    }).catch((err)=>console.log(err));
    
})

app.post('/private', (req, res)=>{
    let token = req.header("token");
    if(!token){
        return res.json({msg: 'No entry allowed! Private route'});
    } else {
        var decoded = jwt.verify(token, 'dreams');
        console.log(decoded);
    console.log(decoded.id);
    return res.json({msg: "Welcome to Private Area."});
    }
})