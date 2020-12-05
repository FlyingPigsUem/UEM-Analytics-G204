const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.newValueFunction = functions.firestore.document('usuarios/{userId}').onCreate(async (snap, context) => {

    const newValue = snap.data();
    var nAlert = +0;
    var alert = 0;


    // Constantes
    console.log(newValue['temperature'][newValue['temperature'].length - 1]);
    if((newValue['temperature'][newValue['temperature'].length - 1] <= 36.1) || (newValue['temperature'][newValue['temperature'].length - 1] >= 38)){
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
    if ((respiraciones <= 8) || (respiraciones >= 25)){
        nAlert += 1;
    }
    const presAuricula = +(Math.random() * 5).toFixed(1);
    if ((presAuricula <=0) || (presAuricula >= 5)){
        nAlert += 1;
    }
    const presVena = +(Math.random() * 6 + 6).toFixed(1);
    if ((presVena <= 6) || (presVena >= 12)){
        nAlert += 1;
    }
    const presPulmonar = +(Math.random() * 20 + 10).toFixed(1);
    if ((presPulmonar <= 14) || (presPulmonar >= 25)){
        nAlert += 1;
    }
    const satVenosa = +(Math.random() * 20 + 30).toFixed(1);
    if ((satVenosa <= 36) || (satVenosa >= 44)){
        nAlert += 1;
    }
    const satO2 = +(Math.random() * 15 + 85).toFixed(1);
    if ((satO2 <= 80) || (satO2 >= 100)){
        nAlert += 1;
    }
    const presIntracraneal = +(Math.random() * 13 + 10).toFixed(1);
    if ((presIntracraneal <= 10) || (presIntracraneal >= 20)){
        nAlert += 1;
    }
    const nivGlucemia = +(Math.random() * 120 + 40).toFixed(0);
    if ((nivGlucemia <= 70) || (nivGlucemia >= 105)){
        nAlert += 1;
    }
    const capnografia = +(Math.random() * 20 + 30).toFixed(1);
    if ((capnografia <= 35) || (capnografia >= 45)){
        nAlert += 1;
    }

    // Análisis alerta
    console.log(nAlert);
    
    if (nAlert <= 3){
        alert = 0;
    }
    if ((nAlert > 3) && (nAlert <= 6)){
        alert = 1;
    }
    if (nAlert > 6 ) {
        alert = 2;
    }
    console.log(alert);

    if (newValue) {
        console.log("HOLA");
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
        return snap.ref.update(
            {
                "//created_time": snap.updateTime,
                "-Tension Arterial": admin.firestore.FieldValue.arrayUnion(tensArterial),
                "-Pulso": admin.firestore.FieldValue.arrayUnion(pulso),
                "-Respiraciones": admin.firestore.FieldValue.arrayUnion(respiraciones),
                "-Presión venosa auricula derecha": admin.firestore.FieldValue.arrayUnion(presAuricula),
                "-Presión venosa vena cava": admin.firestore.FieldValue.arrayUnion(presVena),
                "Presion pulmonar": admin.firestore.FieldValue.arrayUnion(presPulmonar),
                "Saturacion venosa": admin.firestore.FieldValue.arrayUnion(satVenosa),
                "-Saturacion O2": admin.firestore.FieldValue.arrayUnion(satO2),
                "-Presion Intracraneal": admin.firestore.FieldValue.arrayUnion(presIntracraneal),
                "-Niveles de Glucemia": admin.firestore.FieldValue.arrayUnion(nivGlucemia),
                "-Capnografía": admin.firestore.FieldValue.arrayUnion(capnografia),
                "-Doctor": doctorAux.id,
                "//Alerta": admin.firestore.FieldValue.arrayUnion(alert)
            });
    }
    return null;
});


exports.deleteValueFunction = functions.firestore.document('usuarios/{userId}').onDelete(async (snap, context) => {
    const deletedPatient = snap.data();

    const doctorId = deletedPatient.Doctor;


    const doctor = db.collection('doctores').doc(doctorId);

    const res = await doctor.update({
        "nPacientes": admin.firestore.FieldValue.increment(-1),
        "pacientes": admin.firestore.FieldValue.arrayRemove(snap.id)
    });

});

exports.refreshPatient = functions.pubsub.schedule('every 1 minutes').onRun((context) => {
    console.log('This will be run every 1 minutes!');

    db.collection("usuarios").get().then(function(querySnapshot) {
       
        querySnapshot.forEach(function(doc) {
            // doc.data() is never undefined for query doc snapshots

            const newValue = doc.data();
            nAlert=0;


            //var tensArterial;
            var changeValue = Math.random();
     
            if (changeValue <= 0.35){
                var change = -1;
            }
            else if (changeValue <= 0.65){
                var change = 0;
            }
            else{
                var change = 1;
            }

            var actVTensArterial = newValue['Tension Arterial'][newValue['Tension Arterial'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var tensArtNew = +(actVTensArterial + (randomChange * change));

  

            // ESTO ESTÁ SIN TOCAR
            if ((tensArtNew <= 65) || (tensArtNew >= 90)) {
                nAlert += 1;
            }

            //var pulse
     
            if (changeValue <= 0.4){
                var change = -1;
            }
            else if (changeValue <= 0.65){
                var change = 0;
            }
            else{
                var change = 1;
            }

            var actVpulse = newValue['Pulso'][newValue['Pulso'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var pulseNew = +(actVpulse + (randomChange * change));

  

            // ESTO ESTÁ SIN TOCAR
            if ((tensArtNew <= 65) || (tensArtNew >= 90)) {
                nAlert += 1;
            }





            
            var pulso = 1;
            if ((pulso <= 60) || (pulso >= 100)) {
                nAlert += 1; 
            }
            var respiraciones =1;
            if ((respiraciones <= 8) || (respiraciones >= 25)){
                nAlert += 1;
            }
            var presAuricula=1;
            if ((presAuricula <=0) || (presAuricula >= 5)){
                nAlert += 1;
            }
            var presVena=1;
            if ((presVena <= 6) || (presVena >= 12)){
                nAlert += 1;
            }
            var presPulmonar=1;
            if ((presPulmonar <= 14) || (presPulmonar >= 25)){
                nAlert += 1;
            }
            var satVenosa=1;
            if ((satVenosa <= 36) || (satVenosa >= 44)){
                nAlert += 1;
            }
            var satO2=1;
            if ((satO2 <= 80) || (satO2 >= 100)){
                nAlert += 1;
            }
            var presIntracraneal=1;
            if ((presIntracraneal <= 10) || (presIntracraneal >= 20)){
                nAlert += 1;
            }
            var nivGlucemia=1;
            if ((nivGlucemia <= 70) || (nivGlucemia >= 105)){
                nAlert += 1;
            }
            var capnografia=1;
            if ((capnografia <= 35) || (capnografia >= 45)){
                nAlert += 1;
            }
            var temperature=1;
            if((newValue['temperature'][newValue['temperature'].length - 1] <= 36.1) || (newValue['temperature'][newValue['temperature'].length - 1] >= 38)){
                nAlert += 1;
            }
            var nAlert = 1;
            var alert = 1;
            console.log(doc);
            console.log(doc.ref)
            return doc.ref.update({
               "Tension Arterial": admin.firestore.FieldValue.arrayUnion(+tensArtNew.toFixed(1)),
               "Pulso": admin.firestore.FieldValue.arrayUnion(+pulseNew.toFixed(1)),
               
            });
            console.log(doc.id, " => ", doc.data());
            
            doc["pulso"] = admin.firestore.FieldValue.arrayUnion(pulso),
            doc["respiraciones"] = admin.firestore.FieldValue.arrayUnion(respiraciones),
            doc["presion auricula"] = admin.firestore.FieldValue.arrayUnion(presAuricula),
            doc["presión cava"] = admin.firestore.FieldValue.arrayUnion(presVena),
            doc["presion pulmonar"]= admin.firestore.FieldValue.arrayUnion(presPulmonar),
            doc["saturación venosa"] = admin.firestore.FieldValue.arrayUnion(satVenosa),
            doc["saturación O2"] = admin.firestore.FieldValue.arrayUnion(satO2),
            doc["presion intracraneal"] = admin.firestore.FieldValue.arrayUnion(presIntracraneal),
            doc["Niveles de Glucemia"] = admin.firestore.FieldValue.arrayUnion(nivGlucemia),
            doc["Capnografia"] = admin.firestore.FieldValue.arrayUnion(capnografia),
            doc["alerta"] = admin.firestore.FieldValue.arrayUnion(alert),
            doc["temperatura"] = admin.firestore.FieldValue.arrayUnion(temperature) 
            //doc["weight"] = admin.firestore.FieldValue.arrayUnion(peso)
        });
    })
    return null
    
    .catch(function(error) {
        console.log("Error getting documents: ", error);
    });
    console.log("Error getting document:", error);
    
});





