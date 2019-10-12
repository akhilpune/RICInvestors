
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ricinvestors/services/auth.dart';



class EmailSignInChangeModel with  ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.submitted = false,
  });
  final AuthBase auth;
  String email;
  String password;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      await auth.signInWithEmailAndPassword(email, password);


    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }


    void updateEmail(String email) => updateWith(email: email);

    void updatePassword(String password) => updateWith(password: password);

    void updateWith({
      String email,
      String password,
      bool isLoading,
      bool submitted,
    }) {
      this.email = email ?? this.email;
      this.password = password ?? this.password;

      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this.submitted;
      notifyListeners();
    }
  }
