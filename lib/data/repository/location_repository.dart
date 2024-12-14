import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationRepository {
  final Dio _client = Dio(BaseOptions(
    validateStatus: (status) => true, // 설정 안할시 실패 응답 오면 throw 던져서 에러 발생함
  ));

  // 위도/경도로 검색
  Future<String?> findByLatLng(double lat, double lng) async {
    try {
      final response =
          await _client.get('https://api.vworld.kr/req/data', queryParameters: {
        'request': 'GetFeature',
        'key': dotenv.get('VWORLD_KEY'),
        'data': 'LT_C_ADEMD_INFO',
        'geomFilter': 'POINT($lng $lat)',
        'geometry': 'false',
        'size': '100',
      });

      if (response.statusCode == 200 &&
          response.data['response']['status'] ==
              ''
                  'OK') {
        final fullName = response.data['response']['result']
            ['featureCollection']['features'][0]['properties']['full_nm'];

        return fullName;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 이름으로 검색
  Future<List<String>> findByName(String query) async {
    try {
      final response = await _client
          .get('https://api.vworld.kr/req/search', queryParameters: {
        'request': 'search',
        'key': dotenv.get('VWORLD_KEY'),
        'query': query,
        'type': 'DISTRICT',
        'category': 'L4',
      });

      if (response.statusCode == 200 &&
          response.data['response']['status'] ==
              ''
                  'OK') {
        final itmes = response.data['response']['result']['items'];
        final itemList = List.from(itmes);

        final iterable = itemList.map((item) {
          return '${item['title']}';
        });
        return iterable.toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
