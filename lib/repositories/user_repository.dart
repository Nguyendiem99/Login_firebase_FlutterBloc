import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Kich hoat luong xac thuc
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Nhan chi tiet sac thuc yeu cau
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Cap chung chi khi dang nhap bang google
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sau khi đăng nhập, hãy trả lại UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<User?> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
  Future<List<void>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }
  Future<User?> getUser() async {
    return await _firebaseAuth.currentUser;
  }
}