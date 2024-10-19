part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.loaded(List<Coupon> results) = SearchLoaded;
  const factory SearchState.error(String message) = SearchError;
}
