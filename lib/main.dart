import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_techuni/domain/auth/auth_service.dart';
import 'package:todo_techuni/presentation/pages/todo_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JudgePage(),
    );
  }
}

//強引に書きました
class JudgePage extends ConsumerWidget {
  const JudgePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServiceProvider);
    if (auth.currentUid.isEmpty) {
      auth.signIn();
      return const TodoListPage();
    } else {
      return const TodoListPage();
    }
  }
}
