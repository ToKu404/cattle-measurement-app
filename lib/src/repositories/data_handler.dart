import 'package:cattle_app/src/models/result_entity.dart';
import 'package:flutter/widgets.dart';

class DataHandler with ChangeNotifier {
  ResultEntity _resultEntity = ResultEntity();

  ResultEntity get resultEntity => _resultEntity;

  void init() {
    _resultEntity = ResultEntity();
  }

  void setIdFotoSamping(String id) {
    _resultEntity.idFotoSamping = id;
    notifyListeners();
  }

  void setJarakSamping(String jarak) {
    _resultEntity.jarakSamping = jarak;
    notifyListeners();
  }

  void setIdFotoBelakang(String id) {
    _resultEntity.idFotoBelakang = id;
    notifyListeners();
  }

  void setJarakBelakang(String jarak) {
    _resultEntity.jarakBelakang = jarak;
    notifyListeners();
  }

  void setIdSapi(String id) {
    _resultEntity.idSapi = id;
    notifyListeners();
  }

  void setPanjangGambar(String panjang) {
    _resultEntity.panjangGambar = panjang;
    notifyListeners();
  }

  void setJarakKamera(String jarak) {
    _resultEntity.jarakKamera = jarak;
    notifyListeners();
  }

  void setPanjangMeter(String panjang) {
    _resultEntity.panjangMeter = panjang;
    notifyListeners();
  }

  void setPanjangPixel(String panjang) {
    _resultEntity.panjangPixel = panjang;
    notifyListeners();
  }

  void setBeratSapi(String berat) {
    _resultEntity.beratSapi = berat;
    notifyListeners();
  }
}
