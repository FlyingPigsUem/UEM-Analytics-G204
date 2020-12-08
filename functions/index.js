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
                "Alerta": admin.firestore.FieldValue.arrayUnion(alert)
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
            var nAlert = 0;
            var alert = 0;


            //var Tension Arterial
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

            var actTensArterial = newValue['Tension Arterial'][newValue['Tension Arterial'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var tensArtNew = +(actTensArterial + (randomChange * change));
            if ((tensArtNew <= 65) || (tensArtNew >= 90)) {
                nAlert += 1;
            }

            //var Pulso
     
            if (changeValue <= 0.4){
                var change = -1;
            }
            else if (changeValue <= 0.65){
                var change = 0;
            }
            else{
                var change = 1;
            }

            var actPulse = newValue['Pulso'][newValue['Pulso'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var pulseNew = +(actPulse + (randomChange * change));
            if ((pulseNew <= 60) || (pulseNew >= 100)) {
                nAlert += 1;
            }


            // var Respiraciones

            if (changeValue <= 0.3){
                var change = -1;
            }
            else if (changeValue <= 0.7){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actResp = newValue['Respiraciones'][newValue['Respiraciones'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var respNew = +(actResp + (randomChange * change));
            if ((respNew <= 8) || (respNew >= 25)){
                nAlert += 1;
            }
            
            
            // var Presión venosa auricula derecha

            if (changeValue <= 0.35){
                var change = -1;
            }
            else if (changeValue <= 0.65){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actPresAuric = newValue['Presión venosa auricula derecha'][newValue['Presión venosa auricula derecha'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var presAuricNew = +(actPresAuric + (randomChange * change));
            if ((presAuricNew <=0) || (presAuricNew >= 5)){
                nAlert += 1;
            }

            // var Presión venosa vena cava
            
            if (changeValue <= 0.35){
                var change = -1;
            }
            else if (changeValue <= 0.65){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actPresVena = newValue['Presión venosa vena cava'][newValue['Presión venosa vena cava'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var presVenaNew = +(actPresVena + (randomChange * change));
            if ((presVenaNew <= 6) || (presVenaNew >= 12)){
                nAlert += 1;
            }


            // var Presion pulmonar
            
            if (changeValue <= 0.3){
                var change = -1;
            }
            else if (changeValue <= 0.7){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actPresPulm = newValue['Presion pulmonar'][newValue['Presion pulmonar'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var presPulmNew = +(actPresPulm + (randomChange * change));
            if ((presPulmNew <= 14) || (presPulmNew >= 25)){
                nAlert += 1;
            }


            // var Saturacion venosa
            
            if (changeValue <= 0.35){
                var change = -1;
            }
            else if (changeValue <= 0.7){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actSatVenosa = newValue['Saturacion venosa'][newValue['Saturacion venosa'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var satVenosaNew = +(actSatVenosa + (randomChange * change));
            if ((satVenosaNew <= 36) || (satVenosaNew >= 44)){
                nAlert += 1;
            }

            // var Saturacion O2
            
            if (changeValue <= 0.3){
                var change = -1;
            }
            else if (changeValue <= 0.7){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actSatO2 = newValue['Saturacion O2'][newValue['Saturacion O2'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var satO2New = +(actSatO2 + (randomChange * change));
            if ((satO2New <= 80) || (satO2New >= 100)){
                nAlert += 1;
            }
            

            // var Niveles de Glucemia
            
            if (changeValue <= 0.45){
                var change = -1;
            }
            else if (changeValue <= 0.55){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actGluc = newValue['Niveles de Glucemia'][newValue['Niveles de Glucemia'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var glucNew = +(actGluc + (randomChange * change));
            if ((glucNew <= 70) || (glucNew >= 105)){
                nAlert += 1;
            }


            //var Presion Intracraneal
            
            if (changeValue <= 0.25){
                var change = -1;
            }
            else if (changeValue <= 0.75){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actPresIntrac = newValue['Presion Intracraneal'][newValue['Presion Intracraneal'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var presIntracNew = +(actPresIntrac + (randomChange * change));
            if ((presIntracNew <= 10) || (presIntracNew >= 20)){
                nAlert += 1;
            }


            //var Capnografía
            
            if (changeValue <= 0.3){
                var change = -1;
            }
            else if (changeValue <= 0.7){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actCap = newValue['Capnografía'][newValue['Capnografía'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var capNew = +(actCap + (randomChange * change));
            if ((capNew <= 35) || (capNew >= 45)){
                nAlert += 1;
            }

            //var temperature
            
            if (changeValue <= 0.45){
                var change = -1;
            }
            else if (changeValue <= 0.55){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actTemp = newValue['temperature'][newValue['temperature'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var tempNew = +(actTemp + (randomChange * change));
            if((tempNew <= 36.1) || (tempNew >= 38)){
                nAlert += 1;
            }

            //var weight
            
            if (changeValue <= 0.75){
                var change = -1;
            }
            else if (changeValue <= 0.95){
                var change = 0;
            }
            else{
                var change = 1;
            }
            var actWeight = newValue['weight'][newValue['weight'].length - 1];
            var randomChange = +(Math.random()).toFixed(1);
            var weightNew = +(actWeight + (randomChange * change));


            // alerta
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

            
            return doc.ref.update({
               "Tension Arterial": admin.firestore.FieldValue.arrayUnion(+tensArtNew.toFixed(1)),
               "Pulso": admin.firestore.FieldValue.arrayUnion(+pulseNew.toFixed(1)),
               "Respiraciones": admin.firestore.FieldValue.arrayUnion(+respNew.toFixed(1)),
               "Presión venosa auricula derecha": admin.firestore.FieldValue.arrayUnion(+presAuricNew.toFixed(1)),
               "Presión venosa vena cava": admin.firestore.FieldValue.arrayUnion(+presVenaNew.toFixed(1)),
               "Presion pulmonar": admin.firestore.FieldValue.arrayUnion(+presPulmNew.toFixed(1)),
               "Saturacion venosa": admin.firestore.FieldValue.arrayUnion(+satVenosaNew.toFixed(1)),
               "Saturacion O2": admin.firestore.FieldValue.arrayUnion(+satO2New.toFixed(1)),
               "Presion Intracraneal": admin.firestore.FieldValue.arrayUnion(+presIntracNew.toFixed(1)),
               "Niveles de Glucemia": admin.firestore.FieldValue.arrayUnion(+glucNew.toFixed(1)),
               "Capnografía": admin.firestore.FieldValue.arrayUnion(+capNew.toFixed(1)),
               "Alerta": admin.firestore.FieldValue.arrayUnion(+alert.toFixed(1)),
               "temperature": admin.firestore.FieldValue.arrayUnion(+tempNew.toFixed(1)),
               "weight": admin.firestore.FieldValue.arrayUnion(+weightNew.toFixed(1))
               
            });
        });
    })
    return null
    
    /*.catch(function(error) {
        console.log("Error getting documents: ", error);
    });
    console.log("Error getting document:", error);
    */
    
});





