import 'dart:convert';
import 'dart:developer';
import 'package:business_umbrella/models/request/guest_phone.dart';
import 'package:business_umbrella/models/request/promoter_login.dart';
import 'package:business_umbrella/models/request/promoter_phone.dart';
import 'package:business_umbrella/models/request/promoter_register.dart';
import 'package:business_umbrella/models/response/meta_result.dart';
import 'package:business_umbrella/utils/Utils.dart';
import 'package:http/http.dart';
import '../models/response/login_modles/access_token.dart';
import '../models/response/login_modles/login_result.dart';
import '../models/response/meta_response.dart';
import '../utils/shared_prefrences.dart';
import 'networking.dart';

class EventApiService {
  Future _postData(
      {required String url, String? authToken, Object? body, context}) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: Uri.parse(url), body: body);
    var data = await networkHelper.postData(authToken, context: context);
    return data;
  }

/*  bool loginPhoneBySharedPref(String inputPhone) {
    bool response = false;
    PreferenceUtils.setString(Utils.CHECK_PHONE, "01122334455");
    var getPhone = PreferenceUtils.getString(Utils.CHECK_PHONE);

    if (inputPhone.isNotEmpty) {
      if (getPhone == inputPhone) {
        response = true;
      } else {
        response = true;
      }
    } else {
      response = false;
    }

    return response;
  }

  bool loginPassBySharedPref(String inputPass) {
    var response;
    // todo isGetPass null redirect to active phone
    var getPass = PreferenceUtils.getString(Utils.CHECK_New_Password);

    if (getPass.isNotEmpty) {
      if (getPass == inputPass) {
        response = true;
      } else {
        response = false;
      }
    } else {
      response = false;
    }

    return response;
  }*/

  bool setNewPassword(String newPass) {
    bool response = false;
    PreferenceUtils.setString(Utils.CHECK_New_Password, "1234");
    var getPass = PreferenceUtils.getString(Utils.CHECK_New_Password);
    if (newPass.isNotEmpty && newPass == getPass) {
      response = true;
    }
    return response;
  }

  Future<MetaResult> register(context, RegisterRequest promoterRegister) async {
    log("RegisterRequestBodyJson: ${promoterRegister.toJson()}");

    var response = await _postData(
        context: context,
        url: "${Utils.BASE_URL}${Utils.REGISTER_URL}",
        body: promoterRegister.toJson());
    log("PhoneResponse: $response");
    var data = json.decode(response);
    MetaResult result = MetaResult.fromJson(data);
    return Future.value(result);
  }

  Future<AccessToken> login(context, LoginRequest loginRequest) async {
    log("LoginRequestBodyJson: ${loginRequest.toJson()}");

    var response = await _postData(
        context: context,
        url: "${Utils.BASE_URL}${Utils.LOGIN_URL}",
        body: loginRequest.toJson());
    log("PhoneResponse: $response");
    var data = json.decode(response);
    AccessToken result = AccessToken.fromJson(data);
    return Future.value(result);
  }

  Future<MetaResult> userAttend(
      context, String authToken, String guestPhone) async {
    log("PhoneRequest: $guestPhone");
    GuestPhone request = GuestPhone(guestPhone: guestPhone);
    log("PhoneRequestBody: ${request.guestPhone}");
    log("PhoneRequestBodyJson: ${request.toJson()}");

    var response = await _postData(
        authToken: authToken,
        context: context,
        url: "https://umbrella.sa/api/guest/attend",
        body: request.toJson());
    log("PhoneResponse: $response");
    var data = json.decode(response);
    MetaResult result = MetaResult.fromJson(data);
    return Future.value(result);
  }

  Future<MetaResponse> logout(context, String authToken) async {
    log("LogoutToken: $authToken");

    var response = await _postData(
        authToken: authToken,
        context: context,
        url: "${Utils.BASE_URL}${Utils.LOGOUT_URL}");
        // url: "https://umbrella.sa/api/logout");

    log("LogoutResponse: $response");
    log("LogoutResponse: ${json.decode(response)}");
    var data = json.decode(response);
    MetaResponse result = MetaResponse.fromJson(data);
    return Future.value(result);
  }
}
