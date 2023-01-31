import 'dart:io';

void main() {
  String productName = "Ayaqqabi";
  num productPrice = 78;
  int productCount = 2;
  num umumi = productPrice * productCount;
  num cardBalance = 200;

  print("enter username");
  String? userName = stdin.readLineSync();
  print("enter password");
  String? code = stdin.readLineSync();

  if (userName == "polad" && code == "1234") {
    print("successful");
  } else {
    print("wrong");
    print("do you want to try again? - [y/n]");
    String? cavab = stdin.readLineSync();
    if (cavab == "y") {
      main();
    } else {
      return;
    }
  }

  print("****************************");
  print('\nsebetde olan mehsul: $productName \nmehsul sayi: $productCount \numumi odenilecek mebleg: $umumi \n');
  print("****************************");
  print("\nodeme usulunu secin: \n1.card\n2.nagd\n3.kredit");

  int? number = int.parse(stdin.readLineSync()!);

  if (number == 1) {
    print("kart datalarini daxil edin: ");
    String? sjs = stdin.readLineSync();
    print("balansinizdan $umumi manat mebleg cixildi, balansiniz ${cardBalance - umumi} manat");
  } else if (number == 2) {
    print("addresi daxil edin");
    String? adres = stdin.readLineSync();
    print("mehsul bu adrese gonderilecek: $adres");
  } else if (number == 3) {
    print("\nbanki secin: ");
    print("1.kapital\n2.pasha");
    int? bankchoosen = int.parse(stdin.readLineSync()!);
    print("\nkredit teklifleri:");

    switch (bankchoosen) {
      case 1:
        print("1.3 ayliq taksit \n2.6 ayliq taksit \n3.birbasa");
        int? taksitChoosen = int.parse(stdin.readLineSync()!);
        if (taksitChoosen == 1) {
          print("balansinizdan ${umumi + umumi * 0.2} manat mebleg cixilacaq, ayliq mebleg- ${(umumi + umumi * 0.2) / 3}");
          break;
        } else if (taksitChoosen == 2) {
          print("balansinizdan ${umumi + umumi * 0.3} manat mebleg cixilacaq, ayliq mebleg- ${(umumi + umumi * 0.3) / 6}");
          break;
        } else {
          print("balansinizdan birbasa ${umumi} manat mebleg cixilacaq");
        }
        break;

      case 2:
        print("1.2 ayliq taksit \n2.4 ayliq taksit \n3.birbasa");
        String? taksitchoosen = stdin.readLineSync();
        if (taksitchoosen == 1) {
          print("balansinizdan ${umumi + umumi * 0.1} manat mebleg cixilacaq, ayliq mebleg- ${(umumi + umumi * 0.1) / 2}");
          break;
        } else if (taksitchoosen == 2) {
          print("balansinizdan ${umumi + umumi * 0.15} manat mebleg cixilacaq, ayliq mebleg- ${(umumi + umumi * 0.15) / 4}");
          break;
        } else {
          print("balansinizdan birbasa ${umumi} manat mebleg cixilacaq");
        }
        break;
      default:
        print("Error");
        break;
    }
  }
}
