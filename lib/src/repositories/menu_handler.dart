import 'package:cattle_app/src/models/configuration_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuHandler extends ChangeNotifier {
  bool _isSet = false;
  int? _menuId;

  int get menuId => _menuId ?? -1;
  bool get isSet => _isSet;

  void setMenuId(int id) {
    _menuId = id;
    notifyListeners();
  }


  void checkSet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('panjang')) {
      _isSet = true;
      notifyListeners();
    }
  }

  Future<ConfigurationEntity> getConfigurationData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final panjang = pref.getString('panjang') ?? '';
    final lebar = pref.getString('lebar') ?? '';
    final jarak = pref.getString('jarak') ?? '';
    final panjangMeter = pref.getString('panjangMeter') ?? '';
    final panjangPixel = pref.getString('panjangPixel') ?? '';
    final configuration = ConfigurationEntity(
        panjang: panjang,
        jarak: jarak,
        lebar: lebar,
        panjangMeter: panjangMeter,
        panjangPixel: panjangPixel);
    return configuration;
  }

  void setConfigurationData(ConfigurationEntity configuration) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('panjang', configuration.panjang);
    pref.setString('lebar', configuration.lebar);
    pref.setString('jarak', configuration.jarak);
    pref.setString('panjangMeter', configuration.panjangMeter);
    pref.setString('panjangPixel', configuration.panjangPixel);
  }
}
