import 'package:flutter/material.dart';

class MessagesHandlers {
  //Errors.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> message({
    required BuildContext context,
    required String message,
    bool isError = false,
    isWarning = false,
    isDone = false,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError == true
            ? Colors.red
            : isWarning == true
                ? Colors.orange
                : Colors.green,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isError == true
                  ? Icons.error
                  : isWarning == true
                      ? Icons.warning
                      : Icons.done,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 15),
            Text(message),
          ],
        ),
      ),
    );
  }
}
