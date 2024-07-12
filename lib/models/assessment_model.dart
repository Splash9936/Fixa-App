class Assessment {
  int? id;
  int? level;
  bool? isAvailable;
  String? createdAt;
  String? updatedAt;
  List<Metrics>? metrics;

  Assessment(
      {this.id,
      this.level,
      this.isAvailable,
      this.createdAt,
      this.updatedAt,
      this.metrics});

  Assessment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['metrics'] != null) {
      metrics = <Metrics>[];
      json['metrics'].forEach((v) {
        metrics!.add(Metrics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['is_available'] = isAvailable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (metrics != null) {
      data['metrics'] = metrics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metrics {
  int? id;
  List<Questions>? questions;
  List<AssessmentMetrics>? assessmentMetrics;

  Metrics({this.id, this.questions, this.assessmentMetrics});

  Metrics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    if (json['assessment_metrics'] != null) {
      assessmentMetrics = <AssessmentMetrics>[];
      json['assessment_metrics'].forEach((v) {
        assessmentMetrics!.add(AssessmentMetrics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (assessmentMetrics != null) {
      data['assessment_metrics'] =
          assessmentMetrics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  QuestionDescription? questionDescription;

  Questions({this.id, this.questionDescription});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionDescription = json['question_description'] != null
        ? QuestionDescription.fromJson(json['question_description'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (questionDescription != null) {
      data['question_description'] = questionDescription!.toJson();
    }
    return data;
  }
}

class QuestionDescription {
  int? id;
  String? question;

  QuestionDescription({this.id, this.question});

  QuestionDescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    return data;
  }
}

class AssessmentMetrics {
  int? id;
  String? metricName;

  AssessmentMetrics({this.id, this.metricName});

  AssessmentMetrics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metricName = json['metric_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['metric_name'] = metricName;
    return data;
  }
}

class AssessmentControllers {
  int metricId;
  int percentage;
  bool status;
  String question;
  String description;
  int answer;

  AssessmentControllers(this.metricId, this.percentage, this.status,
      this.question, this.description, this.answer);
}




// class Assessment {
//   int? id;
//   int? level;
//   bool? isAvailable;
//   List<Ratings>? ratings;
//   List<Metrics>? metrics;

//   Assessment(
//       {this.id, this.level, this.isAvailable, this.ratings, this.metrics});

//   Assessment.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     level = json['level'];
//     isAvailable = json['is_available'];
//     if (json['ratings'] != null) {
//       ratings = <Ratings>[];
//       json['ratings'].forEach((v) {
//         ratings!.add(Ratings.fromJson(v));
//       });
//     }
//     if (json['metrics'] != null) {
//       metrics = <Metrics>[];
//       json['metrics'].forEach((v) {
//         metrics!.add(Metrics.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['level'] = level;
//     data['is_available'] = isAvailable;
//     if (ratings != null) {
//       data['ratings'] = ratings!.map((v) => v.toJson()).toList();
//     }
//     if (metrics != null) {
//       data['metrics'] = metrics!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Ratings {
//   int? id;
//   AssessmentRating? assessmentRating;

//   Ratings({this.id, this.assessmentRating});

//   Ratings.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     assessmentRating = json['assessment_rating'] != null
//         ? AssessmentRating.fromJson(json['assessment_rating'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     if (assessmentRating != null) {
//       data['assessment_rating'] = assessmentRating!.toJson();
//     }
//     return data;
//   }
// }

// class AssessmentRating {
//   int? id;
//   String? rankType;
//   bool? isAvailable;
//   String? publishedAt;
//   String? createdAt;
//   String? updatedAt;

//   AssessmentRating(
//       {this.id,
//       this.rankType,
//       this.isAvailable,
//       this.publishedAt,
//       this.createdAt,
//       this.updatedAt});

//   AssessmentRating.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     rankType = json['rank_type'];
//     isAvailable = json['is_available'];
//     publishedAt = json['published_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['rank_type'] = rankType;
//     data['is_available'] = isAvailable;
//     data['published_at'] = publishedAt;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class Metrics {
//   int? id;
//   bool? isAvailable;
//   List<Questions>? questions;
//   List<AssessmentMetrics>? assessmentMetrics;

//   Metrics({this.id, this.isAvailable, this.questions, this.assessmentMetrics});

//   Metrics.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isAvailable = json['is_available'];
//     if (json['questions'] != null) {
//       questions = <Questions>[];
//       json['questions'].forEach((v) {
//         questions!.add(Questions.fromJson(v));
//       });
//     }
//     if (json['assessment_metrics'] != null) {
//       assessmentMetrics = <AssessmentMetrics>[];
//       json['assessment_metrics'].forEach((v) {
//         assessmentMetrics!.add(AssessmentMetrics.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['is_available'] = isAvailable;
//     if (questions != null) {
//       data['questions'] = questions!.map((v) => v.toJson()).toList();
//     }
//     if (assessmentMetrics != null) {
//       data['assessment_metrics'] =
//           assessmentMetrics!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Questions {
//   int? id;
//   QuestionDescription? questionDescription;

//   Questions({this.id, this.questionDescription});

//   Questions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     questionDescription = json['question_description'] != null
//         ? QuestionDescription.fromJson(json['question_description'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     if (questionDescription != null) {
//       data['question_description'] = questionDescription!.toJson();
//     }
//     return data;
//   }
// }

// class QuestionDescription {
//   int? id;
//   String? question;
//   bool? isAvailable;
//   String? publishedAt;
//   String? createdAt;
//   String? updatedAt;

//   QuestionDescription(
//       {this.id,
//       this.question,
//       this.isAvailable,
//       this.publishedAt,
//       this.createdAt,
//       this.updatedAt});

//   QuestionDescription.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     question = json['question'];
//     isAvailable = json['is_available'];
//     publishedAt = json['published_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['question'] = question;
//     data['is_available'] = isAvailable;
//     data['published_at'] = publishedAt;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class AssessmentMetrics {
//   int? id;
//   String? metricName;
//   bool? isAvailable;
//   String? publishedAt;
//   String? createdAt;
//   String? updatedAt;

//   AssessmentMetrics(
//       {this.id,
//       this.metricName,
//       this.isAvailable,
//       this.publishedAt,
//       this.createdAt,
//       this.updatedAt});

//   AssessmentMetrics.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     metricName = json['metric_name'];
//     isAvailable = json['is_available'];
//     publishedAt = json['published_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['metric_name'] = metricName;
//     data['is_available'] = isAvailable;
//     data['published_at'] = publishedAt;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
