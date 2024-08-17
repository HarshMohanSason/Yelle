
import 'package:flutter/cupertino.dart';

enum LoginStatus{
  error,
  success,
  loading,
  idle,
}


class PhoneLoginService extends ChangeNotifier{

LoginStatus _status = LoginStatus.idle;
LoginStatus get status => _status;

}