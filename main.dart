import 'dart:io';

import 'pupil.dart';
import 'teacher.dart';
import 'mark.dart';

void main(List<String> args) async {
  //O'zgaruvchilar
  String select = ""; 
  int m = 0;

  while (m == 0) {
    stdout.write(
        "O'quvchi yoki O'qituvchi\nYangi akkaunt ochish - 0\nDasturdan chiqish - QUIT\n\nTanlash: ");
    select = stdin.readLineSync()!;

    if (select == "0") {
      //Yangi akkaunt ochish funksiyasi
      await funcAddAcc();
    } else if (select.toLowerCase() == "quit") {
      m += 1;
    } else if (select.toLowerCase() == "o'qituvchi") {
      await funcTeacher();
    } else if (select.toLowerCase() == "o'quvchi") {
      await funcPupil();
    } else {
      print("\nBunday funksiya yo'q bu dasturda!\n");
    }
  }
}

Future funcAddAcc() async {
  //Yangi akkaunt qo'shish funksiyasi
  //O'zgaruvchilari
  String? select;
  String? login, lessonname;
  String? password, schoolpass;

  stdout.write("\nO'qituvchi yoki O'quvchi\nTanlash: ");
  select = stdin.readLineSync()!;

  if (select.toLowerCase() == "o'qituvchi") {
    //Yangi akkaunt uchun login parollar
    //Login
    stdout.write("Login: ");
    login = stdin.readLineSync()!;
    //Parol
    stdout.write("Parol: ");
    password = stdin.readLineSync()!;
    //Dars beruvchi fani
    stdout.write("Dars beradigan faningiz: ");
    lessonname = stdin.readLineSync()!;
    //Maktab paroli
    stdout.write("Maktab shaxsiy paroli: ");
    schoolpass = stdin.readLineSync()!;

    //Maktabning paroli bilan tekshirish
    if (Teacher.pass == schoolpass) {
      for (var i = 0; i < 15; i++) {
        await Future.delayed(Duration(milliseconds: 50), () {
          stdout.write(".");
        });
      }
      Teacher()
          .addAccount(lessonname: lessonname, login: login, password: password);
      print("\n\nAkkaunt qo'shildi!");
    } else {
      print("Siz shaxsiy parolni xato kiritdingiz !!!\nDastur ");
    }
  } else if (select.toLowerCase() == "o'quvchi") {
    //Yangi akkaunt uchun login parollar
    //Login
    stdout.write("Login: ");
    login = stdin.readLineSync()!;
    //parol
    stdout.write("Parol: ");
    password = stdin.readLineSync()!;
    //Maktab paroli
    stdout.write("Maktab shaxsiy paroli: ");
    schoolpass = stdin.readLineSync()!;

    //Maktab parolini bilan tekshirish
    if (Pupil.schoolpass == schoolpass) {
      for (var i = 0; i < 15; i++) {
        await Future.delayed(Duration(milliseconds: 50), () {
          stdout.write(".");
        });
      }
      Pupil().addAccPupil(login: login, password: password);
      Mark.pupilsmark.add("");
      print("\n\nAkkaunt qo'shildi");
    } else {
      print(
          "Siz maktab shaxsiy parolini xato kiritdingiz!\nMa'lumotlaringizni qaytatdan kiritishga harakat qiling!");
    }
  } else {
    print("Bunday tanlov turi yo'q :(");
  }
}

Future funcTeacher() async {
  //o'qituvchi uchun funksiya
  //o'zgaruvchilar
  String? login, password, pupilname, select;
  int? index, m = 0;

  //Login
  stdout.write("\nLogin: ");
  login = stdin.readLineSync()!;

  //Parol
  stdout.write("Parol: ");
  password = stdin.readLineSync()!;

  //Loginni tekshirish
  if (Teacher.teacherlogin.contains(login)) {
    index = Teacher.teacherlogin.indexOf(login);
    //Parolni tekshirish
    if (password == Teacher.teacherpassword[index]) {
      while (m == 0) {
        //O'quvchilarni chiqarib berish
        print("");
        Pupil.pupillogin.forEach((element) {
          print(element);
        });

        stdout
            .write("\nQaysi o'quvchiga baho qo'yishni xohlaysiz?\nKiriting: ");
        pupilname = stdin.readLineSync()!;

        if (Pupil.pupillogin.contains(pupilname)) {
          //Baho qo'yish
          index = Pupil.pupillogin.indexOf(pupilname);
          print("");
          Mark().prMark(index: index);
          Mark().addMark(index: index);
          print("");
          await funcSearch(soz: "Baholanmoqda");
          Mark().prMark(index: index);

          stdout.write("\nYana baho qo'yishni xohlaysizmi? (Y/N)\nKiriting: ");
          select = stdin.readLineSync()!;
          if (select.toLowerCase() == "y") {
            continue;
          } else {
            break;
          }
        } else {
          print("Bunday o'quvchi yo'q :(");
        }
      }
    } else {
      await funcSearch(soz: "Qidirilmoqda");
      print("Afsuski akkauntingiz paroli xato!\n");
    }
  } else {
    await funcSearch(soz: "Qidirilmoqda");

    print("Afsuski bunday akkaunt mavjud emas!\n");
  }
}

Future funcPupil() async {
  //O'quvchi uchun funksiya
  //o'zgaruvchilar
  String? login, password, select;
  int? index;

  //Login
  stdout.write("\nLogin: ");
  login = stdin.readLineSync()!;
  //parol
  stdout.write("Parol: ");
  password = stdin.readLineSync()!;

  if (Pupil.pupillogin.contains(login)) {
    //Parol tekshirilmoqda
    index = Pupil.pupillogin.indexOf(login);
    if (password == Pupil.pupilpassword[index]) {
      await funcSearch(soz: "Qidirilmoqda");
      print("Topildi!\n");
      Mark().prMark(index: index);
      stdout.write(
          "Akkauntdan chiqish uchun biror bir narsa kiriting!\nKiritish: ");
      select = stdin.readLineSync()!;
      print("");
    } else {
      await funcSearch(soz: "Qidirilmoqda");
      print("Bunday akkaunt yo'q\n");
    }
  } else {
    await funcSearch(soz: "Qidirilmoqda");
    print("Bunday akkaunt yo'q!\n");
  }
}

Future funcSearch({required String soz}) async {
  print("");
  for (var i = 0; i < 3; i++) {
    await Future.delayed(Duration(milliseconds: 50), () {
      stdout.write(".");
    });
  }
  for (var i in soz.split("")) {
    await Future.delayed(Duration(milliseconds: 50), () {
      stdout.write("$i");
    });
  }
  for (var i = 0; i < 3; i++) {
    await Future.delayed(Duration(milliseconds: 50), () {
      stdout.write(".");
    });
  }
  print("");
  print("");
}
