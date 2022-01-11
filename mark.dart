import 'dart:io';

class Mark {
  static List pupilsmark = ["5455"];

  void prMark({required int index}) {
    print("Baholar: ");
    String soz = pupilsmark[index];
    if (soz == "") {
      print("\nBaholar hali qo'yilmagan!\n");
    } else {
      for (var i = 0; i < soz.length; i++) {
        stdout.write("${soz[i]} ");
      }
      print("");
    }
  }

  void addMark({required int index}) {
    int? mark;
    stdout.write("Bahoni kiriting: ");
    mark = int.parse(stdin.readLineSync()!);
    pupilsmark[index] += "$mark";
  }
}
