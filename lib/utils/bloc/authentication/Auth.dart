import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<User> signInWithGoogle() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  await googleSignIn.signOut();
  final GoogleSignInAccount? googleUser = await (googleSignIn.signIn());
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;


  // Create a new credential
  final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  ) as GoogleAuthCredential;

  // Once signed in, return the UserCredential
  UserCredential credential =  await firebaseAuth.signInWithCredential(googleCredential);
  User user = credential.user!;

  assert(!user.isAnonymous);
  // assert (await user.getIdToken() != null);

  final User currentUser = firebaseAuth.currentUser!;
  assert(currentUser.uid == user.uid);

  return user;
}




Future<User?> signUpWithEmail(String email, String password, String username, String phoneNumber) async{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    userCredential.user!.sendEmailVerification();

    // Once signed in, return the UserCredential
    UserCredential credential =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User user = credential.user!;

    assert(!user.isAnonymous);
    // assert (await user.getIdToken() != null);

    final User currentUser = firebaseAuth.currentUser!;
    //update display name
    await currentUser.updateDisplayName( username);
    //update phone number
    // await updateUserPhoneNumber(phoneNumber, currentUser);

    assert(currentUser.uid == user.uid);
    await user.reload();
    return user;


  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return null;
}


Future<void> updateUserPhoneNumber(String phoneNumber, User currentUser, String sms) async{

  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 4),
      verificationCompleted: (credential) async {
        await currentUser.updatePhoneNumber(credential);
        // either this occurs or the user needs to manually enter the SMS code
      },
      verificationFailed: (exception){

        //todo handle verification exception
         },
      codeSent: (verificationId, [forceResendingToken]) async {
        // get the SMS code from the user somehow (probably using a text field)
        final AuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verificationId, smsCode: sms);
        await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential as PhoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (e){
        //todo show timeout pop up
      }
  );
}


Future<User?> logInWithEmail(String email, String password) async{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password);

    // Once signed in, return the UserCredential
    UserCredential credential =  await firebaseAuth.signInWithCredential(userCredential.credential!);
    User user = credential.user!;

    assert(!user.isAnonymous);
    // assert (await user.getIdToken() != null);

    final User currentUser = firebaseAuth.currentUser!;
    assert(currentUser.uid == user.uid);

    return user;


  }  catch (e) {
    print(e);
  }
  return null;
}




// Future<User> signInWithTwitter() async {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//
//   // Create a TwitterLogin instance
//   final TwitterLogin twitterLogin = new TwitterLogin(
//     consumerKey: "",//todo add twitter api key
//     consumerSecret:"", //todo add twitter api key secret
//   );
//
//   // Trigger the sign-in flow
//   final TwitterLoginResult loginResult = await twitterLogin.authorize();
//   print("\n\nlogin ${loginResult.errorMessage}");
//
//   print("session ${loginResult.session}");
//   // Get the Logged In session
//   final TwitterSession twitterSession = loginResult.session;
//
//   // Create a credential from the access token
//   final twitterAuthCredential = TwitterAuthProvider.credential(
//     accessToken: twitterSession.token,
//     secret: twitterSession.secret,
//   );
//
//   // Once signed in, return the UserCredential
//   UserCredential credential =  await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
//   User user = credential.user;
//
//   assert(!user.isAnonymous);
//   assert (await user.getIdToken() != null);
//
//   final User currentUser = firebaseAuth.currentUser;
//   assert(currentUser.uid == user.uid);
//
//   return user;
// }



Future<void> signOut() async{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.signOut();

}

