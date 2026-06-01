import '../datasources/moora_remote_datasource.dart';
import '../models/moora_models.dart';

class MooraRepository {
  final _dataSource = MooraRemoteDataSource();

  Future<List<CriteriaModel>> getCriterias() => _dataSource.getCriterias();

  Future<Map<String, double>> getWeights() => _dataSource.getWeights();

  Future<List<MooraResultModel>> calculate(CalculateRequestModel payload) =>
      _dataSource.calculate(payload);
}
