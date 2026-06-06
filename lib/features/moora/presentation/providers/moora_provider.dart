import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/moora_models.dart';
import '../../data/repositories/moora_repository.dart';
import '../../../internship/data/models/internship_model.dart';

final mooraRepositoryProvider =
    Provider<MooraRepository>((ref) => MooraRepository());

// ─── Criterias ───────────────────────────────────────────────
final criteriasProvider = FutureProvider<List<CriteriaModel>>((ref) async {
  return ref.read(mooraRepositoryProvider).getCriterias();
});

// ─── Saved weights from backend ──────────────────────────────
final savedWeightsProvider = FutureProvider<Map<String, double>>((ref) async {
  return ref.read(mooraRepositoryProvider).getWeights();
});

// ─── Current weight inputs (keyed by criteria_id string) ─────
class WeightNotifier extends StateNotifier<Map<String, double>> {
  WeightNotifier() : super({});

  void setFromSaved(Map<String, double> saved, List<CriteriaModel> criterias) {
    final initial = <String, double>{};
    for (final c in criterias) {
      final key = c.id.toString();
      initial[key] = saved[key] ?? 0;
    }
    state = initial;
  }

  void updateWeight(String criteriaId, double value) {
    state = {...state, criteriaId: value};
  }

  double get total => state.values.fold(0, (a, b) => a + b);
  bool get isValid => (total - 100).abs() < 0.01;
}

final weightNotifierProvider =
    StateNotifierProvider<WeightNotifier, Map<String, double>>(
  (ref) => WeightNotifier(),
);

// ─── Active Criterias (keyed by criteria_id string) ──────────
class ActiveCriteriaNotifier extends StateNotifier<Map<String, bool>> {
  ActiveCriteriaNotifier() : super({});

  void setInitial(List<CriteriaModel> criterias) {
    final initial = <String, bool>{};
    for (final c in criterias) {
      initial[c.id.toString()] = true; // default all true
    }
    state = initial;
  }

  void toggle(String criteriaId, bool isActive) {
    state = {...state, criteriaId: isActive};
  }
}

final activeCriteriaProvider =
    StateNotifierProvider<ActiveCriteriaNotifier, Map<String, bool>>(
  (ref) => ActiveCriteriaNotifier(),
);

// ─── Selected internships for comparison ─────────────────────
class SelectedInternshipsNotifier extends StateNotifier<List<InternshipModel>> {
  SelectedInternshipsNotifier() : super([]);

  void toggle(InternshipModel internship) {
    final exists = state.any((i) => i.id == internship.id);
    if (exists) {
      state = state.where((i) => i.id != internship.id).toList();
    } else {
      state = [...state, internship];
    }
  }

  bool isSelected(int id) => state.any((i) => i.id == id);

  void clear() => state = [];
}

final selectedInternshipsProvider =
    StateNotifierProvider<SelectedInternshipsNotifier, List<InternshipModel>>(
  (ref) => SelectedInternshipsNotifier(),
);

// ─── Scores: { internship_id: { criteria_id: score } } ───────
class ScoresNotifier extends StateNotifier<Map<String, Map<String, int>>> {
  ScoresNotifier() : super({});

  void setScore(String internshipId, String criteriaId, int score) {
    final current = Map<String, Map<String, int>>.from(state);
    current[internshipId] = {...(current[internshipId] ?? {}), criteriaId: score};
    state = current;
  }

  int? getScore(String internshipId, String criteriaId) {
    return state[internshipId]?[criteriaId];
  }

  bool isComplete(List<InternshipModel> internships, List<CriteriaModel> criterias) {
    for (final i in internships) {
      for (final c in criterias) {
        if (getScore(i.id.toString(), c.id.toString()) == null) return false;
      }
    }
    return true;
  }

  void clear() => state = {};
}

final scoresNotifierProvider =
    StateNotifierProvider<ScoresNotifier, Map<String, Map<String, int>>>(
  (ref) => ScoresNotifier(),
);

// ─── Calculate result ─────────────────────────────────────────
class MooraCalculationNotifier
    extends StateNotifier<AsyncValue<List<MooraResultModel>>> {
  MooraCalculationNotifier() : super(const AsyncData([]));

  final _repo = MooraRepository();

  Future<void> calculate(CalculateRequestModel payload) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.calculate(payload));
  }

  void reset() => state = const AsyncData([]);
}

final mooraCalculationProvider = StateNotifierProvider<MooraCalculationNotifier,
    AsyncValue<List<MooraResultModel>>>(
  (ref) => MooraCalculationNotifier(),
);
