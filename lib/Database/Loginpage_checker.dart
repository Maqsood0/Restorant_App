import 'package:restorant_app/Database/RestData.dart';
import 'package:restorant_app/Database/User.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User? user);
}

class LoginPageChecker {
  LoginPageContract _view;
  RestData restData = new RestData();
  LoginPageChecker(this._view);

  doLogin(user) {
    print('do login');
    restData.getLogin(user).then((user) => _view.onLoginSuccess(user));
  }
}
