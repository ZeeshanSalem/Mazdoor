const functions = require('firebase-functions');
const admin = require('firebase-admin');


admin.initializeApp(functions.config().firebase);

const db = admin.firestore();

exports.notifinewjob = functions.firestore.document(
    'Users_Info/{currentUserId}'
).onCreate((snapshot, context) => {
    var userInfo = snapshot.data();

    console.log("the function is here in notificaton to");
    console.log(userInfo.userPhoneNumber);
    console.log(userInfo.userToken);

    userToken = userInfo.userToken;
    userName = userInfo.userName;
    userPhone = userInfo.userPhoneNumber;

    var payload = {
        "notification": {
            "title" : "Wellcome " + userName,
            "body" : "You are login through" + userPhone,
            "sound" : "default"
        },
        "data" : {
            "sendername" : "Wellcome " + userName,
            "message" : "You are login through" + userPhone,
        }
    }


    // console.log("The user found in like trigger function");
    // console.log(userInfo.userToken);

    //userToken = userInfo.userToken;
    
    return admin.messaging().sendToDevice(userToken, payload); 
  
});


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });