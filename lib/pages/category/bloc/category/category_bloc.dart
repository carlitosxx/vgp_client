import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/pages/category/repositories/category.repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryBloc(this._categoryRepository) : super(CategoryLoadingState()) {
    on<LoadCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {        
        final category=await _categoryRepository.getAllActiveCategory();                
        emit(CategoryLoadedState(category));
      } catch (e) {
        emit(CategoryErrorState(e.toString()));
      }      
    });
  }
}
