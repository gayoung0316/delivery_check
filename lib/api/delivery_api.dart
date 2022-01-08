import 'dart:developer';
import 'package:delivery_project/api/dio.dart';
import 'package:delivery_project/model/delivery.dart';

class DeliveryApi extends BaseServerApi {
  Future<Delivery?> getMyDeliveryList(
      {required String carrierId, required int trackId}) async {
    try {
      final url =
          "https://apis.tracker.delivery/carriers/$carrierId/tracks/$trackId";
      final response = await dio.get(url);
      return Delivery.fromJson(response.data);
    } catch (e) {
      log(e.toString());
    }
  }
}
