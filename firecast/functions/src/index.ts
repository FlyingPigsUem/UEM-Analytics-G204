import * as functions from 'firebase-functions';

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const newValueFunction = functions.firestore.document('usuarios/{userId}').onCreate((snap, context) => {
    const newValue = snap.data();

    if (newValue) {
        return snap.ref.update(
        {"Tension Arterial": (Math.random()*40+60).toFixed(0), 
        "Pulso": (Math.random()*80+40).toFixed(0), 
        "Respiraciones": (Math.random()*25+5).toFixed(0), 
        "Presión venosa auricula derecha": (Math.random()*5).toFixed(1), 
        "Presión venosa vena cava": (Math.random()*6+6).toFixed(1), 
        "Presion pulmonar": (Math.random()*20+10).toFixed(1), 
        "Saturacion venosa": (Math.random()*20+30).toFixed(1), 
        "Saturacion O2": (Math.random()*15+85).toFixed(1), 
        "Presion Intracraneal": (Math.random()*13+10).toFixed(1), 
        "Niveles de Glucemia": (Math.random()*120+40).toFixed(0), 
        "Capnografía": (Math.random()*20+30).toFixed(1), 
         });
    }
    return null;
});
