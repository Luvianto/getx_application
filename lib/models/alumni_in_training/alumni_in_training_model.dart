import 'package:getx_application/models/alumni/alumni_model.dart';

class AlumniInTrainingModel {
  final int? id;
  final AlumniModel? alumni;
  final int? status;

  AlumniInTrainingModel({
    this.id,
    this.alumni,
    this.status,
  });

  factory AlumniInTrainingModel.fromJson(Map<String, dynamic> data) {
    return AlumniInTrainingModel(
      id: data['id'],
      alumni: AlumniModel.fromJson(data['alumni']),
      status: data['status'],
    );
  }
}
