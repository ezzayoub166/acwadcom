part of 'edit_code_cubit.dart';

abstract class EditCodeState {}

class CreateCouponInitial extends EditCodeState{}

class DateInitial extends EditCodeState {}

class DateEdit extends EditCodeState {
  final DateTime selectedDateEdit;

  DateEdit(this.selectedDateEdit);
}

class CategoryEdit extends EditCodeState {
  final OptionItem optionItemSelectedEdit ;

  CategoryEdit(this.optionItemSelectedEdit);

}