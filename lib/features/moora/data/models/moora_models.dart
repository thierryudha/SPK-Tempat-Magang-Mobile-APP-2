// === CriteriaScale ===
class CriteriaScaleModel {
  final int id;
  final int criteriaId;
  final int score;
  final String description;

  const CriteriaScaleModel({
    required this.id,
    required this.criteriaId,
    required this.score,
    required this.description,
  });

  factory CriteriaScaleModel.fromJson(Map<String, dynamic> json) {
    return CriteriaScaleModel(
      id: json['id'] as int,
      criteriaId: json['criteria_id'] as int,
      score: json['score'] as int,
      description: json['description'] as String,
    );
  }
}

// === Criteria ===
class CriteriaModel {
  final int id;
  final String code;
  final String name;
  final String type; // 'benefit' | 'cost'
  final List<CriteriaScaleModel> scales;

  const CriteriaModel({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.scales,
  });

  bool get isBenefit => type == 'benefit';

  factory CriteriaModel.fromJson(Map<String, dynamic> json) {
    final scalesRaw = json['scales'] as List<dynamic>? ?? [];
    return CriteriaModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      scales: scalesRaw
          .map((e) => CriteriaScaleModel.fromJson(e as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.score.compareTo(b.score)),
    );
  }
}

// === Normalized score per criteria in result ===
class NormalizedScoreModel {
  final double normalized;
  final double weighted;

  const NormalizedScoreModel({required this.normalized, required this.weighted});

  factory NormalizedScoreModel.fromJson(Map<String, dynamic> json) {
    return NormalizedScoreModel(
      normalized: (json['normalized'] as num).toDouble(),
      weighted: (json['weighted'] as num).toDouble(),
    );
  }
}

// === Single internship result in MOORA output ===
class MooraResultModel {
  final int id;
  final String name;
  final int rank;
  final double optimizationValue;
  final double sumBenefit;
  final double sumCost;
  final Map<String, int> scores; // criteria_id -> raw score
  final Map<String, NormalizedScoreModel> normalizedScores;

  const MooraResultModel({
    required this.id,
    required this.name,
    required this.rank,
    required this.optimizationValue,
    required this.sumBenefit,
    required this.sumCost,
    required this.scores,
    required this.normalizedScores,
  });

  factory MooraResultModel.fromJson(Map<String, dynamic> json) {
    final rawScores = (json['scores'] as Map<String, dynamic>?) ?? {};
    final rawNorm = (json['normalized_scores'] as Map<String, dynamic>?) ?? {};

    return MooraResultModel(
      id: json['id'] as int,
      name: json['name'] as String,
      rank: json['rank'] as int,
      optimizationValue: (json['optimization_value'] as num).toDouble(),
      sumBenefit: (json['sum_benefit'] as num?)?.toDouble() ?? 0,
      sumCost: (json['sum_cost'] as num?)?.toDouble() ?? 0,
      scores: rawScores.map((k, v) => MapEntry(k, (v as num).toInt())),
      normalizedScores: rawNorm.map(
        (k, v) => MapEntry(
          k,
          NormalizedScoreModel.fromJson(v as Map<String, dynamic>),
        ),
      ),
    );
  }
}

// === Request payload for POST /api/calculate ===
class CalculateRequestModel {
  final Map<String, bool> criteria;       // { "1": true, "2": true }
  final Map<String, double> weights;       // { "1": 40.0, "2": 30.0 }
  final List<int> internships;             // [1, 2, 3]
  final Map<String, Map<String, int>> scores; // { "internship_id": { "criteria_id": score } }

  const CalculateRequestModel({
    required this.criteria,
    required this.weights,
    required this.internships,
    required this.scores,
  });

  Map<String, dynamic> toJson() => {
        'criteria': criteria,
        'weights': weights.map((k, v) => MapEntry(k, v)),
        'internships': internships,
        'scores': scores.map(
          (internshipId, criteriaMap) => MapEntry(
            internshipId,
            criteriaMap.map((cId, score) => MapEntry(cId, score)),
          ),
        ),
      };
}
