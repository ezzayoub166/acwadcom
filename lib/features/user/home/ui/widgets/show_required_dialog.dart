  // Function to show the dialog
  import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/ownerStore/features/home/widgets/custom_pop_dialog_require_login.dart';

void showRequireLoginDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmRequireLoginDialog();
      },
    );
  }
