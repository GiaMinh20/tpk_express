import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpk_express/models/request/account_info_request.dart';
import 'package:tpk_express/models/request/cancel_order_request.dart';
import 'package:tpk_express/models/request/tracking_request.dart';
import 'package:tpk_express/models/request/update_device_request.dart';
import 'package:tpk_express/models/tracking_response.dart';
import 'package:http/http.dart' as http;

import '../environment/environment.dart';
import '../models/account_info_response.dart';
import '../models/contact_config_response.dart';
import '../models/dashboard_response.dart';
import '../models/recharge_response.dart';
import '../models/request/base_request.dart';
import '../models/request/create_tracking_request.dart';
import '../models/request/create_transportation_request.dart';
import '../models/request/list_transportation_request.dart';
import '../models/request/notification_request.dart';
import '../models/request/recharge_request.dart';
import '../models/request/sign_in_request.dart';
import '../models/request/sign_up_request.dart';
import '../models/response_api.dart';
import '../models/statistics_response.dart';
import '../models/transport_fee_response.dart';
import '../models/user_data.dart';
import '../models/voucher_response.dart';
import '../models/warehouse_shiptype_response.dart';

class WebHookProvider extends GetConnect {
  String url = '${Environment.apiUrl}/webservice1.asmx';

  UserData userDataSession =
      UserData.fromJson(GetStorage().read('userData') ?? {});

  BaseRequest? baseRequest;

  WebHookProvider() {
    if (userDataSession.key != null && userDataSession.uid != null) {
      baseRequest = BaseRequest(
        key: userDataSession.key!,
        uid: userDataSession.uid!,
      );
    }
  }

  Future<List<VoucherResponse>> getVouchers() async {
    List<VoucherResponse> responses = [];
    Response response =
        await post('$url/ListVoucher', baseRequest!.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return responses;
    }
    try {
      ResponseApi responseApi = ResponseApi.fromJson(response.body!);

      if (responseApi.status == 'Success' && responseApi.data != null) {
        responses = VoucherResponse.fromJsonList(responseApi.data);
        return responses;
      } else if (responseApi.logout == '1') {
        logOut(responseApi);
        return responses;
      } else {
        return responses;
      }
    } catch (e) {
      return responses;
    }
  }

  Future<ResponseApi> cancelRecharge(CancelOrderRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    ResponseApi responseApi = ResponseApi();
    Response response =
        await post('$url/CancelRecharge', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return responseApi;
    }
    responseApi = ResponseApi.fromJson(response.body!);
    return responseApi;
  }

  Future<List<RechargeResponse>> getRecharges() async {
    List<RechargeResponse> rechargeResponses = [];
    Response response =
        await post('$url/ListRecharge', baseRequest!.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return rechargeResponses;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      rechargeResponses = RechargeResponse.fromJsonList(responseApi.data);
      return rechargeResponses;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return rechargeResponses;
    } else {
      return rechargeResponses;
    }
  }

  Future<bool> createRecharge(RechargeRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    try {
      Response response =
          await post('$url/Recharge', request.toJson(), headers: {
        'Content-Type': 'application/json',
      });
      if (response.body == null) {
        return false;
      }
      ResponseApi responseApi = ResponseApi.fromJson(response.body!);
      if (responseApi.status == 'Success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ResponseApi?> getTotalNotification() async {
    Response response =
        await post('$url/TotalNotification', baseRequest!.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return null;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.totalPage != null) {
      return responseApi;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return null;
    } else {
      return null;
    }
  }

  Future<ResponseApi?> getListNotification(NotificationRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    Response response =
        await post('$url/ListNotification', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return null;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      return responseApi;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return null;
    } else {
      return null;
    }
  }

  Future<TransportFeeResponse> transOrderDetail(TrackingRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    TransportFeeResponse transportFeeResponse = TransportFeeResponse();
    Response response =
        await post('$url/TransOrderDetail', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return transportFeeResponse;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      transportFeeResponse = TransportFeeResponse.fromJson(responseApi.data);
      return transportFeeResponse;
    } else {
      return transportFeeResponse;
    }
  }

  Future<TransportFeeResponse> createTracking(
      CreateTrackingRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    TransportFeeResponse transportFeeResponse = TransportFeeResponse();
    Response response =
        await post('$url/CreateTracking', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return transportFeeResponse;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      transportFeeResponse = TransportFeeResponse.fromJson(responseApi.data);
      return transportFeeResponse;
    } else {
      return transportFeeResponse;
    }
  }

  Future<ContactConfigResponse> getContactConfig() async {
    ContactConfigResponse contactConfigResponse = ContactConfigResponse();
    Response response = await post('$url/ContactConfig', {}, headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return contactConfigResponse;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      contactConfigResponse = ContactConfigResponse.fromJson(responseApi.data);
      return contactConfigResponse;
    } else {
      return contactConfigResponse;
    }
  }

  Future<void> updateDevice(UpdateDeviceRequest request) async {
    await post('$url/UpdateDeviceToken', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
  }

  Future<Stream> uploadImage(File image) async {
    Uri uri = Uri.parse('$url/UploadFile');
    final request = http.MultipartRequest('POST', uri);
    var multipartFile = await http.MultipartFile.fromPath('file', image.path);
    request.files.add(multipartFile);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> updateAccountInfo(AccountInfoRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    ResponseApi responseApi = ResponseApi();
    Response response =
        await post('$url/UpdateAccountInfo', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return responseApi;
    }
    responseApi = ResponseApi.fromJson(response.body!);
    return responseApi;
  }

  Future<AccountInfoResponse?> getAccountInfo() async {
    Response response =
        await post('$url/AccountInfo', baseRequest!.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return null;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      return AccountInfoResponse.fromJson(responseApi.data);
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return null;
    } else {
      return null;
    }
  }

  Future<ResponseApi> cancelOrder(CancelOrderRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    ResponseApi responseApi = ResponseApi();
    Response response =
        await post('$url/CancelOrder', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return responseApi;
    }
    responseApi = ResponseApi.fromJson(response.body!);
    return responseApi;
  }

  Future<TrackingResponse> tracking(TrackingRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;

    TrackingResponse trackingResponse = TrackingResponse();

    Response response = await post('$url/Tracking', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return trackingResponse;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    if (responseApi.status == 'Success' && responseApi.data != null) {
      trackingResponse = TrackingResponse.fromJson(responseApi.data);
      return trackingResponse;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return trackingResponse;
    } else {
      return trackingResponse;
    }
  }

  Future<ResponseApi> paymentStatistic(CancelOrderRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    ResponseApi responseApi = ResponseApi();
    Response response =
        await post('$url/PaymentStatistic', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return responseApi;
    }
    responseApi = ResponseApi.fromJson(response.body!);
    return responseApi;
  }

  Future<List<StatisticResponse>> getStatistic() async {
    List<StatisticResponse> statistics = [];
    Response response =
        await post('$url/ListStatistic', baseRequest!.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return statistics;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      statistics = StatisticResponse.fromJsonList(responseApi.data);
      return statistics;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return statistics;
    } else {
      return statistics;
    }
  }

  Future<ResponseApi> createTransportation(
      CreateTransportationRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    ResponseApi responseApi = ResponseApi();
    Response response =
        await post('$url/CreateTransportation', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return responseApi;
    }
    responseApi = ResponseApi.fromJson(response.body!);
    return responseApi;
  }

  Future<WarehouseShipType> getWarehouseShipType() async {
    WarehouseShipType warehouseShipType = WarehouseShipType();
    Response response = await post('$url/WarehouseShipType', {}, headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return warehouseShipType;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      warehouseShipType = WarehouseShipType.fromJson(responseApi.data);
      return warehouseShipType;
    } else {
      return warehouseShipType;
    }
  }

  Future<ResponseApi?> getListTransportation(
      ListTransportationRequest request) async {
    request.uid = userDataSession.uid!;
    request.key = userDataSession.key!;
    Response response =
        await post('$url/ListTransportation', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return null;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      return responseApi;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return null;
    } else {
      return null;
    }
  }

  Future<List<Dashboard>> getDashboard() async {
    List<Dashboard> dashboards = [];
    Response response =
        await post('$url/Dashboard', baseRequest!.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return dashboards;
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body!);
    if (responseApi.status == 'Success' && responseApi.data != null) {
      dashboards = Dashboard.fromJsonList(responseApi.data);
      return dashboards;
    } else if (responseApi.logout == '1') {
      logOut(responseApi);
      return dashboards;
    } else {
      return dashboards;
    }
  }

  Future<ResponseApi> signIn(SignInRequest request) async {
    Response response = await post('$url/Login', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> signUp(SignUpRequest request) async {
    Response response = await post('$url/Register', request.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> forgotPassword(String email) async {
    Response response = await post('$url/ForgotPassword', {
      'Email': email
    }, headers: {
      'Content-Type': 'application/json',
    });
    if (response.body == null) {
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  void logOut(ResponseApi responseApi) {
    GetStorage().remove('userData');
    GetStorage().remove('accountInfo');
    var logout = GetStorage().read('logout');
    if (logout != null) {
      GetStorage().write('logout', 'true');
      Get.snackbar('Thông báo', 'Phiên đăng nhập hết hạn');
    }
    Get.offNamedUntil('/signIn', (route) => false);
  }
}
