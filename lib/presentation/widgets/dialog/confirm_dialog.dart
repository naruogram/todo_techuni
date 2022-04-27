import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<bool?> showConfirmDialog<bool>({
  required BuildContext context,
}) {
  return showDialog<bool?>(
    context: context,
    builder: (context) => const ConfirmDialog(),
  );
}

class ConfirmDialog extends HookWidget {
  const ConfirmDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Todoを削除しますか？"),
      actions: <Widget>[
        FlatButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        FlatButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
