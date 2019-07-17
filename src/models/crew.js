const mysql = require("mysql");

connection = mysql.createConnection({
  host            : process.env.DATABASE_HOST,
  port            : process.env.MYSQL_PORT,
  user            : process.env.MYSQL_USER,
  password        : process.env.MYSQL_PASSWORD,
  database        : process.env.MYSQL_DATABASE
});

let crewModel = {};
crewModel.getcrew = callback => {
  if (connection) {
    connection.query("SELECT * FROM crew ORDER BY id", (err, rows) => {
      if (err) {
        throw err;
      } else {
        callback(null, rows);
      }
    });
  }
};

crewModel.insertCrew = (crewData, callback) => {
  if (connection) {
    connection.query(
      "INSERT INTO crew SET ?",
      crewData,
      (err, result) => {
        if (err) {
          throw err;
        } else {
          callback(null, {
            insertId: result.insertId
          });
        }
      }
    );
  }
};

crewModel.updateCrew = (crewData, callback) => {
  if (connection) {
    const sql = `
        UPDATE crew SET
        id_user = ${connection.escape(crewData.id_user)},
        dependence = ${connection.escape(crewData.dependence)}
        WHERE id = ${connection.escape(crewData.id)}`;

    connection.query(sql, (err, result) => {
      if (err) {
        throw err;
      } else {
        callback(null, {
          message: "success"
        });
      }
    });
  }
};

crewModel.deleteCrew = (id, callback) => {
  if (connection) {
    let sql = `
      SELECT * FROM crew WHERE id = ${connection.escape(id)}`;
    connection.query(sql, (err, row) => {
      if (row) {
        let sql = `DELETE FROM crew WHERE id = ${id}`;
        connection.query(sql, (err, result) => {
          if (err) {
            throw err
          } else {
            callback(null, {
              "message": "deleted"
            })
          }
        })
      } else {
        callback(null, {
          "message": "not exists"
        })
      }
    })
  }
};

module.exports = crewModel;
