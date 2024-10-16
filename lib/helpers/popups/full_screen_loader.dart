

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/popups/animation_loader.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text , String animation,BuildContext context){
    showDialog(context: context,barrierDismissible: false,
        builder:(_) => PopScope(
            canPop: false,
            child:Container(
              color: ManagerColors.kCustomColor,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250,),
                  TAnimationLoaderWidget(text: "We are processing your information...",
                      animation: animation)
                ],
              ),
            ) )
    );
  }

  static stopLoading(context){
    pop(context);
  }
}
