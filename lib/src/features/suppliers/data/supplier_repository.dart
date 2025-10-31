import 'supplier_api.dart';
import 'models/supplier_model.dart';
import 'models/supplier_request.dart';

class SupplierRepository {
  SupplierRepository(this._api);

  final SupplierApi _api;

  Future<List<SupplierModel>> fetchSuppliers() => _api.fetchSuppliers();

  Future<SupplierModel> createSupplier(SupplierRequest request) =>
      _api.createSupplier(request);

  Future<void> updateSupplier({
    required String id,
    required SupplierRequest request,
  }) => _api.updateSupplier(id: id, request: request);

  Future<void> deleteSupplier(String id) => _api.deleteSupplier(id);
}
