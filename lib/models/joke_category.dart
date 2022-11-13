import 'package:equatable/equatable.dart';

class JokeCategory extends Equatable {
  final String name;

  const JokeCategory({required this.name});

  JokeCategory.fromJson(dynamic name) : name = name.toString();

  @override
  List<Object?> get props => [name];
}
