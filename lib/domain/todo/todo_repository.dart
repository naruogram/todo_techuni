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
  Future<void> addTodo({required Todo data}) async {
    try {
      await _db
          .doc(Todo.docPath(data.id))
          .withConverter(
            fromFirestore: (doc, _) => Todo.fromJson(doc.data()!),
            toFirestore: (Todo object, _) => object.toJson(),
          )
          .set(data, SetOptions(merge: true));
    } on Exception catch (e) {
      return;
    }
  }

  //Todo一覧取得
  Future<List<Todo>> getTodoList() async {
    final doc = _db.collection('todos');
    final snapshots = await doc.get();

    if (snapshots.docs.isEmpty) {
      return [];
    }
    final list = <Todo>[];
    for (var i = 0; i < snapshots.docs.length; i++) {
      list.add(Todo.fromJson(snapshots.docs[i].data()));
    }
    return list;
  }

  Future<void> deleteTodo({required Todo data}) async {
    try {
      await _db.doc(Todo.docPath(data.id)).delete();
    } on Exception catch (e) {
      return;
    }
  }
}
