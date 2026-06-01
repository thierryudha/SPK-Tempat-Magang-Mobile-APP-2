import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/internship_model.dart';
import '../../data/repositories/internship_repository.dart';

final internshipRepositoryProvider =
    Provider<InternshipRepository>((ref) => InternshipRepository());

// List semua internship
final internshipsProvider =
    FutureProvider<List<InternshipModel>>((ref) async {
  return ref.read(internshipRepositoryProvider).getInternships();
});

// Detail satu internship berdasarkan ID
final internshipDetailProvider =
    FutureProviderFamily<InternshipModel, int>((ref, id) async {
  return ref.read(internshipRepositoryProvider).getInternshipById(id);
});
