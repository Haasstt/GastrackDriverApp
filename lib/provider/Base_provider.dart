// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, file_names
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class BaseProvider extends GetConnect {
  var host = "192.168.137.1:8000";
  var Url = "";
  var UrlImageBuktiPembayaran = "";
  var UrlImageBuktiGasMasuk = "";
  var UrlImageBuktiGasKeluar = "";
  var Urlupdatedatauser = "";
  var header = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SpUtil.getString('token')!}'
  };

  BaseProvider() {
    Url = "http://$host/api/sopir";
    Urlupdatedatauser = "http://$host/api/sopir/update";
    UrlImageBuktiPembayaran = "http://$host/img/BuktiPembayaran";
    UrlImageBuktiGasMasuk = "http://$host/img/GasMasuk";
    UrlImageBuktiGasKeluar = "http://$host/img/GasKeluar";
  }
}
