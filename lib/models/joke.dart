import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'joke.g.dart';

@HiveType(typeId: 0)
class Joke extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String value;
  @HiveField(2)
  final bool isFavourite;

  Joke({
    required this.id,
    required this.value,
    this.isFavourite = false,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
        id: json['id'],
        value: json['value'],
      );

  Joke copyWith({bool? isFavourite}) =>
      Joke(id: id, value: value, isFavourite: isFavourite ?? this.isFavourite);

  @override
  List<Object?> get props => [id, value, isFavourite];
}
