import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:tripper_flutter/models/auth/user_model.dart';
import 'package:tripper_flutter/service/firestore_user.dart';
import 'package:tripper_flutter/service/storage/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final _firebaseAuth = FirebaseAuth.instance;

  final FacebookLogin _facebookLogin = FacebookLogin();

  User get currentUser => _firebaseAuth.currentUser;

  void loginWithEmail({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());

    _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((user) {
      print(user.user.email);
      print(user.user.uid);

      CacheHelper.saveData(key: 'uId', value: user.user.uid);

      emit(LoginSuccessState(user.user.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  void signInWithGoogle() async {
    emit(GoogleLoginLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ))
            .then((user) {
          saveUser(user);
          CacheHelper.saveData(key: 'uId', value: user.user.uid);
        });
        print(userCredential);
        emit(GoogleLoginSuccessState());
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    }
  }

  void signInWithFacebook() async {
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final accessToken = result.accessToken.token;
      final facebookCredential = FacebookAuthProvider.credential(accessToken);
      var user = await _firebaseAuth.signInWithCredential(facebookCredential);
    }
  }

  void saveUser(UserCredential user) {
    UserModel userModel = UserModel(
      phone: '',
      displayName: user.user.displayName,
      email: user.user.email,
      uid: user.user.uid,
      picture:
          'https://firebasestorage.googleapis.com/v0/b/tripper03-9a6fd.appspot.com/o/blank-profile-picture.png?alt=media&token=b910a708-a5fe-444b-b544-2997ef4dbf3c',
    );
    FirestoreUser().addUserToFirestore(userModel: userModel);
    emit(GoogleLoginSuccessState());
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(PasswordChangeVisibilityState());
  }
}
