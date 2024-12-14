import 'package:dongne_chat/core/geolocator_helper.dart';
import 'package:dongne_chat/data/repository/location_repository.dart';
import 'package:riverpod/riverpod.dart';

LocationRepository locationRepository = LocationRepository();

class CreateChatViewModel extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void searchByLatLng() async {
    final position = await GeolocatorHelper.getPosition();
    final result = await locationRepository.findByLatLng(
      position!.latitude,
      position!.longitude,
    );

    state = (result != null) ? result.split(' ').last : null;
  }
}

final createChatViewModelProvider =
    NotifierProvider<CreateChatViewModel, String?>(() => CreateChatViewModel());
