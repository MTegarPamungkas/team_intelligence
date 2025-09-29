import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/home_entity.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class HomeModel extends Equatable implements BaseModel {
  final String id;
  final String name;

  const HomeModel({
    required this.id,
    required this.name,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  HomeEntity toEntity() => HomeEntity(
        id: id,
        name: name,
      );

  @override
  List<Object?> get props => [id, name];
}