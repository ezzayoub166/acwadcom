import 'package:acwadcom/acwadcom_packges.dart';
import 'package:lottie/lottie.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const TAnimationLoaderWidget(
      {
      required this.text,
      required this.animation,
       this.showAction = false,
      this.actionText,
      this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,width: MediaQuery.of(context).size.width * 0.8),
          SizedBox(height: TSizes.defaultSpace,),
          myText(
            text.tr(context),
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: TSizes.defaultSpace,),
          showAction ?
              SizedBox(
                width: 250,
                child: OutlinedButton(onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(backgroundColor: ManagerColors.dark)
                    ,child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: ManagerColors.light),
                    )),
              ) : SizedBox()


        ],
      ),
    );
  }
}

class TColors {
}
