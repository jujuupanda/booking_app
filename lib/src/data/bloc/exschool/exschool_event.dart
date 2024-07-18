part of 'exschool_bloc.dart';

sealed class ExschoolEvent extends Equatable {
  const ExschoolEvent();

  @override
  List<Object> get props => [];
}

final class InitialExschool extends ExschoolEvent {}

final class GetExschool extends ExschoolEvent {}
