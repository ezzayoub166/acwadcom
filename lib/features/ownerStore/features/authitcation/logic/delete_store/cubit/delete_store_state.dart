part of 'delete_store_cubit.dart';

@freezed
class DeleteStoreState with _$DeleteStoreState {
  const factory DeleteStoreState.initial() = _Initial;
  const factory DeleteStoreState.loadingRemoveStore() = LoadingRemoveStore;
  const factory DeleteStoreState.successRemoveStore() = SuccessRemoveStore;
  const factory DeleteStoreState.faluireRemoveStore({required String error}) = FaluireRemoveStore;
}
