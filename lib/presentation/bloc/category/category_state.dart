part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  CategoryLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

final class CategoryError extends CategoryState {
  final ErrorEntity error;
  CategoryError({required this.error});

  @override
  List<Object> get props => [error];
}



