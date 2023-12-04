// ignore_for_file: file_names

import 'Base_provider.dart';
import 'package:get/get.dart';

class PengirimanProvider extends BaseProvider {
  Future<Response> getDatapengiriman(id) async {
    return get('$Url/pengiriman/$id');
  }
}
