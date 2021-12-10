import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ContelfirebaseFirebaseUser {
  ContelfirebaseFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ContelfirebaseFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ContelfirebaseFirebaseUser> contelfirebaseFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ContelfirebaseFirebaseUser>(
            (user) => currentUser = ContelfirebaseFirebaseUser(user));
