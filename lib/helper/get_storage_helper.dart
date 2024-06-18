import 'package:get_storage/get_storage.dart';
import 'package:homeqartapp/models/response/login_response.dart';

final box = GetStorage();

class GetStorageHelper {
  static setinitialdata() {
    box.writeIfNull('is_logged_in', false);
    box.writeIfNull('id', "");
    box.writeIfNull('name', "");
    box.writeIfNull('email', "");
    box.writeIfNull('phone', "");
    box.writeIfNull('token_type', "");
    box.writeIfNull('user_image', "");
    box.writeIfNull('access_token', "");
  }

  static setdata(LoginResponse loginResponse) {
    box.write('is_logged_in', true);
    box.write('id', loginResponse.user!.id);
    box.write('name', loginResponse.user!.name);
    box.write('email', loginResponse.user!.email);
    box.write('phone', loginResponse.user!.phone);
    box.write('user_image', loginResponse.user!.image);
    box.write('token_type', loginResponse.tokenType);
    box.write('access_token', loginResponse.accessToken);
  }
}
