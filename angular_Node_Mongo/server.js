var http=require('http');
var url=require('url');
var file=require('fs');
var mongoClient=require('mongodb').MongoClient;
var nodemailer = require('nodemailer');


var headers = {};
headers["Access-Control-Allow-Origin"] = "*";
headers["Access-Control-Allow-Methods"] = "POST, GET, PUT, DELETE, OPTIONS";
headers["Access-Control-Allow-Credentials"] = false;
headers["Access-Control-Max-Age"] = '86400';
headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept";

var conexionBD='mongodb://localhost:27017/manitas';


http.createServer(function(req,res){

    var ruta=url.parse(req.url).pathname;
    
    switch(req.method){
        case 'GET':
            console.log('\nRecibida peticon GET en puerto 3000.');
            console.log('\tRecurso no encontrado:\n\t\t'+ ruta )
            headers["Content-Type"] = "text/html";
            res.writeHead(404, headers);
            res.end('<html><head></head><body><h1><strong>Recurso no encontrado!!</strong></h1></body></html>');
        break;

        case 'POST':
            console.log('\nRecibida peticon POST en puerto 3000.');
 
            var datos="";
            req.on('data',function(partial){ datos+=partial; });
            req.on('end',function(){
						
                switch(true){

                    case (ruta.search(/.*\/compruebaLogin$/) != -1):
                        console.log('\tRecibidos datos LOGIN: ' + datos);
                        mongoClient.connect(conexionBD,function(err,db){
                            if(!err){
                                console.log("\tConectando al servidor MONGODB...");
                                var credsJSON=JSON.parse(datos);
                                var oki;
                                db.collection('Usuarios').find( { email: credsJSON.email, password: credsJSON.password } ).toArray(function(err,docs){
                                    switch(docs.length){
                                        case 1:
                                            var cliente = JSON.parse(
                                            '{ "nombre":"'+ docs[0].nombre +
                                            '", "apellidos":"'+ docs[0].apellidos +
                                            '", "email":"'+ docs[0].email +
                                            '", "password":"'+ docs[0].password +
                                            '", "direccion":"'+ docs[0].direccion +
                                            '", "tlfno":"'+ docs[0].tlfno +
                                            '", "cp":"'+ docs[0].cp +
                                            '", "provincia":"'+ docs[0].provincia +
                                            '", "localidad":"'+ docs[0].localidad +
                                            '" }'
                                            );
                                            console.log('\tLogin correcto');
                                            oki = true;
                                            headers["Content-Type"] = "application/json";
                                            res.writeHead(200, headers);
                                            res.end(JSON.stringify(cliente));
                                        break;
                                            
                                        default:
                                        break;
                                    }
                                });
                                if(!oki){
                                    db.collection('Empresas').find( { email: credsJSON.email, password: credsJSON.password } ).toArray(function(err,docs){
                                        switch(docs.length){
                                            case 1:
                                                var empresa = JSON.parse(
                                                '{ "nombre":"'+ docs[0].nombre +
                                                '", "cif":"'+ docs[0].cif +
                                                '", "email":"'+ docs[0].email+
                                                '", "password":"'+ docs[0].password +
                                                '", "direccion":"'+ docs[0].direccion +
                                                '", "tlfno":"'+ docs[0].tlfno +
                                                '", "cp":"'+ docs[0].cp +
                                                '", "provincia":"'+ docs[0].provincia +
                                                '", "localidad":"'+ docs[0].localidad +
                                                '", "tipo":"'+ docs[0].tipo +
                                                '" }'
                                                );
                                                console.log('\tLogin correcto');
                                                headers["Content-Type"] = "application/json";
                                                res.writeHead(200, headers);
                                                res.end(JSON.stringify(empresa));
                                            break;
                                                
                                            default:
                                                headers["Content-Type"] = "text/plain";
                                                res.writeHead(404, headers);
                                                res.end();
                                            break;
                                        }
                                    });
                                }
                                db.close();

                            } else {
                                console.log("ERROR conectado al servidor mongoDB.");
                                console.log(err);
                                headers["Content-Type"] = "text/plain";
                                res.writeHead(500, headers);
                                res.end();
                            }
                        });
                                    
                    break;
                                
                    case ruta.search(/.*\/registraUsuario$/) != -1:

                        var json=JSON.parse(datos);
                        var cliente = JSON.parse(
                            '{ "nombre":"'+ json.nombre +
                            '", "apellidos":"'+ json.apellidos +
                            '", "email":"'+ json.email+
                            '", "password":"'+ json.password+
                            '", "direccion":"'+ json.direccion +
                            '", "tlfno":"'+ json.tlfno +
                            '", "cp":"'+ json.cp +
                            '", "provincia":"'+ json.provincia +
                            '", "localidad":"'+ json.localidad +
                            '" }'
                        );                         
                        var reforma = JSON.parse(
                            '{ "cliente":"' + json.nombre +
                            '", "empresa":"' + ' ' +
                            '", "tipo":"'+ json.tipo +
                            '", "descripcion":"' + json.descripcion +
                            '" }'
                        );

                        mongoClient.connect(conexionBD, function (err, db) {
                            if (!err) {
                                db.collection("Usuarios").insertOne(cliente, function(err,result) {
                                    if (!err && result.result.n==1) {
                                        console.log("\tUsuario registrado con exito.");

                                        var texto = `
                                        <html><body><h3>Hola `+ json.nombre +` :</h3><p>Bienvenido! Gracias por registrarte en TuManitas.</p>
                                        <p>Tu nombre de usuario es tu email: `+ json.email +`</p><p>Y tu contraseña es: `+ json.password +`</p>
                                        <p>Te recomendamos que cambies tu contraseña por una que recuerdes más fácilmente. Para ello 
                                        accede directamente a tu Panel de Usuario</p>
                                        <p>Recuerda que puedes añadir imágenes o documentos para recibir presupuestos más ajustados.</p>
                                        <p>¿Qué pasará ahora?</p><ul>
                                        <li><p>Enviaremos aviso a las empresas de tu zona. Un máximo de 4 se podrán apuntar a tu solicitud.</p>
                                        <p>En el 90% de los casos se recibe respuesta en las primeras 24-72 horas.<p></li>
                                        <li>Te enviaremos un email informando de qué empresas te van a contactar.</li>
                                        <li>A partir de ahí cada uno de los profesionales contactará directamente contigo para facilitarte su 
                                        presupuesto (gratuito y sin compromiso), o para ampliar la información si es necesario.</li>
                                        <li>Por favor, responde a los mensajes o llamadas de los profesionales. Ten en cuenta que los profesionales 
                                        pagan por utilizar TuManitas y ofrecerte sus presupuestos, y dedican mucho tiempo y recursos en elaborarlos.</li>
                                        <li>Tu solicitud estará activa 10 días, si antes de que finalice ese plazo encuentras un profesional o no deseas 
                                        recibir más presupuestos, avísanos. Así no seguirán contactando contigo otros profesionales.</li>
                                        <li> TuManitas te pone en contacto con los profesionales, sin ejercer de intermediario, toda la información, 
                                        presupuesto, contratación, etc, es directa entre el particular y el profesional.</li>
                                        </ul><p>Atentamente, el equipo de TuManitas</p></body></html>`;

                                        mandarCorreo(json.email, texto);
                                    }
                                    else {
                                        console.log("\tERROR al registrar Usuario");
                                        console.log(err);
                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(500, headers);
                                        res.end();
                                    }
                                });
                            }
                            db.close();
                        });

                        guardarReforma(reforma);

                    break;  

                    case (ruta.search(/.*\/modificarUsuario$/) != -1):
                        console.log('\tActualizacion usuario');
                          mongoClient.connect(conexionBD,function(err,db){
                            if(!err){
                                console.log("\tConectando al servidor MONGODB...");
                                var cliente = JSON.parse(datos);

                                db.collection('Usuarios').update( { nombre: cliente.nombre }, cliente,function(err,result) {
                                    if (!err) {
                                        console.log("\tUsuario actualizado con exito.");
                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(200, headers);
                                        res.end();
                                    }
                                    else {
                                        console.log("\tERROR al actualizar Usuario");
                                        console.log(err);
                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(500, headers);
                                        res.end();
                                    }
                                });
                                db.close();

                            } else {
                                console.log("ERROR conectado al servidor mongoDB.");
                                console.log(err);
                                headers["Content-Type"] = "text/plain";
                                res.writeHead(500, headers);
                                res.end();
                            }
                        });
                                    
                    break;
                
                    case ruta.search(/.*\/registraEmpresa$/) != -1:

                        var empresa = JSON.parse(datos);
                                            
                        mongoClient.connect(conexionBD, function (err, db) {
                            if (!err) {
                                db.collection("Empresas").insertOne(empresa, function(err,result) {
                                    if (!err && result.result.n==1) {
                                        console.log("\tEmpresa registrada con exito.");

                                        var texto = `
                                        <html><body><h3>Hola `+ empresa.nombre +` :</h3>
                                        <p>Bienvenido a TuManitas!</p>
                                        <p>Tu nombre de usuario es tu email: `+ empresa.email +`</p><p>Y tu contraseña es: `+ empresa.password +`</p>
                                        <p>Si quieres tener acceso a cientos de trabajos de obra y reforma necesitarás un Pase Profesional.</p>
                                        <p>Recuerda que puedes añadir imágenes o documentos para recibir presupuestos más ajustados.</p>
                                        <p>Con él podrás presupuestar los mejores trabajos de TuManitas y beneficiarte de todas las ventajas de ser profesional.</p>
                                        <p>¡Demuestra lo que vale tu trabajo!</p>
                                        <p>Atentamente, el equipo de TuManitas</p></body></html>`;

                                        mandarCorreo(empresa.email, texto);

                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(200, headers);
                                        res.end();
                                    }
                                    else {
                                        console.log("\tERROR al registrar la empresa");
                                        console.log(err);
                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(500, headers);
                                        res.end();
                                    }
                                });
                            }
                            db.close();
                        });

                    break;

                    case ruta.search(/.*\/registraReforma$/) != -1:
                    
                        var reforma=JSON.parse(datos);
                        
                        mongoClient.connect(conexionBD, function (err, db) {
                            if (!err) {
                                db.collection("Reformas").insertOne(reforma, function(err,result) {
                                    if (!err && result.result.n==1) {
                                        console.log("\tReforma registrada con exito.");
                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(200, headers);
                                        res.end();
                                    }
                                    else {
                                        console.log("\tERROR al registrar Reforma");
                                        console.log(err);
                                        headers["Content-Type"] = "text/plain";
                                        res.writeHead(500, headers);
                                        res.end();
                                    }
                                });
                            }
                            db.close();
                        });

                    break;  
                    
                    case (ruta.search(/.*\/recuperarReformas$/) != -1):
                        console.log('\tRecibida peticion reformas');
                        mongoClient.connect(conexionBD,function(err,db){
                            if(!err){
                                console.log("\tConectando al servidor MONGODB...");
                                var cliente = JSON.parse(datos);
                                db.collection('Reformas').find( { cliente: cliente.nombre }, { _id: 0 } ).toArray(function(err,docs){
                                    if(docs){
                                        console.log('\tEnviada Respuesta');
                                        headers["Content-Type"] = "application/json";
                                        res.writeHead(200, headers);
                                        res.end(JSON.stringify(docs));
                                    }
                                });
                                db.close();

                            } else {
                                console.log("ERROR conectado al servidor mongoDB.");
                                console.log(err);
                                headers["Content-Type"] = "text/plain";
                                res.writeHead(500, headers);
                                res.end();
                            }
                        });

                    break;
                }
            });
        break;

    }


    function guardarReforma(reforma) {
        mongoClient.connect(conexionBD, function (err, db) {
            if (!err) {
                db.collection("Reformas").insertOne(reforma, function(err,result) {
                    if (!err && result.result.n==1) {
                        console.log("\tReforma registrada con exito.");
                        headers["Content-Type"] = "text/plain";
                        res.writeHead(200, headers);
                        res.end();
                    }
                    else {
                        console.log("\tERROR al registrar la reforma");
                        console.log(err);
                        headers["Content-Type"] = "text/plain";
                        res.writeHead(500, headers);
                        res.end();
                    }
                });
            }
            db.close();
        });
    }

    function mandarCorreo(email, texto) {
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'dawtarde@gmail.com',
              pass: 'dawtardepruebas'
            }
          });
          
          var mailOptions = {
            from: 'dawtarde@gmail.com',
            to: email+"",
            subject: 'Bienvenido a TuManitas!',
            html: texto+""
          };
          
          transporter.sendMail(mailOptions, function(error, info){
            if (error) {
                console.log(error);
            } else {
                console.log('\tEmail enviado: ' + info.response);
            }
          }); 
    }
    
             
}).listen(3000)    





