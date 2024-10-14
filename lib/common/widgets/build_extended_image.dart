import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:extended_image/extended_image.dart';
import 'package:lottie/lottie.dart';

Widget extendedImageWgt(String imageUrl, [double? height, double? width, BoxFit? fit]) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Lottie.asset(LottieConstnts.emptyImageAnimation);
  }

  return ExtendedImage.network(
    imageUrl,
    height: height,
    width: width,
    cache: true,
    fit: fit,
    clearMemoryCacheIfFailed: false,
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          // return Lottie.asset(LottieConstnts.loading_sing_up_animation);
          return BuildCustomLoader();
        case LoadState.completed:
          return state.completedWidget;
        case LoadState.failed:
          return Lottie.asset("assets/lottie/no_data.json", fit: BoxFit.fitWidth);
      }
    },
  );
}
