import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// UjuziUser signedUser;///global variable for signed user
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
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

Future<User> loginWithEmail(String username, String password) async {
  User user;//todo URGENT: implement
  return  user;
}



Future<User> signUpWithEmail(String email, String password) async{
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    // return userCredential;

    // Once signed in, return the UserCredential
    UserCredential credential =  await firebaseAuth.signInWithCredential(userCredential.credential);
    User user = credential.user;

    assert(!user.isAnonymous);
    assert (await user.getIdToken() != null);

    final User currentUser = firebaseAuth.currentUser;
    assert(currentUser.uid == user.uid);

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




Future<void> signOut() async{
  await firebaseAuth.signOut();


}

