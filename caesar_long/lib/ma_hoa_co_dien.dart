import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class CaesarCipher {
  static String encrypt(String text, int shift) {
    String keyENG = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String ketQua = "";
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (keyENG.contains(char.toUpperCase())) {
        int num = (keyENG.indexOf(char.toUpperCase()) + shift) % keyENG.length;
        String encryptedChar = (num < 0) ? keyENG[keyENG.length + num] : keyENG[num];
        ketQua += (char == char.toUpperCase()) ? encryptedChar : encryptedChar.toLowerCase();
      } else {
        ketQua += char;
      }
    }
    return ketQua;
  }

  static String decrypt(String text, int shift) {
    String keyENG = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String ketQua = "";
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (keyENG.contains(char.toUpperCase())) {
        int num = (keyENG.indexOf(char.toUpperCase()) - shift) % keyENG.length;
        String decryptedChar = (num < 0) ? keyENG[keyENG.length + num] : keyENG[num];
        ketQua += (char == char.toUpperCase()) ? decryptedChar : decryptedChar.toLowerCase();
      } else {
        ketQua += char;
      }
    }
    return ketQua;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng Mã hóa Caesar',
      home: CaesarCipherApp(),
      debugShowCheckedModeBanner: false, // Loại bỏ chữ debug
    );
  }
}

class CaesarCipherApp extends StatefulWidget {
  @override
  _CaesarCipherAppState createState() => _CaesarCipherAppState();
}

class _CaesarCipherAppState extends State<CaesarCipherApp> {
  TextEditingController textController = TextEditingController();
  int shift = 3; // Giá trị mặc định của shift
  String encryptedText = "";
  String decryptedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ứng dụng Mã hóa Caesar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Nhập vào văn bản'),
              onSubmitted: (value) {
                textController.text += '\n'; // Thêm dấu xuống dòng khi nhấn Enter
              },
              keyboardType: TextInputType.multiline, // Cho phép nhập nhiều dòng
              maxLines: null, // Cho phép nhập nhiều dòng
            ),
            SizedBox(height: 16),
            Text(
              'Dịch chuyển: $shift',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: shift.toDouble(),
              min: 0,
              max: 25,
              divisions: 25,
              onChanged: (value) {
                setState(() {
                  shift = value.round();
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String text = textController.text;
                setState(() {
                  encryptedText = CaesarCipher.encrypt(text, shift);
                  decryptedText = ""; // Đặt lại văn bản giải mã khi văn bản mới được mã hóa
                });
              },
              child: Text('Mã hóa'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String text = textController.text;
                setState(() {
                  decryptedText = CaesarCipher.decrypt(text, shift);
                  encryptedText = ""; // Đặt lại văn bản mã hóa khi văn bản mới được giải mã
                });
              },
              child: Text('Giải mã'),
            ),
            SizedBox(height: 16),
            Text(
              'Văn bản đã mã hóa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              encryptedText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Văn bản đã giải mã:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              decryptedText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
