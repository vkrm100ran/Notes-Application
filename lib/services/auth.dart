import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sheets/services/localdb.dart';
import 'package:google_sign_in/google_sign_in.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

// google SignIn---
Future<User?> signInWithGoogle() async{
  try{
    //// authenticate user with googleSignIn authentication ---
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;


    //// after signIn and authentication of the user, make a credential for the user to pass the user to the firebase --
    // creating credential for the user --
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    // signining with credential and get user class for sign in firebase --
    final userCredential = await _auth.signInWithCredential(credential);
    User? user = userCredential.user;


    // checking is On---
    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    final User? currentUser = await _auth.currentUser;
    assert(currentUser!.uid == user!.uid);
    print(user);



    //// store name, email in storage --
    LocalDataSaver.saveLoginData(true);
    LocalDataSaver.saveName(user!.displayName.toString());
    LocalDataSaver.saveEmail(user.email.toString());
    LocalDataSaver.saveImg(user.photoURL.toString());
    LocalDataSaver.saveSyncSetting(false);

    return user;

  } catch(e){
    print("error is generated in signin with google auth file .......  ..... ////////////// {$e}");
  }



}


/// signOut Button ----
Future<String> signOut() async{
  await googleSignIn.signOut();
  await _auth.signOut();
  LocalDataSaver.saveLoginData(false);
  return "success";
}



