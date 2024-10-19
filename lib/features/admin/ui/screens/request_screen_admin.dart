// ignore_for_file: camel_case_types

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/admin/logic/request/cubit/control_coupons_cubit.dart';
import 'package:acwadcom/features/admin/ui/widgets/build_coupon_request_item.dart';
import 'package:acwadcom/common/widgets/build_custom_loader.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:flutter/material.dart';


class RequestScreenAdmin extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'logo':
          "https://img.freepik.com/free-vector/gradient-instagram-shop-logo-template_23-2149704603.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727308800&semt=ais_hybrid", // Use correct image path
      'store': 'Pizza Hut',
      'discountCode': 'STANDR 20',
      'time': 'منذ ساعتين',
    },
    {
      'logo':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHuSKg3KQINvWnpNkd9brsgcZmMyjYIeuNjQ&s",
      'store': 'Boston Pizza',
      'discountCode': 'STANDR 20',
      'time': 'منذ ساعتين',
    },
    {
      'logo':
          "https://www.robotbutt.com/wp-content/uploads/2016/02/goodwill-logo.jpg",
      'store': 'Chili\'s',
      'discountCode': 'STANDR 20',
      'time': 'منذ ساعتين',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ControlCouponsCubit>()..emitGetCouponRequest(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ManagerColors.kCustomColor,
          title: myText(AText.requestOkay.tr(context),
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        body: buildBlocBuilder(notifications: notifications),
      ),
    );
  }
}

class buildBlocBuilder extends StatelessWidget {
  const buildBlocBuilder({
    super.key,
    required this.notifications,
  });

  final List<Map<String, String>> notifications;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ControlCouponsCubit, ControlCouponsState>(
      listener: (context, state) {

         state.maybeWhen(
          faluiregetRequestAdded: (error) => TLoader.showErrorSnackBar(context,title: "Error Fetching the requests..", message: error),
          orElse: () {});
      },
      child: BlocBuilder<ControlCouponsCubit, ControlCouponsState>(
        buildWhen: (previous, current) =>
            current is LodingGetRequestAdded ||
            current is SucessgetRequestAdded ||
            current is FaluiregetRequestAdded ||
            current is ApproveCouponRequest ||
            current is RejectCouponRequest || 
            current is FaluireRejectCouponRequest,
        builder: (context, state) {
          return state.maybeWhen(
              lodingGetRequestAdded: () => Center(child: BuildCustomLoader()),
              sucessgetRequestAdded: (coupons , couponsRequests) {
                return ListView.builder(
                  itemCount: coupons.length,
                  itemBuilder: (context, index) {
                    final coupon = coupons[index];
                    final couponReq = couponsRequests[index];
                    return CouponRequestItem(
                      logoPath: coupon.storeLogoURL!,
                      storeName: coupon.title,
                      discountCode: coupon.code,
                      time: "منذ ساعتين",
                      onView: () {
                        // Handle view action
                        navigateNamedTo(
                            context, Routes.discountCodeDeatilsAdmin ,couponReq);
                      },
                      onIgnore: () {
                        context.read<ControlCouponsCubit>().emitRejectCouponRequest(coupon: coupon);
                        context.read<ControlCouponsCubit>().emitGetCouponRequest();
                        // Handle ignore action
                      },
                    );
                  },
                );
              },
              orElse: () {
                return const SizedBox();
              });
        },
      ),
    );
  }
}
