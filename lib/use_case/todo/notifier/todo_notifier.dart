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

      final result =
          await _ref.read(todoRepositoryProvider).addTodo(data: todo);
      state = state.copyWith(
        todoList: [...state.todoList, todo],
      );
      if (result.isError) {}
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  Future<void> getTodoList() async {
    final result = await _ref.read(todoRepositoryProvider).getTodoList();

    if (result.isError) {
      return;
    }
    state = state.copyWith(todoList: result.asValue!.value);
  }
}
