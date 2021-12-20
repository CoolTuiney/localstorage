import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/model/users_model.dart';

class Service {
  static late ImagePicker imagePicker;

  static Future<File?> pickImage() async {
    imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    return (image != null) ? File(image.path) : null;
  }

  static Future<String> scanBarcode() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.DEFAULT);
      debugPrint('scan result: $result');
      return result;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return 'unable to detect';
    }
  }

  static Future<List<UserModel>> apiCall() async {
    List<UserModel> userList = [];
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var body = jsonDecode(response.body);

    for (var item in body) {
      UserModel user = UserModel.fromMap(item);
      userList.add(user);
    }
    return userList;
  }
}
