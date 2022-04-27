import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const Todo._();
  const factory Todo({
    @Default('') String description,
    @Default('') String uid,
    @Default('') String id,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  static String docPath(String uid) => 'todos/$uid';
}
