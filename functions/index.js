const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.newValueFunction = functions.firestore.document('usuarios/{userId}').onCreate(async (snap, context) => {

    const newValue = snap.data();



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
                "Tension Arterial": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 40 + 60).toFixed(0)),
                "Pulso": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 80 + 40).toFixed(0)),
                "Respiraciones": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 25 + 5).toFixed(0)),
                "Presión venosa auricula derecha": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 5).toFixed(1)),
                "Presión venosa vena cava": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 6 + 6).toFixed(1)),
                "Presion pulmonar": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 20 + 10).toFixed(1)),
                "Saturacion venosa": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 20 + 30).toFixed(1)),
                "Saturacion O2": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 15 + 85).toFixed(1)),
                "Presion Intracraneal": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 13 + 10).toFixed(1)),
                "Niveles de Glucemia": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 120 + 40).toFixed(0)),
                "Capnografía": admin.firestore.FieldValue.arrayUnion(+(Math.random() * 20 + 30).toFixed(1)),
                "Doctor": doctorAux.id
            });
    }
    return null;
});


exports.deleteValueFunction = functions.firestore.document('usuarios/{userId}').onDelete(async (snap, context) => {
    const deletedPatient = snap.data();

    const doctorId = deletedPatient.Doctor;


    const doctor = db.collection('doctores').doc(doctorId);

    // Set the 'capital' field of the city
    const res = await doctor.update({
        "nPacientes": admin.firestore.FieldValue.increment(-1),
        "pacientes": admin.firestore.FieldValue.arrayRemove(snap.id)
    });

});



