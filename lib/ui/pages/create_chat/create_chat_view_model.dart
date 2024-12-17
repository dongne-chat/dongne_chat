import 'package:dongne_chat/core/geolocator_helper.dart';
import 'package:dongne_chat/data/repository/dongne_list_repository.dart';
import 'package:dongne_chat/data/repository/location_repository.dart';
import 'package:riverpod/riverpod.dart';

LocationRepository locationRepository = LocationRepository();

class CreateChatViewModel extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  // 위치 가져오기
  void searchByLatLng() async {
    final position = await GeolocatorHelper.getPosition();
    final result = await locationRepository.findByLatLng(
      position!.latitude,
      position!.longitude,
    );

    state = (result != null) ? result.split(' ').last : null;
  }

  // 채팅방 생성
  Future<bool> createChat({
    required String title,
    required String info,
    required String category,
    required List users,
    required String address,
    required String createdUser,
  }) async {
    print('createChat');
    try {
      await DongneListRepository().create(
        title: title,
        info: info,
        category: category,
        users: users,
        address: address,
        createdUser: createdUser,
      );
      return true;
    } catch (e) {
      print('CreateChatViewModel::create : $e');
      return false;
    }
  }
}

final createChatViewModelProvider =
    NotifierProvider<CreateChatViewModel, String?>(() => CreateChatViewModel());
