import 'package:fetchdatawithflutterbloc/model/cat_fact_model.dart';
import 'package:flutter/material.dart';

abstract class CatsListingState {}

class CatsUninitializedState extends CatsListingState {}

class CatsFetchingState extends CatsListingState {}

class CatsFetchedState extends CatsListingState {
  final List<Cats> catsData;
  CatsFetchedState({@required this.catsData});
}

class CatsErrorState extends CatsListingState {}

class CatsEmptyState extends CatsListingState {}