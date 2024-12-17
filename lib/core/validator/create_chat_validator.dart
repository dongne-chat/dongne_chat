class CreateChatValidator {
  static String? validatorLocation(String? value) {
    if (value?.trim() == '' || value == null) {
      return '위치 정보가 필요합니다.';
    }
  }

  static String? validatorTitle(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '채팅방 이름을 입력해 주세요';
    }

    if (value!.length < 2) {
      return '채팅방 이름은 두 글자 이상이어야 합니다.';
    }
  }

  static String? validatorInfo(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '채팅방 설명을 입력해 주세요';
    }

    if (value!.length < 10) {
      return '채팅방 설명은 열 글자 이상이어야 합니다.';
    }
  }
}
