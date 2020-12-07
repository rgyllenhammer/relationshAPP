const functions = require('firebase-functions');
const admin = require('firebase-admin');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

admin.initializeApp()

exports.newNodeDetected = functions.database.ref('messages/{messageID}')
    .onCreate((snapshot, context) => {
        
        let sendTo = snapshot.val().sendTo;
        let sendFrom = snapshot.val().sendFrom;
        let level = snapshot.val().level;

        let tokenRequest = admin.database().ref(`users/${sendTo}/deviceID`)
        tokenRequest.on('value', (snapshot) => {

            const token = snapshot.val()
            submitPayload(token)
        });

        function submitPayload(token) {
    
            const payload = {
                notification: {
                    title: "Attention Level Request",
                    body: `Request to ${sendTo} for attention level of ${level} from ${sendFrom.toUpperCase()}`
                },
                token: token
            };
    
            admin.messaging().send(payload)
            .then((response) => {
              // Response is a message ID string.
              console.log('Successfully sent message:', response);
              return 0;
            })
            .catch((error) => {
              console.log('Error sending message:', error);
              return 0;
            });

        }        
    });
