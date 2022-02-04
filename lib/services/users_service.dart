import 'dart:convert';
import 'dart:developer';

import 'package:halosistest/models/login_model.dart';
import 'package:halosistest/models/users_model.dart';
import 'package:halosistest/utils/url_utils.dart';
import 'package:http/http.dart' as http;

class UsersService {
  http.Response? response;

  Future<StatusLoginModel> login(String body) async {
    print("masuk api " + body);

    Map<String, String> headers = {
      'Content-Type': "application/json",
    };

    // Map body = {'email_user': email, 'password': password};

    String apiURL = loginURL;

    response = await http.post(Uri.parse(apiURL), body: body, headers: headers);

    print("body " + response!.body);
    var databody = json.decode(response!.body);

    if (response!.statusCode == 200) {
      return StatusLoginModel(message: databody['token'], status: true);
    } else {
      return StatusLoginModel(message: databody['error'], status: false);
    }

    // StatusLoginModel

    return StatusLoginModel.fromJson(databody);
  }

  Future<UsersModel> getListUsers(page) async {
    print("Get Users List");

    String apiURL = listUsersURL + "?page=${page}";
    print(apiURL);

    response = await http.get(Uri.parse(apiURL));

    log("body " + response!.body);
    var databody = json.decode(response!.body);

    // if (databody['code'] != 200 || databody['data'] == null) {
    //   return UsersModel.empty();
    // }

    return UsersModel.fromJson(databody);
  }
}
