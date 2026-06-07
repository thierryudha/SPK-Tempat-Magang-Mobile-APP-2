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

// List kategori
final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  return ref.read(internshipRepositoryProvider).getCategories();
});

// State untuk aksi Create, Update, Delete
class InternshipActionNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  InternshipActionNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> createInternship(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(internshipRepositoryProvider).createInternship(data);
      ref.invalidate(internshipsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateInternship(int id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(internshipRepositoryProvider).updateInternship(id, data);
      ref.invalidate(internshipsProvider);
      ref.invalidate(internshipDetailProvider(id));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteInternship(int id) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(internshipRepositoryProvider).deleteInternship(id);
      ref.invalidate(internshipsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final internshipActionProvider =
    StateNotifierProvider<InternshipActionNotifier, AsyncValue<void>>((ref) {
  return InternshipActionNotifier(ref);
});
