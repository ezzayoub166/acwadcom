// ignore_for_file: prefer_const_constructors

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_state.dart';
import 'package:acwadcom/features/user/coupons/ui/widgets/build_app_bar_with_back_button.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';

class MerchantStatisticsPage extends StatelessWidget {
  const MerchantStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackButton(context, isRTL(context),
          title: AText.statistics.tr(context)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => getIt<HomeOwnerCubit>()..emitGetCoupons(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Merchant Info Section
              BlocBuilder<AvatarCubit, AvatarState>(
                buildWhen: (previous, current) => current is FetchNameImage,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.black,
                            backgroundImage:
                                CachedNetworkImageProvider(state.imageUrl),
                          ),
                          buildSpacerW(20.0),
                          myText(
                            state.username,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 24),

              // Section: Merchant Statistics Title
              myText(
                "Store statistics".tr(context),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 16),

              // Discount Codes Count Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(AText.numberOfdiscountcodes.tr(context),
                          fontSize: 16, color: ManagerColors.yellowColor),
                      BlocBuilder<HomeOwnerCubit, HomeOwnerState>(
                        buildWhen: (previous, current) =>
                            current is GetNumberOfCoupons,
                        builder: (context, state) {
                          return state.maybeWhen(
                              getNumberOfCoupons: (number) => myText(
                                    number.toString(),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                              orElse: () {
                                return myText(
                                  "0",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Discount Code Usage Count Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myText(AText.numberOfuse.tr(context),
                              fontSize: 16, color: ManagerColors.yellowColor),
                          BlocBuilder<HomeOwnerCubit, HomeOwnerState>(
                            buildWhen: (previous, current) => current is GetSumUsedOfCoupons,
                            builder: (context, state) {
                              return state.maybeWhen(
                                getSumUsedOfCoupons: (sum) =>   myText(
                                  sum.toString(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                                orElse:() {
                                 return myText(
                                 "0",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              );
                              });
                             
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
