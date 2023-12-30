import 'dart:convert';
import 'dart:developer';
import 'package:business_umbrella/models/request/guest_phone.dart';
import 'package:business_umbrella/models/request/promoter_phone.dart';
import 'package:business_umbrella/models/response/meta.dart';
import 'package:business_umbrella/models/response/meta_result.dart';
import 'package:business_umbrella/utils/Utils.dart';
import '../models/response/login_modles/login_result.dart';
import 'networking.dart';

class EventApiService {
  Future _postData(
      {required String url, String? authToken, Object? body, context}) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: Uri.parse(url), body: body);
    var data = await networkHelper.postData(authToken, context: context);
    return data;
  }

  Future<LoginResult> login(context, String promoterPhone) async {
    log("PhoneRequest: $promoterPhone");
    PromoterPhone request = PromoterPhone(phone: promoterPhone);
    log("PhoneRequestBody: ${request.phone}");
    log("PhoneRequestBodyJson: ${request.toJson()}");

    var response = await _postData(
        context: context,
        url: "${Utils.BASE_URL}${Utils.LOGIN_URL}",
        body: request.toJson());
    log("PhoneResponse: $response");
    var data = json.decode(response);
    LoginResult result = LoginResult.fromJson(data);
    return Future.value(result);
  }

  Future<MetaResponse> userAttend(
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
    MetaResponse result = MetaResponse.fromJson(data);
    return Future.value(result);
  }

  Future<MetaResponse> logout(context, String authToken) async {
    log("LogoutToken: $authToken");

    var response = await _postData(
        authToken: authToken,
        context: context,
        url: "https://umbrella.sa/api/logout");

    log("LogoutResponse: $response");
    var data = json.decode(response);
    MetaResponse result = MetaResponse.fromJson(data);
    return Future.value(result);
  }
}
