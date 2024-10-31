import 'package:acwadcom/acwadcom_packges.dart';
import 'package:lottie/lottie.dart';

class NoNetWorkScreen extends StatelessWidget {
  NoNetWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 19, right: 19, top: 50, bottom: 50),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: LottieBuilder.asset("assets/lottie/no_internet.json")),
        Expanded(
          child: Column(
            children: [
                  myText("No internet Conection".tr(context),
                  color: ManagerColors.yellowColor,
                  fontWeight: FontWeightEnum.Bold.fontWeight,
                  fontSize: 20),
                  buildSpacerH(10.0),
              myText(
                  "Please check your ( Wi-Fi / Data) internetc onnection and try again.".tr(context),
                  color: Colors.black,
                  fontSize: 16,
                  textAlign: TextAlign.center),
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
