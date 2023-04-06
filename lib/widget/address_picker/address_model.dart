// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

List<Province> provinceFromJson(String str) => List<Province>.from(json.decode(str).map((x) => Province.fromJson(x)));

String provinceToJson(List<Province> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Province {
    Province({
        required this.id,
        required this.provinceid,
        required this.province,
        required this.lng,
        required this.lat,
        required this.cities,
    });

    final int id;
    final String provinceid;
    final String province;
    final String lng;
    final String lat;
    final List<City> cities;

    factory Province.fromJson(Map<String, dynamic>? json) => Province(
        id: json?["id"],
        provinceid: json?["provinceid"],
        province: json?["province"],
        lng: json?["lng"],
        lat: json?["lat"],
        cities: List<City>.from(json?["cities"].map((x) => City.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "provinceid": provinceid,
        "province": province,
        "lng": lng,
        "lat": lat,
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
    };
}

class City {
    City({
        required this.id,
        required this.city,
        required this.cityid,
        required this.provinceid,
        required this.lng,
        required this.lat,
        required this.district,
    });

    final int id;
    final String city;
    final String cityid;
    final String provinceid;
    final String lng;
    final String lat;
    final List<District> district;

    factory City.fromJson(Map<String, dynamic>? json) => City(
        id: json?["id"],
        city: json?["city"],
        cityid: json?["cityid"],
        provinceid: json?["provinceid"],
        lng: json?["lng"],
        lat: json?["lat"],
        district: List<District>.from(json?["district"].map((x) => District.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "cityid": cityid,
        "provinceid": provinceid,
        "lng": lng,
        "lat": lat,
        "district": List<dynamic>.from(district.map((x) => x.toJson())),
    };
}

class District {
    District({
        required this.id,
        required this.area,
        required this.areaid,
        required this.cityid,
        required this.lng,
        required this.lat,
    });

    final int id;
    final String area;
    final String areaid;
    final String cityid;
    final String lng;
    final String lat;

    factory District.fromJson(Map<String, dynamic>? json) => District(
        id: json?["id"],
        area: json?["area"],
        areaid: json?["areaid"],
        cityid: json?["cityid"],
        lng: json?["lng"],
        lat: json?["lat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "areaid": areaid,
        "cityid": cityid,
        "lng": lng,
        "lat": lat,
    };
}
