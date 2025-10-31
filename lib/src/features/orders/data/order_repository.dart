
import 'order_api.dart';
import 'models/order_model.dart';
import 'models/order_request.dart';

class OrderRepository {
  OrderRepository(this._api);

  final OrderApi _api;

  Future<List<OrderModel>> fetchOrders() => _api.fetchOrders();

  Future<OrderModel> createOrder(OrderRequest request) =>
      _api.createOrder(request);
}

