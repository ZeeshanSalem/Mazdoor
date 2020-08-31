const functions = require('firebase-functions');
const admin = require('firebase-admin');


admin.initializeApp(functions.config().firebase);

const db = admin.firestore();

exports.notifyUser = functions.firestore.document(
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

exports.notifyLabor = functions.firestore.document(
    'Labors_Info/{currentUserId}'
).onCreate((snapshot, context) => {
    var laborInfo = snapshot.data();

    console.log("the function is here in notificaton to");
    console.log(laborInfo.laborPhoneNumber);
    console.log(laborInfo.laborToken);

    laborToken = laborInfo.laborToken;
    laborName = laborInfo.laborName;
    laborPhone = laborInfo.laborPhoneNumber;

    var payload = {
        "notification": {
            "title" : "Wellcome " + laborName,
            "body" : "You are login through " + laborPhone,
            "sound" : "default"
        },
        "data" : {
            "sendername" : "Wellcome " + laborName,
            "message" : "You are login through " + laborPhone,
        }
    }


    // console.log("The user found in like trigger function");
    // console.log(userInfo.userToken);

    //userToken = userInfo.userToken;
    
    return admin.messaging().sendToDevice(laborToken, payload); 
  
});

exports.sendRequestToLabor = functions.firestore.document(
    '/Labor_Requests/{currentUserId}/From_User/{userId}'
).onCreate(async (snapshot, context) =>{
    var userData = snapshot.data();

    userName = userData.userName;
    userPhone = userData.userPhone;
    
    laborToken = user.laborToken;
    

    var payload = {
        "notification":{
            "title" : userName + " Send request",
            "body"  : userPhone + " call him for more Info",
            "sound" : "default",
        },
        "data" : {
            "sendername" : userName + "send request",
            "message" : "heloo",
        }
    }

    return admin.messaging().sendToDevice(laborToken, payload);
});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });