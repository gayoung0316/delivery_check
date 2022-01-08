import 'package:delivery_project/api/delivery_api.dart';
import 'package:delivery_project/model/delivery.dart';
import 'package:flutter/foundation.dart';

class DeliveryProvider extends ChangeNotifier {
  final DeliveryApi _deliveryApi = DeliveryApi();

  Delivery? _delivery;
  Delivery? get delivery => _delivery;

  Future<void> getDeliveryList({String? carrierId, String? trackId}) async {
    _delivery = (await _deliveryApi.getMyDeliveryList(
      carrierId: carrierId!,
      trackId: int.parse(trackId!),
    ))!;
    notifyListeners();
  }
}
