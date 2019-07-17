const User = require('../models/user');
const ldap = require('ldapjs');

module.exports = function (app) {
    app.get('/users', (req, res) => {
        User.getusers((err, data) => {
            res.status(200).json(data);
        });
    });

    app.get('/users/:username', (req, res) => {
	console.log("params: ", req.params.username);
        User.getusersByUsername(req.params.username, (err, data) => {
            if (err){
                console.log(err)
            }else{
                res.status(200).json({
                    id: data[0].id,
                    uname: data[0].uname,
                    surname: data[0].surname,
                    email: data[0].email,
                    passw: data[0].passw
                });
            }
        })
    });

    app.post('/users', (req, res) => {
        const userData = {
            id: null,
            uname: req.body.uname,
            surname: req.body.surname,
            email: req.body.email,
            passw: req.body.passw,
            created_at: new Date(),
            updated_at: new Date()
        };
        console.log(userData);
        User.insertUser(userData, (err, data) => {
            if (data && data.insertId) {
                res.status(200).json({
                    id: null,
                    uname: userData.uname,
                    surname: userData.surname,
                    email: userData.email,
                    passw: userData.passw
                })
                
            } else {
                res.status(500).json({
                    success: false,
                    data: 'Error'
                })
            }
        })
    });

    app.put('/users/:id', (req, res) => {
        const userData = {
            id: parseInt(req.params.id),
            uname: req.body.uname,
            surname: req.body.surname,
            email: req.body.email,
            passw: req.body.passw,
            created_at: new Date(),
            updated_at: new Date()
        };
        
        User.updateUser(userData, (err, data) => {
            if (data && data.message) {
                res.json({
                    id: userData.id,
                    uname: userData.uname,
                    surname: userData.surname,
                    email: userData.email,
                    passw: userData.passw
                })
            } else {
                res.status(500).json({
                    success: false,
                    msg: 'Error'
                })
            }
        })
    });
    
    app.delete('/users/:id', (req, res) => {
        User.deleteUser(parseInt(req.params.id), (err, data) => {
            if (data && data.message == 'deleted' || data.message == 'not exists') {
                res.json({
                    id: parseInt(req.params.id)
                })
            }else{
                res.status(500).json({
                    message: "error"
                })
            }
        })
    });

}
