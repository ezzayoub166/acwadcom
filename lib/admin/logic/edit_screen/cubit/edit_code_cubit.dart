import 'package:acwadcom/features/coupons/data/model/drop_list_model.dart';
import 'package:bloc/bloc.dart';

part 'edit_code_state.dart';

class EditCodeCubit extends Cubit<EditCodeState> {
  EditCodeCubit() : super(CreateCouponInitial());

  // CreateCouponCubit(super.initialState);

  // Method to pick and select a date
  void selectDate(DateTime date) {
    emit(DateEdit(date));
  }

  // Select category and emit the CategorySelected state
  void selectCategory(OptionItem optionItem) {
    emit(CategoryEdit(optionItem));
  }
}