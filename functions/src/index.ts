import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
//const db=admin.firestore();
const fcm= admin.messaging();

export const sendToken=functions.firestore
.document('Commande/{CommandeId}')
.onUpdate(async snapshot =>{
    const tkn = new Array();
    const oldSnap = snapshot.before.data(); // previous document        
    const newSnap = snapshot.after.data(); // current document       
   if(newSnap.EtatCommande === true && oldSnap.EtatCommande===false )
   {
       tkn.push(newSnap.Token);
       console.log("kikouuuuuuuuuu"+tkn[0]);
   } 
   const payload : admin.messaging.MessagingPayload={
       notification : {
           title :'Easy-Print',
           body:'Votre commande vous attends.',
           clickAction:'FLUTTER_NOTIFICATION_CLICK',
       },
   } ;
   return fcm.sendToDevice(tkn,payload)

})

 //export const helloWorld = functions.https.onRequest((request, response) => {functions.logger.info("Hello logs!", {structuredData: true});
   //response.send("Hello from Firebase!");
 //});
