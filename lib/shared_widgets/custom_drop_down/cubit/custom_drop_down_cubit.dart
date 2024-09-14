import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_drop_down_state.dart';

class DropdownCubit<T> extends Cubit<DropdownState<T>> {
  DropdownCubit() : super(DropdownState<T>(selectedItem: null));

  void selectItem(T item) {
    emit(DropdownState<T>(selectedItem: item));
  }
}
