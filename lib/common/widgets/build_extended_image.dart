import 'package:acwadcom/helpers/constants/lottie.dart';
import 'package:extended_image/extended_image.dart';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:lottie/lottie.dart';

Widget extendedImageWgt(imageUrl , [double? height , double? width,BorderRadius? borderRadius , ]) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Lottie.asset(LottieConstnts.emptyImageAnimation);
  }

  return ExtendedImage.network(
    height: height,
    width: width,
    borderRadius: borderRadius,
    imageUrl,
    cache: true,
    clearMemoryCacheIfFailed :false,
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Lottie.asset(LottieConstnts.loadingProgress);
        case LoadState.completed:
          return state.completedWidget;
        case LoadState.failed:
        return Lottie.asset("assets/lottie/44656-error.json",fit: BoxFit.fitWidth,);
          // return Image.asset(
          //   'assets/images/error404.png',
          //   fit: BoxFit.cover,
          // );
      }
    },
  );
}