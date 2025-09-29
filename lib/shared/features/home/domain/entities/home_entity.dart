import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String id;
  final String name;

  const HomeEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}