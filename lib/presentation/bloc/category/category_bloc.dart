import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_category_list.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryList getCategoryList;
  CategoryBloc({required this.getCategoryList}) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is FetchCategories) {
        emit(CategoryLoading());
        final result = await getCategoryList.call();
        result.fold(
          (error) => emit(CategoryError(error: error)),
          (categories) => emit(CategoryLoaded(categories: categories)),
        );
      }
    });
  }
}
