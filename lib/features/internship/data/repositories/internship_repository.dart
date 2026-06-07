import '../datasources/internship_remote_datasource.dart';
import '../models/internship_model.dart';

class InternshipRepository {
  final _dataSource = InternshipRemoteDataSource();

  Future<List<InternshipModel>> getInternships() => _dataSource.getInternships();

  Future<InternshipModel> getInternshipById(int id) =>
      _dataSource.getInternshipById(id);

  Future<List<CategoryModel>> getCategories() => _dataSource.getCategories();

  Future<InternshipModel> createInternship(Map<String, dynamic> data) =>
      _dataSource.createInternship(data);

  Future<InternshipModel> updateInternship(int id, Map<String, dynamic> data) =>
      _dataSource.updateInternship(id, data);

  Future<void> deleteInternship(int id) => _dataSource.deleteInternship(id);
}
