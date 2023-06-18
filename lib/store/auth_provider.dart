import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifire extends StateNotifier<String> {
  AuthNotifire() : super('');

  void setAuth(String contextToken) {
    state = contextToken;
  }

  void clearAuth() {
    state = '';
  }
}

final authProvider = StateNotifierProvider<AuthNotifire, String>((ref) {
  return AuthNotifire();
});
