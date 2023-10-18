import 'package:flutter/material.dart';
import '../../features/services/dialog_service.dart';
import '../../features/services/locator_service.dart';
import 'model/dialog_model.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;
  const DialogManager({Key? key, this.child}) : super(key: key);

  @override
  State<DialogManager> createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(request.title!),
              content: Text(request.description!),
              actions: <Widget>[
                if (isConfirmationDialog)
                  TextButton(
                    child: Text(request.cancelTitle!),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                TextButton(
                  child: Text(request.buttonTitle!),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ));
  }
}
