import 'package:get_it/get_it.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:untitled/Repositories/SharedPreferencesRepository.dart';

class BiometricsService {
  final _localAuth = LocalAuthentication();

  Future<bool> authenticate() async{
    bool deviceSupportsBiometrics = await _localAuth.isDeviceSupported();
    if(deviceSupportsBiometrics){
      bool authenticationResult = await _localAuth.authenticate(
          localizedReason: 'Login with fingerprint',
          useErrorDialogs: true,
          stickyAuth: true,
          androidAuthStrings: const AndroidAuthMessages(
              cancelButton: 'cancel',
              signInTitle: 'Login with fingerprint',
              goToSettingsButton: 'settings',
              goToSettingsDescription: 'Register your fingerprint'
          ),
          iOSAuthStrings: const IOSAuthMessages(
              goToSettingsButton: 'settings',
              cancelButton: 'cancel',
              goToSettingsDescription: 'Register biometrics'
          )
      );
      //set biometrics enabled
      SharedPreferencesRepository.localStorage.setBooleanValue("BiometricsEnabled", true);
      return authenticationResult;
    }
    return false;
  }

}