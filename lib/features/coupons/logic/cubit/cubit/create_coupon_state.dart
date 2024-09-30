part of 'create_coupon_cubit.dart';

abstract class CreateCouponState {}

class CreateCouponInitial extends CreateCouponState{}

class DateInitial extends CreateCouponState {}

class DateSelected extends CreateCouponState {
  final DateTime selectedDate;

  DateSelected(this.selectedDate);
}

class CategorySelected extends CreateCouponState {
  final OptionItem optionItemSelected ;

  CategorySelected(this.optionItemSelected);

}