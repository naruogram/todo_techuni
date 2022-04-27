import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  AuthService();
  final _auth = FirebaseAuth.instance;

  String get currentUid => _auth.currentUser!.uid;

  Future<void> signIn() async {
    await _auth.signInAnonymously();
  }
}
