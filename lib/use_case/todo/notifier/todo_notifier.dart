import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_techuni/domain/auth/auth_service.dart';
import 'package:todo_techuni/domain/todo/models/todo.dart';
import 'package:todo_techuni/domain/todo/todo_repository.dart';
import 'package:todo_techuni/use_case/todo/state/todo_list_state.dart';
import 'package:uuid/uuid.dart';

final todoNotifierProvider =
    StateNotifierProvider<TodoListNotifier, TodoListState>(
  (ref) => TodoListNotifier(ref: ref),
);

class TodoListNotifier extends StateNotifier<TodoListState> {
  TodoListNotifier({required Ref ref})
      : _ref = ref,
        super(const TodoListState());
  final Ref _ref;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> addTodo({required String description}) async {
    final authState = _ref.read(authServiceProvider);
    try {
      final todo = Todo(
        uid: authState.currentUid,
        description: description,
        id: const Uuid().v1(),
      );

      state = state.copyWith(
        todoList: [...state.todoList, todo],
      );
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  Future<void> getTodoList() async {
    final todoList = await _ref.read(todoRepositoryProvider).getTodoList();
    state = state.copyWith(todoList: todoList);
  }

  Future<void> deleteTodo({required Todo data}) async {
    await _ref.read(todoRepositoryProvider).deleteTodo(data: data);
    state = state.copyWith(
        todoList: state.todoList.where((todo) => todo.id != data.id).toList());
  }
}
