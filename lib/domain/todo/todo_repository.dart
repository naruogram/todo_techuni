import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_techuni/domain/auth/auth_service.dart';
import 'package:todo_techuni/domain/todo/models/todo.dart';

final todoRepositoryProvider =
    Provider<TodoRepository>((ref) => TodoRepository(ref: ref));

class TodoRepository {
  TodoRepository({required Ref ref}) : _ref = ref;

  final Ref _ref;
  final _db = FirebaseFirestore.instance;

  // Todoの追加
  Future<Result<void>> addTodo({required Todo data}) async {
    try {
      await _db
          .doc(Todo.docPath(data.id))
          .withConverter(
            fromFirestore: (doc, _) => Todo.fromJson(doc.data()!),
            toFirestore: (Todo object, _) => object.toJson(),
          )
          .set(data, SetOptions(merge: true));
      return Result.value(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  //Todo一覧取得
  Future<Result<List<Todo>>> getTodoList() async {
    final doc = _db.collection('todos');
    final snapshots = await doc.get();

    if (snapshots.docs.isEmpty) {
      return Result.error('todo data not exists');
    }
    final list = <Todo>[];
    for (var i = 0; i < snapshots.docs.length; i++) {
      list.add(Todo.fromJson(snapshots.docs[i].data()));
    }
    return Result.value(list);
  }

  Future<Result<void>> deleteTodo({required Todo data}) async {
    try {
      await _db.doc(Todo.docPath(data.id)).delete();
      return Result.value(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
