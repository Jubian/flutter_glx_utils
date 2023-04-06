import 'dart:convert';
import 'package:flutter/services.dart';
import 'address_model.dart';

abstract class AddressManager {

  static final List<Province> _provinces = [];
  static final Map<String, Province> _provinceMap = {};
  static final Map<String, City> _cityMap = {};
  static final Map<String, District> _districtMap = {};
  
  static Future<List<Province>> loadAddressData () async {

    if (_provinces.isNotEmpty) {
      return _provinces;
    }
    var address = await rootBundle.loadString('assets/data/address.json');
    var data = json.decode(address);
    if (data is List) {
      for (var v in data) {
        var province = Province.fromJson(v);
        _provinceMap[province.provinceid] = province;
        _provinces.add(province);
      }
    }
    return _provinces;
  }

  static Future<Province?> getProvince(String provinceId) async {
    if (_provinceMap.isEmpty) {
      var provinces = await loadAddressData();
      if (provinces.isNotEmpty) {
        return _provinceMap[provinceId];
      }
      return null;
    } else {
      return _provinceMap[provinceId];
    }
  }

  static Future<City?> getCity( String cityId) async {
    if (_cityMap.isEmpty) {
      var provinces = await loadAddressData();
      if (provinces.isNotEmpty) {
        return _cityMap[cityId];
      }
      return null;
    } else {
      return _cityMap[cityId];
    }
  }

  static Future<District?> getDistrict(String districtId) async {
    if (_districtMap.isEmpty) {
      var provinces = await loadAddressData();
      if (provinces.isNotEmpty) {
        return _districtMap[districtId];
      }
      return null;
    } else {
      return _districtMap[districtId];
    }
  }
}
