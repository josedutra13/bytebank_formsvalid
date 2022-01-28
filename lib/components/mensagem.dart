import 'package:flutter/material.dart';

emitirAlerta({context, title, content}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar')),
          ],
        );
      });
}
