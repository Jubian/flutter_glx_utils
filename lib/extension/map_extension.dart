
extension MapExtension on Map {
  adds(String key, dynamic value) {
    this[key] = value ?? '';
  }
}