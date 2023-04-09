import 'dart:math';

class StringUtil {
  static String generateRandomString() {
    String letters = 'abcdefghijklmnopqrstuvwxyz';
    String randomString = '';

    for (int i = 0; i < 4; i++) {
      String letter = letters[Random().nextInt(26)];
      while (randomString.contains(letter)) {
        letter = letters[Random().nextInt(26)];
      }
      randomString += letter;
    }

    for (int i = 0; i < 3; i++) {
      int number = Random().nextInt(10);
      while (randomString.contains(number.toString())) {
        number = Random().nextInt(10);
      }
      randomString += number.toString();
    }

    return randomString;
  }
}