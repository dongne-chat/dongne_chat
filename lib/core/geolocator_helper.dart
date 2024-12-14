import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static Future<Position?> getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // 현재 권한이 허용되지 않았을 때 권한 요청하기
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      // 권한 요청 후 결과가 거부일 때 리턴하기
      LocationPermission permission2 = await Geolocator.checkPermission();
      permission2 = await Geolocator.requestPermission();
      if (permission2 == LocationPermission.denied ||
          permission2 == LocationPermission.deniedForever) {
        return null;
      }
    }
    // geolocator로 위치 가져와서 리턴하기
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high, // 위치 정확도
        distanceFilter: 100, // 단위 m당 갱신
      ),
    );

    return position;
  }
}
