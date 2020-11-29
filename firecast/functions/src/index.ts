import * as functions from 'firebase-functions';

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const newValueFunction = functions.firestore.document('usuarios/{userId}').onCreate((snap, context) => {
    const newValue = snap.data();

    if (newValue) {
        return snap.ref.update(
        {presion: 10, 
        hola: 'hola',
         });
    }
    return null;
});
