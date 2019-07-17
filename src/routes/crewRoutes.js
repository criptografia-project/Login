const crew = require('../models/crew');

module.exports = function(app){
    app.get('/crews',(req,res)=>{
        crew.getcrew((err, data)=>{
            res.status(200).json(data);
        });
    });
    app.post('/crews',(req,res)=>{
        const crewData = {
            id: null,
            id_user: req.body.id_user,
            dependence: req.body.dependence,
            created_at: new Date(),
            updated_at: new Date()
        };
        crew.insertCrew (crewData,(err,data)=>{
            if (data && data.insertId){
                res.json({
                    id: null,
                    id_user: crewData.id_user,
                    dependence: crewData.dependence
                })
            }else{
                res.status(500).json({
                    success: false,
                    data: 'Error'
                })
            }
        })
    });

    app.put('/crews/:id',(req,res)=>{
        const crewData = {
            id: parseInt(req.params.id),
            id_user: req.body.id_user,
            dependence: req.body.dependence,
            created_at: new Date(),
            updated_at: new Date()
        };
        console.log(crewData)
        crew.updateCrew(crewData,(err,data)=>{
            if (data && data.message){
                res.json({
                    id: crewData.id,
                    id_user: crewData.id_user,
                    dependence: crewData.dependence
                })
            }else{
                res.status(500).json({
                    success: false,
                    msg: 'Error'
                })
            }
        })
    });

    app.delete('/crews/:id', (req, res) => {
        crew.deleteCrew(parseInt(req.params.id), (err, data) => {
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