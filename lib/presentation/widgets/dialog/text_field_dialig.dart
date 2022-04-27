import 'package:flutter/material.dart';

Future<String?> showTextFieldDialog<String>({
  required BuildContext context,
}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => const BasicAlertDialog(),
  );
}

class BasicAlertDialog extends StatelessWidget {
  const BasicAlertDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return AlertDialog(
      title: const Text('今日やったことを入力してください'),
      content: TextFormField(
        controller: textController,
        decoration: const InputDecoration(hintText: "ここに入力"),
      ),
      actions: [
        OutlineButton(
          color: Colors.white,
          textColor: Colors.blue,
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.blue,
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(textController.text);
          },
        ),
      ],
    );
  }
}
