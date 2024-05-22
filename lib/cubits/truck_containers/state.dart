part of 'cubit.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class TrucksLoading extends DataState {}

class TrucksLoadSuccess extends DataState {
  final List<Truck?> trucks;

  const TrucksLoadSuccess({required this.trucks});

  @override
  List<Object?> get props => [trucks];
}

class TrucksLoadFailure extends DataState {
  final String errorMessage;

  const TrucksLoadFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ContainersLoading extends DataState {}

class ContainersLoadSuccess extends DataState {
  final List<Container> containers;

  const ContainersLoadSuccess({required this.containers});

  @override
  List<Object?> get props => [containers];
}

class ContainersLoadFailure extends DataState {
  final String errorMessage;

  const ContainersLoadFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ContainersCountLoading extends DataState {}

class ContainersCountLoadSuccess extends DataState {
  final int count;

  const ContainersCountLoadSuccess({required this.count});

  @override
  List<Object?> get props => [count];
}

class ContainersCountLoadFailure extends DataState {
  final String errorMessage;

  const ContainersCountLoadFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
