
import 'combo_api.dart';
import 'models/combo_model.dart';

class CombosRepository {
  CombosRepository(this._api);

  final ComboApi _api;

  Future<List<ComboModel>> fetchCombos() => _api.fetchCombos();
}

