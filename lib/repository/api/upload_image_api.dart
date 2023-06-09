import 'dart:io';
import 'package:estok_app/app/shared/constants.dart';
import '../local/user_repository.dart';
import '../../entities/user.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class UploadImageApi{


  final http.Client _client;
  final UserRepository _userRepository;

  static final UploadImageApi instance = UploadImageApi._(http.Client(),UserRepository.instance);

  UploadImageApi._(this._client,this._userRepository);

 Future<String> uploadImage(File imageFile) async {

    try {

      String url = Constants.BASE_URL_API + "images/upload";
      User user = await _userRepository.getUser();
      String authorization = "Bearer ${user.token}";
      
      List<int> imageBytes = imageFile.readAsBytesSync();
      String imageBase64 = convert.base64Encode(imageBytes);
      String fileName = path.basename(imageFile.path);

      var params ={
        "file_name": fileName,
        "mime_type":"image/jpeg",
        "base64": imageBase64,
      };

      var encode = convert.json.encode(params);

      //print("LOG[UploadAPI.uploadFile] - url: $url");
      //print("LOG[UploadAPI.uploadFile] - authorization: ${user.token}");
      //print("LOG[UploadAPI.uploadFile] - encode: $encode");

      var response = await _client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authorization
        },
        body: encode,
      ).timeout(Duration(seconds: 120),onTimeout: (){
        print("LOG[UploadAPI.uploadFile] - onTimeOut: $encode");
        throw SocketException("Não foi possível se comunicar com o servidor");
      });

      if (response.statusCode == 200) {
        var responseData = convert.json.decode(convert.utf8.decode(response.bodyBytes));
        //print("LOG[UploadAPI.uploadFile] - responseData: $responseData");
        return responseData["data"]["url_image"];

      } else {
        //print("LOG[UploadAPI.uploadFile] - Erro: ${response.statusCode}");
        return null;
      }
    } on Exception catch (error) {
      print("Exception: failed add Stock: $error");
      return null;
    }
  }
}