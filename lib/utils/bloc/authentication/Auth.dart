import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<User> signInWithGoogle() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  await googleSignIn.signOut();
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


  // Create a new credential
  final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential credential =  await firebaseAuth.signInWithCredential(googleCredential);
  User user = credential.user;

  assert(!user.isAnonymous);
  assert (await user.getIdToken() != null);

  final User currentUser = firebaseAuth.currentUser;
  assert(currentUser.uid == user.uid);

  return user;
}




Future<User> signUpWithEmail(String email, String password, String username, String phoneNumber) async{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    userCredential.user.sendEmailVerification();

    // Once signed in, return the UserCredential
    UserCredential credential =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User user = credential.user;

    assert(!user.isAnonymous);
    assert (await user.getIdToken() != null);

    final User currentUser = firebaseAuth.currentUser;
    //update display name
    await currentUser.updateProfile(displayName: username);
    //update phone number
    await updateUserPhoneNumber(phoneNumber, currentUser); //todo implement

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


Future<void> updateUserPhoneNumber(String phoneNumber, User currentUser) async{

  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (credential) async {
        await currentUser.updatePhoneNumber(credential);
        // either this occurs or the user needs to manually enter the SMS code
      },
      verificationFailed: null,
      codeSent: (verificationId, [forceResendingToken]) async {
        String smsCode;
        // get the SMS code from the user somehow (probably using a text field)
        final AuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        await FirebaseAuth.instance.currentUser.updatePhoneNumber(credential);
      },
      codeAutoRetrievalTimeout: null);
}


Future<User> logInWithEmail(String email, String password) async{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password);

    // Once signed in, return the UserCredential
    UserCredential credential =  await firebaseAuth.signInWithCredential(userCredential.credential);
    User user = credential.user;

    assert(!user.isAnonymous);
    assert (await user.getIdToken() != null);

    final User currentUser = firebaseAuth.currentUser;
    assert(currentUser.uid == user.uid);

    return user;


  }  catch (e) {
    print(e);
  }
  return null;
}



Future<void> signOut() async{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.signOut();

}

