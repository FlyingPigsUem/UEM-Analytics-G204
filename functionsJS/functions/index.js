const functions = require('firebase-functions');




var admin = require("firebase-admin");

var serviceAccount = require("./permissions.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://smarthospital-c09f4.firebaseio.com"
});

const express = require('express')
const cors = require('cors');
const app = express();
app.use(cors({ origin: true }));

const db = admin.firestore();
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

/*
 * newValueFunction:
 * Function that allows the entry of new patients to the database
 *
 */

exports.newValueFunction = functions.firestore.document('usuarios/{userId}').onCreate(async (snap, context) => {

    const newValue = snap.data();   //NO ESTOY SEGURA DE QUÉ ES ESTO
    var nAlert = +0;    //nAlert: number of patient alerts
    var alert = 0;  //alert: color in number (0-green, 1-orange, 2-red) of the patient status


    // Pseudorandom creation of each vital sign of the patient within a specified range of values
    // Analysis of each vital sign of the patient based on the normal values
    console.log(newValue['temperature'][newValue['temperature'].length - 1]);
    if ((newValue['temperature'][newValue['temperature'].length - 1] <= 36.1) || (newValue['temperature'][newValue['temperature'].length - 1] >= 38)) {
        nAlert += 1;
    }
    const tensArterial = +(Math.random() * 40 + 60).toFixed(0);
    if ((tensArterial <= 65) || (tensArterial >= 90)) {
        nAlert += 1;
    }
    const pulso = +(Math.random() * 80 + 40).toFixed(0);
    if ((pulso <= 60) || (pulso >= 100)) {
        nAlert += 1;
    }
    const respiraciones = +(Math.random() * 25 + 5).toFixed(0);
    if ((respiraciones <= 8) || (respiraciones >= 25)) {
        nAlert += 1;
    }
    const presAuricula = +(Math.random() * 5).toFixed(1);
    if ((presAuricula <= 0) || (presAuricula >= 5)) {
        nAlert += 1;
    }
    const presVena = +(Math.random() * 6 + 6).toFixed(1);
    if ((presVena <= 6) || (presVena >= 12)) {
        nAlert += 1;
    }
    const presPulmonar = +(Math.random() * 20 + 10).toFixed(1);
    if ((presPulmonar <= 14) || (presPulmonar >= 25)) {
        nAlert += 1;
    }
    const satVenosa = +(Math.random() * 20 + 30).toFixed(1);
    if ((satVenosa <= 36) || (satVenosa >= 44)) {
        nAlert += 1;
    }
    const satO2 = +(Math.random() * 15 + 85).toFixed(1);
    if ((satO2 <= 80) || (satO2 >= 100)) {
        nAlert += 1;
    }
    const presIntracraneal = +(Math.random() * 13 + 10).toFixed(1);
    if ((presIntracraneal <= 10) || (presIntracraneal >= 20)) {
        nAlert += 1;
    }
    const nivGlucemia = +(Math.random() * 120 + 40).toFixed(0);
    if ((nivGlucemia <= 70) || (nivGlucemia >= 105)) {
        nAlert += 1;
    }
    const capnografia = +(Math.random() * 20 + 30).toFixed(1);
    if ((capnografia <= 35) || (capnografia >= 45)) {
        nAlert += 1;
    }

    // Analysis of the alert based in alert number (nAlert)
    console.log(nAlert);

    if (nAlert <= 3) {
        alert = 0;
    }
    if ((nAlert > 3) && (nAlert <= 6)) {
        alert = 1;
    }
    if (nAlert > 6) {
        alert = 2;
    }
    console.log(alert);

    // Distribution of the patient to the doctors existing on database
    if (newValue) {
        console.log("HOLA");
        /* 
         * The distribution depends on the number of patient each doctor has to have the most uniform distribution of the 
         * number of patients per doctor
         */
        await db.collection('doctores').orderBy('nPacientes').limit(1).get().then(querySnapshot => {
            if (!querySnapshot.empty) {
                doctorAux = querySnapshot.docs[0];
                querySnapshot.docs[0].ref.update({
                    "nPacientes": admin.firestore.FieldValue.increment(1),
                    "pacientes": admin.firestore.FieldValue.arrayUnion(snap.id),
                });
            } else {
                console.log("No document corresponding to the query!");
            }
        });
        // Add the created vital sign
        return snap.ref.update(
            {
                "created_time": snap.updateTime,
                "Tension Arterial": admin.firestore.FieldValue.arrayUnion(tensArterial),
                "Pulso": admin.firestore.FieldValue.arrayUnion(pulso),
                "Respiraciones": admin.firestore.FieldValue.arrayUnion(respiraciones),
                "Presión venosa auricula derecha": admin.firestore.FieldValue.arrayUnion(presAuricula),
                "Presión venosa vena cava": admin.firestore.FieldValue.arrayUnion(presVena),
                "Presion pulmonar": admin.firestore.FieldValue.arrayUnion(presPulmonar),
                "Saturacion venosa": admin.firestore.FieldValue.arrayUnion(satVenosa),
                "Saturacion O2": admin.firestore.FieldValue.arrayUnion(satO2),
                "Presion Intracraneal": admin.firestore.FieldValue.arrayUnion(presIntracraneal),
                "Niveles de Glucemia": admin.firestore.FieldValue.arrayUnion(nivGlucemia),
                "Capnografía": admin.firestore.FieldValue.arrayUnion(capnografia),
                "Doctor": doctorAux.id,
                "Alerta": alert
            });
    }
    return null;
});


/*
 * deleteValueFunction:
 * Function that allows discharge a patient by deleting it from the database
 * We also have to delete it from the doctor database
 */

exports.deleteValueFunction = functions.firestore.document('usuarios/{userId}').onDelete(async (snap, context) => {
    const deletedPatient = snap.data();

    const doctorId = deletedPatient.Doctor;


    const doctor = db.collection('doctores').doc(doctorId);

    const res = await doctor.update({
        "nPacientes": admin.firestore.FieldValue.increment(-1),
        "pacientes": admin.firestore.FieldValue.arrayRemove(snap.id)
    });

});


/*
 * refreshPatient:
 * This function update the diferent patient vital sign and status
 */

exports.refreshPatient = functions.pubsub.schedule('every 1 minutes').onRun((context) => {
    console.log('This will run every 20 minutes!');

    db.collection("usuarios").get().then(function (querySnapshot) {

        querySnapshot.forEach(function (doc) {
            if(doc.id!="1raXBCnMFEA6KnE7XZ4Y"){
                
            
            // doc.data() is never undefined for query doc snapshots

            const newValue = doc.data();
            var nAlert = 0;
            var alert = 0;

            // Update of the patient vital sign
            //var Tension Arterial
            var changeValue = Math.random();

            if (changeValue <= 0.35) {
                var change = -1;
            }
            else if (changeValue <= 0.65) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actTensArterial: previous data of Tensión Arterial
            var actTensArterial = newValue['Tension Arterial'][newValue['Tension Arterial'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //tensArtNew: new value of Tensión Arterial based on the randomChange and change values
            var tensArtNew = +(actTensArterial + (randomChange * change));
            if ((tensArtNew <= 65) || (tensArtNew >= 90)) {
                nAlert += 1;
            }

            //var Pulso

            if (changeValue <= 0.4) {
                var change = -1;
            }
            else if (changeValue <= 0.65) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actPulse: previous data of Pulse
            var actPulse = newValue['Pulso'][newValue['Pulso'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //pulseNew: new value of Pulse based on the randomChange and change values
            var pulseNew = +(actPulse + (randomChange * change));
            if ((pulseNew <= 60) || (pulseNew >= 100)) {
                nAlert += 1;
            }


            // var Respiraciones

            if (changeValue <= 0.3) {
                var change = -1;
            }
            else if (changeValue <= 0.7) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actResp: previous data of Respiraciones
            var actResp = newValue['Respiraciones'][newValue['Respiraciones'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //respNew: new value of Respiraciones based on the randomChange and change values
            var respNew = +(actResp + (randomChange * change));
            if ((respNew <= 8) || (respNew >= 25)) {
                nAlert += 1;
            }


            // var Presión venosa auricula derecha

            if (changeValue <= 0.35) {
                var change = -1;
            }
            else if (changeValue <= 0.65) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actPresAuric: previous data of Presión venosa aurícula derecha
            var actPresAuric = newValue['Presión venosa auricula derecha'][newValue['Presión venosa auricula derecha'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //presAuricNew: new value of Respiraciones based on the randomChange and change values
            var presAuricNew = +(actPresAuric + (randomChange * change));
            if ((presAuricNew <= 0) || (presAuricNew >= 5)) {
                nAlert += 1;
            }

            // var Presión venosa vena cava

            if (changeValue <= 0.35) {
                var change = -1;
            }
            else if (changeValue <= 0.65) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actPresVena: previous data of Presión venosa vena cava
            var actPresVena = newValue['Presión venosa vena cava'][newValue['Presión venosa vena cava'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //presVenaNew: new value of Presión venosa vena cava based on the randomChange and change values
            var presVenaNew = +(actPresVena + (randomChange * change));
            if ((presVenaNew <= 6) || (presVenaNew >= 12)) {
                nAlert += 1;
            }


            // var Presion pulmonar

            if (changeValue <= 0.3) {
                var change = -1;
            }
            else if (changeValue <= 0.7) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actPresPulm: previous data of Presión pulmonar
            var actPresPulm = newValue['Presion pulmonar'][newValue['Presion pulmonar'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //presPulmNew: new value of Presión pulmonar based on the randomChange and change values
            var presPulmNew = +(actPresPulm + (randomChange * change));
            if ((presPulmNew <= 14) || (presPulmNew >= 25)) {
                nAlert += 1;
            }


            // var Saturacion venosa

            if (changeValue <= 0.35) {
                var change = -1;
            }
            else if (changeValue <= 0.7) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actSatVenosa: previous data of Saturación venosa
            var actSatVenosa = newValue['Saturacion venosa'][newValue['Saturacion venosa'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //satVenosaNew: new value of Saturación venosa based on the randomChange and change values
            var satVenosaNew = +(actSatVenosa + (randomChange * change));
            if ((satVenosaNew <= 36) || (satVenosaNew >= 44)) {
                nAlert += 1;
            }

            // var Saturacion O2

            if (changeValue <= 0.3) {
                var change = -1;
            }
            else if (changeValue <= 0.7) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actSatO2: previous data of Saturación O2
            var actSatO2 = newValue['Saturacion O2'][newValue['Saturacion O2'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //satO2New: new value of Saturación O2 based on the randomChange and change values
            var satO2New = +(actSatO2 + (randomChange * change));
            if ((satO2New <= 80) || (satO2New >= 100)) {
                nAlert += 1;
            }


            // var Niveles de Glucemia

            if (changeValue <= 0.45) {
                var change = -1;
            }
            else if (changeValue <= 0.55) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actGluc: previous data of Niveles de Glucemia
            var actGluc = newValue['Niveles de Glucemia'][newValue['Niveles de Glucemia'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //glucNew: new value of Niveles de glucemia based on the randomChange and change values
            var glucNew = +(actGluc + (randomChange * change));
            if ((glucNew <= 70) || (glucNew >= 105)) {
                nAlert += 1;
            }


            //var Presion Intracraneal

            if (changeValue <= 0.25) {
                var change = -1;
            }
            else if (changeValue <= 0.75) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actPresIntrac: previous data of Presión Intercraneal
            var actPresIntrac = newValue['Presion Intracraneal'][newValue['Presion Intracraneal'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //presIntracNew: new value of Presión Intracraneal based on the randomChange and change values
            var presIntracNew = +(actPresIntrac + (randomChange * change));
            if ((presIntracNew <= 10) || (presIntracNew >= 20)) {
                nAlert += 1;
            }


            //var Capnografía

            if (changeValue <= 0.3) {
                var change = -1;
            }
            else if (changeValue <= 0.7) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actCapnografía: previous data of Capnografía
            var actCap = newValue['Capnografía'][newValue['Capnografía'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //capNew: new value of Capnografía based on the randomChange and change values
            var capNew = +(actCap + (randomChange * change));
            if ((capNew <= 35) || (capNew >= 45)) {
                nAlert += 1;
            }

            //var temperature

            if (changeValue <= 0.45) {
                var change = -1;
            }
            else if (changeValue <= 0.55) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actTemp: previous data of Temp
            var actTemp = newValue['temperature'][newValue['temperature'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //tempNew: new value of Temperatura based on the randomChange and change values
            var tempNew = +(actTemp + (randomChange * change));
            if ((tempNew <= 36.1) || (tempNew >= 38)) {
                nAlert += 1;
            }

            //var weight

            if (changeValue <= 0.75) {
                var change = -1;
            }
            else if (changeValue <= 0.95) {
                var change = 0;
            }
            else {
                var change = 1;
            }

            //actWeigh: previous data of Weight
            var actWeight = newValue['weight'][newValue['weight'].length - 1];
            //randomChange: how much the data is going to change
            var randomChange = +(Math.random()).toFixed(1);
            //tempNew: new value of Teperatura based on the randomChange and change values
            var weightNew = +(actWeight + (randomChange * change));


            // Analysis of the alert based in alert number (nAlert)
            if (nAlert <= 3) {
                alert = 0;
            }
            if ((nAlert > 3) && (nAlert <= 6)) {
                alert = 1;
            }
            if (nAlert > 6) {
                alert = 2;
            }
            console.log(alert);

            //update of the vital sign of the patient
            //Tension Arterial
            const groupTensionArterial =  newValue['Tension Arterial'];
            groupTensionArterial.push(+tensArtNew.toFixed(1));

            //Pulso
            const groupPulso =  newValue['Pulso'];
            groupPulso.push(+pulseNew.toFixed(1));
            
            //Respiraciones
            const groupRespiraciones =  newValue['Respiraciones'];
            groupRespiraciones.push(+respNew.toFixed(1));
            
            //Presión venosa auricula derecha
            const groupPVAuric =  newValue['Presión venosa auricula derecha'];
            groupPVAuric.push(+presAuricNew.toFixed(1));

            //Presión venosa vena cava
            const groupPVVen =  newValue['Presión venosa vena cava'];
            groupPVVen.push(+presVenaNew.toFixed(1));
            
            //Presion pulmonar
            const groupPresPulmonar =  newValue['Presion pulmonar'];
            groupPresPulmonar.push(+presPulmNew.toFixed(1));

            //Saturacion venosa
            const groupSatVen =  newValue['Saturacion venosa'];
            groupSatVen.push(+satVenosaNew.toFixed(1));

            ///ESTRO EST MIAOOODINOIDNOIDNOIDNIODN

            
            //Presion Intracraneal
            const groupO2 =  newValue['Saturacion O2'];
            groupO2.push(+satVenosaNew.toFixed(1));
            //Presion Intracraneal
            const groupIntrac =  newValue['Presion Intracraneal'];
            groupIntrac.push(+presIntracNew.toFixed(1));

            //Niveles de Glucemia
            const groupGlucemia =  newValue['Niveles de Glucemia'];
            groupGlucemia.push(+glucNew.toFixed(1));
            
            //Capnografía
            const groupCapnografia =  newValue['Capnografía'];
            groupCapnografia.push(+capNew.toFixed(1));
            
            //temperature
            const groupTemperatura =  newValue['temperature'];
            groupTemperatura.push(+tempNew.toFixed(1));


            //weight
            const groupWeight =  newValue['weight'];
            groupWeight.push(+weightNew.toFixed(1));
            
            return doc.ref.update({
                "Tension Arterial": groupTensionArterial,
                "Pulso": groupPulso,
                "Respiraciones": groupRespiraciones,
                "Presión venosa auricula derecha": groupPVAuric,
                "Presión venosa vena cava": groupPVVen,
                "Presion pulmonar": groupPresPulmonar,
                "Saturacion venosa": groupSatVen,
                "Saturacion O2": groupO2,
                "Presion Intracraneal": groupIntrac,
                "Niveles de Glucemia": groupGlucemia,
                "Capnografía": groupCapnografia,
                "Alerta": +alert.toFixed(1),
                "temperature": groupTemperatura,
                "weight": groupWeight

            });
        }
        });
    })
    return null

    /*.catch(function(error) {
        console.log("Error getting documents: ", error);
    });
    console.log("Error getting document:", error);
    */

});


//Routes
app.get('/helloWorld', (req, res) => {
    return res.status(200).send('HelloWorld')
});


//Read

app.get('/api/read/:id',(req,res) =>{
    (async () => {
        try{
            const document = db.collection('usuarios').doc(req.params.id);
            let patient = await document.get();
            let response = patient.data();

            return res.status(200).send(response);
        }
        catch (error){
            console.log(error);
            return res.status(500).send(error);
        }
    })();
});

//update

app.patch('/api/update/:id',(req,res) =>{
    (async () => {
        try{
            const document = db.collection('usuarios').doc(req.params.id);
            const group =  await (await document.get("1raXBCnMFEA6KnE7XZ4Y")).data()['temperature'];
            console.log(group);
            group.push(+req.body.value.toFixed(1));
            await document.update({
                "temperature": group
            });
            
            return res.status(200).send();
        }
        catch (error){
            console.log(error);
            return res.status(500).send(error);
        }
    })();
});


exports.app = functions.https.onRequest(app);

