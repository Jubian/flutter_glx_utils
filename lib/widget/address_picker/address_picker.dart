library address_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'address_manager.dart';
import 'address_model.dart';

class Address {
  Province? currentProvince;
  City? currentCity;
  District? currentDistrict;

  Address({this.currentProvince,  this.currentCity,  this.currentDistrict});
}

class AddressName {
  String? currentProvince;
  String? currentCity;
  String? currentDistrict;

  AddressName({this.currentProvince,  this.currentCity,  this.currentDistrict});
}

typedef AddressCallback = void Function(Address);

enum AddressPickerMode {
  province,
  provinceAndCity,
  provinceCityAndDistrict,
}

class AddressPicker extends StatelessWidget {

  /// 选中的地址发生改变回调
  final AddressCallback? onSelectedAddressChanged;

  /// 选择模式
  /// province 一级: 省
  /// provinceAndCity 二级: 省市 
  /// provinceCityAndDistrict 三级: 省市区
  final AddressPickerMode mode;
  
  /// 省市区文字显示样式
  final TextStyle style;

  final AddressName? inital;

  const AddressPicker(
      {Key? key,
      this.mode = AddressPickerMode.provinceCityAndDistrict,
      this.onSelectedAddressChanged,
      this.inital,
      this.style = const TextStyle(color: Colors.black, fontSize: 17)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Province>>(
      future: AddressManager.loadAddressData(),
      builder: (ctx, state) {
        if (state.connectionState == ConnectionState.done) {
          return _AddressPicker(
            key: key,
            provinces: state.data!,
            mode: mode,
            onSelectedAddressChanged: onSelectedAddressChanged,
            inital: inital,
            style: style,
          );
        }
        return Container();
      }
    );
  }
}

class _AddressPicker extends StatefulWidget {
  final List<Province> provinces;
  /// 选中的地址发生改变回调
  final AddressCallback? onSelectedAddressChanged;

  /// 选择模式
  /// province 一级: 省
  /// provinceAndCity 二级: 省市 
  /// provinceCityAndDistrict 三级: 省市区
  final AddressPickerMode mode;
  
  /// 省市区文字显示样式
  final TextStyle style;

  final AddressName? inital;

  const _AddressPicker(
      {Key? key,
      required this.provinces,
      required this.mode,
      this.onSelectedAddressChanged,
      this.inital,
      required this.style})
      : super(key: key);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<_AddressPicker> {

  Province? _selectedProvince;
  City? _selectedCity;
  District? _selectedDistrict;

  late FixedExtentScrollController _provinceScrollController;
  late FixedExtentScrollController _cityScrollController;
  late FixedExtentScrollController _districtScrollController;

  @override
  void dispose() {
    _cityScrollController.dispose();
    _districtScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedProvince = widget.provinces.first;
    _selectedCity = _selectedProvince?.cities.first;
    _selectedDistrict = _selectedCity?.district.first;
    var initialProvince = 0;
    var initialCity = 0;
    var initialDistrict = 0;
    if (widget.inital != null) {
      for (var i = 0; i < widget.provinces.length; i++) {
        final province = widget.provinces[i];
        if (province.province == widget.inital!.currentProvince) {
          initialProvince = i;
          _selectedProvince = province;
          for (var j = 0; j < province.cities.length; j++) {
            final city = province.cities[j];
            if (city.city == widget.inital!.currentCity) {
              initialCity = j;
              _selectedCity = city;
              for (var n = 0; n < city.district.length; n++) {
                final district = city.district[n];
                if (district.area == widget.inital!.currentDistrict) {
                  initialDistrict = n;
                  _selectedDistrict = district;
                }
              }
            }
          }
        }
      }
    }
    _provinceScrollController = FixedExtentScrollController(initialItem: initialProvince);
    _cityScrollController = FixedExtentScrollController(initialItem: initialCity);
    _districtScrollController = FixedExtentScrollController(initialItem: initialDistrict);

    _updateCurrent();
  }

  void _updateCurrent() {
    if (widget.onSelectedAddressChanged != null) {
      var address = Address(
          currentProvince: _selectedProvince,
          currentCity: _selectedCity,
          currentDistrict: _selectedDistrict);
      if (widget.onSelectedAddressChanged != null) {
        widget.onSelectedAddressChanged!(address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.provinces.isEmpty) {
      return Container();
    }

    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CupertinoPicker.builder(
              scrollController: _provinceScrollController,
              backgroundColor: Colors.white,
              childCount: widget.provinces.length,
              itemBuilder: (context, index) {
                var item = widget.provinces[index];
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    item.province,
                    style: widget.style,
                  ),
                );
              },
              itemExtent: 44,
              onSelectedItemChanged: (item) {
                setState(() {
                  _selectedProvince = widget.provinces[item];
                  _selectedCity = _selectedProvince?.cities.first;
                  _selectedDistrict = _selectedCity?.district.first;
                });
                _cityScrollController.jumpToItem(0);
                _districtScrollController.jumpToItem(0);
                _updateCurrent();
              },
            ),
          ),
          widget.mode == AddressPickerMode.province
              ? Container()
              : Expanded(
                  flex: 1,
                  child: CupertinoPicker.builder(
                    scrollController: _cityScrollController,
                    backgroundColor: Colors.white,
                    childCount: _selectedProvince?.cities.length,
                    itemBuilder: (context, index) {
                      var item = _selectedProvince?.cities[index];
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          item == null ? '' : item.city,
                          style: widget.style,
                        ),
                      );
                    },
                    itemExtent: 44,
                    onSelectedItemChanged: (item) {
                      setState(() {
                        _selectedCity = _selectedProvince?.cities[item];
                        _selectedDistrict = _selectedCity?.district.first;
                      });
                      _districtScrollController.jumpToItem(0);
                      _updateCurrent();
                    },
                  )),
          widget.mode != AddressPickerMode.provinceCityAndDistrict
              ? Container()
              : Expanded(
                  flex: 1,
                  child: CupertinoPicker.builder(
                    scrollController: _districtScrollController,
                    backgroundColor: Colors.white,
                    childCount: _selectedCity?.district.length,
                    itemBuilder: (context, index) {
                      var item = _selectedCity?.district[index];
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          item == null ? '' : item.area,
                          style: widget.style,
                        ),
                      );
                    },
                    itemExtent: 44,
                    onSelectedItemChanged: (item) {
                      var district = _selectedCity?.district[item];
                      _selectedDistrict = district;
                      _updateCurrent();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
