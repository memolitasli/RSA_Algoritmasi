import 'package:flutter/material.dart';
// 17010011024 Mehmet Taşlı
void main() {
  runApp(MaterialApp(
    routes:{
      "/":(context)=>anaSayfa(),
    }
  ));
}

class anaSayfa extends StatefulWidget {
  @override
  _anaSayfaState createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {
  String metin;
  int p = 13,q = 19;
  int n,d,e,fi;
  String textMetin = "Şifrelenmemiş Metin";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // n,d,e,fi değerlerini oluşturan fonksiyonu program çalışmaya başladığında çağırıyorum
    degerleriOlustur();
  }

  // programda tasarımın yapıldığı kısım
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hazırlayan : Mehmet Taşlı 17010011024"),
            Text("p = 13,q = 19 , n = 247, fi = 216, e = 11, d = 59"),
            TextField(
              decoration: InputDecoration(hintText: "Şifrelenmesini istediğiniz metni giriniz"),
              onChanged: (value){
                setState(() {
                  metin = value;
                });
              },
            ),
            RaisedButton(onPressed: (){
             setState(() {
               metin = sifrele();
               textMetin = "Şifrelenmiş Metin";
             });
            },child: Row(children: [Icon(Icons.lock),Text("Şifrele")],),),
            RaisedButton(onPressed: (){
              setState(() {
                metin = sifrecoz();
                textMetin = "Şifresi Çözülmüş Metin";
              });
            },child: Row(children: [Icon(Icons.lock_open),Text("Şifre Çöz")],),),
            SizedBox(height: 20,),
            Text("$textMetin : $metin"),
          ],
        ),
      ),
    );
  }

  //e , d, fi n değerlerinin hesaplandığı fonksiyon
  void degerleriOlustur(){
    n = p*q;
    fi = (p-1) * (q-1);
    e = 11;
    int i = 1;
    while(true){
      if((e*i) % fi == 1){
        d = i;
        break;
      }
      i++;
    }
  }

  // kullanıcıdan alınan metnin şifrelendiği fonksiyon
  String sifrele() {
// kullanıcının girdiği string metnin harflerini ascii değerlerine dönüştürüp integer bir liste içerisine atıyorum
    List<int> asciiList = metin.codeUnits;
    List<int> sifrelenmisListe = List<int>();
    debugPrint("Sifresiz Hali : $asciiList");
    //sifrelimetin = sifresizmetin^e mod n bu işlemi pow(sifresizmetin, e) olarak yapmak yerine iç içe 2 adet döngü kullanarak yaptım
    // bunun nedeni e = 11 , d = 59 ve örneğin m harfinin ascii değeri 109 ve 109 üzeri 59 un sonucu integer aralığının dışına çıkıyor bu nedenle şifreleme ve
    // şifre çözme işlemleri hatalı sonuçlanıyor
    // bunun yerine iç içe 2 adet for döngüsü ile her seferinde 109 un e deki modunu alıyorum çıkan sonucu değer adlı başlangıç değeri 1 olan
    // bir değişkenle çarpıyorum bu sayede integer sınırlarını aşmadan üst işlemini almış ve % n işlemini gerçekleştirip şifrelemiş oluyorum
    for (int i = 0; i < asciiList.length; i++) {
      int deger = 1;
      for (int j = 0; j < e; j++) {
        deger = (deger * asciiList[i]) % n;
      }
      // şifrelenmiş değerleri şifrelenmisListe adlı bir liste içerisinde tutuyorum
      sifrelenmisListe.add(deger);
    }
    debugPrint("Şifreli hali : $sifrelenmisListe");
    // Şifrelenmiş verilerden oluşan int türündeki sifreliListe adlı listeyi String.fromCharCodes fonksiyoru ile String bir veriye fönüştürüyorum
    String donenMetin = String.fromCharCodes(sifrelenmisListe);
    debugPrint("Şifreli Metin : $donenMetin");
    // oluşan string değeri geri döndürüyorum
    return donenMetin;

  }


  //Şifrelenmiş verinin çözüldüğü fonksiyon
  String sifrecoz() {
    // Şifreli metni int türünden veriler tutan bir liste içerisine ascii değerleri olacak biçimde ekliyorum
    List<int> asciiList = metin.codeUnits;
    List<int> cozulmusMetin = List<int>();
    // yşifreleme fonksiyonunda anlattığım gibi üst alma işlemi sonucunda çıkan değer integer veri tipinin sınırlarında  yüsek olabileceği için
    // pow fonksiyonu yerine iç içe döngüler ile üst alma ve mod alma işlemşini gerçekleştiriyorum
    for (int i = 0; i < asciiList.length; i++) {
      int deger = 1;
      for (int j = 0; j < d; j++) {
        deger = (deger * asciiList[i]) % n;
      }
      cozulmusMetin.add(deger); // şifresi çözülmüş değerleri cozulmusMetin adlı int değerler tutan bir listeye ekliyorum
    }
    debugPrint("cözülmus hali : $cozulmusMetin");
    String donenMetin = String.fromCharCodes(cozulmusMetin); // int listeyi String.fromCharCodes adlı fonksiyon ile ascii den string e dönüştürüyorum
    return donenMetin; // çözülmüş olan metni geri döndürüyorum

  }
}
