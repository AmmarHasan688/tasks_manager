import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

void showConfirmationBottomSheet(BuildContext context,
    {required VoidCallback onConfirm, required ConfirmationType type}) {
  showModalBottomSheet(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10)
                    .copyWith(bottom: 15),
                child: const Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(width: context.width() * 0.8, child: const Divider()),
              Row(
                children: [
                  const Spacer(
                    flex: 8,
                  ),
                  Expanded(
                      flex: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "back",
                            style: TextStyle(
                                color: Colors.black),
                          ))),
                  const Spacer(
                    flex: 10,
                  ),
                  Expanded(
                    flex: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ConfirmationTypeHelper(type).getColor(context)),
                        onPressed: onConfirm,
                        child: Text(
                          ConfirmationTypeHelper(type).getString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                  const Spacer(
                    flex: 8,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ));
}

enum ConfirmationType { delete, logout }

class ConfirmationTypeHelper {
  final ConfirmationType type;

  ConfirmationTypeHelper(this.type);

  Color getColor(BuildContext context) {
    switch (type) {
      case ConfirmationType.delete:
        return Colors.redAccent;
      case ConfirmationType.logout:
        return context.theme.primaryColor;
    }
  }

  String getString() {
    switch (type) {
      case ConfirmationType.delete:
        return "Delete";
      case ConfirmationType.logout:
        return "Logout";
    }
  }
}
