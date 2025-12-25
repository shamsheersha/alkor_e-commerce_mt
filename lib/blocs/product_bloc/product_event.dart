import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  final String query;
  SearchProductEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterbyCategoryEvent extends ProductEvent {
  final String? category;

  FilterbyCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}