// ignore_for_file: file_names

import 'Base_provider.dart';
import 'package:get/get.dart';

class UserProvider extends BaseProvider {
  Future<Response> getDataUpdateuser(id) async {
    return get('$Url/update/$id', headers: header);

  }
  Future<Response> getDatauser(id) async {
    return get('$Url/detail/$id', headers: header);
  }

  Future<Response> updateAlamatuser(id, data) async {
    return put('$Urlupdatedatauser/alamat/$id', data, headers: header);
  }

  Future<Response> updateUsernameuser(id, data) async {
    return put('$Urlupdatedatauser/name/$id', data, headers: header);
  }

  Future<Response> updateEmailuser(id, data) async {
    return put('$Urlupdatedatauser/email/$id', data, headers: header);
  }

  Future<Response> updateNoTelpuser(id, data) async {
    return put('$Urlupdatedatauser/no_hp/$id', data, headers: header);
  }

  Future<Response> updatePassworduser(id, data) async {
    return put('$Urlupdatedatauser/password/$id', data, headers: header);
  }

  Future<Response> tariksaldo(id, data) async {
    return post('$Url/penarikanbop/$id', data, headers: header);
  }
}
