
  import 'package:acwadcom/acwadcom_packges.dart';

void setupErrorState(BuildContext context, String error) {
    pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: myText(error,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: ManagerColors.kCustomColor
            // style: TextStyles.font15DarkBlueMedium,
            ),
        actions: [
          TextButton(
            onPressed: () {
              pop(context);
            },
            child: myText('Got it',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ManagerColors.yellowColor),
          ),
        ],
      ),
    );
  }