import 'package:acwadcom/acwadcom_packges.dart';

class TLoader {


  static customToast({required message , required context}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ManagerColors.kCustomColor.withOpacity(0.9)
          ),
          child: Center(child: myText(message,fontSize: 16 , color:  Colors.white),

        )
      ),
    ));
  }

  static void showSuccessSnackBar(BuildContext context, {required String title, String message = ''}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                if (message.isNotEmpty)
                  Text(message, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue, // Primary color for success
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarningSnackBar(BuildContext context, {required String title, String message = ''}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.warning, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                if (message.isNotEmpty)
                  Text(message, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.orange, // Orange color for warning
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorSnackBar(BuildContext context, {required String title, String message = ''}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                if (message.isNotEmpty)
                  Text(message, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red.shade600, // Red color for error
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}