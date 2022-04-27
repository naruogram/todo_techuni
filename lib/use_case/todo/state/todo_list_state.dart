import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_techuni/domain/todo/models/todo.dart';

part 'todo_list_state.freezed.dart';
part 'todo_list_state.g.dart';

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(<Todo>[]) List<Todo> todoList,
    @Default(Todo()) Todo todo,
  }) = _TodoListState;

  factory TodoListState.fromJson(Map<String, dynamic> json) =>
      _$TodoListStateFromJson(json);
}