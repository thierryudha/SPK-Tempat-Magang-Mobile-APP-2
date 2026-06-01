import '../datasources/internship_remote_datasource.dart';
import '../models/internship_model.dart';

class InternshipRepository {
  final _dataSource = InternshipRemoteDataSource();

  Future<List<InternshipModel>> getInternships() => _dataSource.getInternships();

  Future<InternshipModel> getInternshipById(int id) =>
      _dataSource.getInternshipById(id);
}
