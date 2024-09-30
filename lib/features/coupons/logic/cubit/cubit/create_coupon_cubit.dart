import 'package:acwadcom/features/coupons/data/model/drop_list_model.dart';
import 'package:bloc/bloc.dart';

part 'create_coupon_state.dart';

class CreateCouponCubit extends Cubit<CreateCouponState> {
  CreateCouponCubit() : super(CreateCouponInitial());

  // CreateCouponCubit(super.initialState);

  // Method to pick and select a date
  void selectDate(DateTime date) {
    emit(DateSelected(date));
  }

    // Method to select category and pass the translated title
  // void selectCategory(String translatedCategoryTitle) {
  //   final optionItem = OptionItem(id: null, title: translatedCategoryTitle);
  //   emit(CategorySelected(optionItem));
  // }


  // Select category and emit the CategorySelected state
  void selectCategory(OptionItem optionItem) {
    emit(CategorySelected(optionItem));
  }
}

