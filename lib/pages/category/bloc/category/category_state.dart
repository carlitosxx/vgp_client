part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

//todo: loading state
class CategoryLoadingState extends CategoryState{
  @override
  List<Object?> get props => [];
}
//todo: loaded state
class CategoryLoadedState extends CategoryState{  
  final Map<String, dynamic> listCategory;
  CategoryLoadedState(this.listCategory);

  @override
  List<Object?> get props => [listCategory];
}
//todo: error state
class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState(this.error);
  @override
  List<Object?> get props => [error];
}