// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoListState _$$_TodoListStateFromJson(Map<String, dynamic> json) =>
    _$_TodoListState(
      todoList: (json['todoList'] as List<dynamic>?)
              ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Todo>[],
      todo: json['todo'] == null
          ? const Todo()
          : Todo.fromJson(json['todo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TodoListStateToJson(_$_TodoListState instance) =>
    <String, dynamic>{
      'todoList': instance.todoList,
      'todo': instance.todo,
    };
