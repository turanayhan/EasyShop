import 'package:case1/features/home/data/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final categories = await repository.fetchCategories();
        emit(ProductLoaded(categories));
      } catch (e) {
        emit(ProductError('Veriler yüklenemedi.'));
      }
    });
  }
}
