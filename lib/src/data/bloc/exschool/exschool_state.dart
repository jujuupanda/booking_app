part of 'exschool_bloc.dart';

sealed class ExschoolState extends Equatable {
  const ExschoolState();
}

final class ExschoolInitial extends ExschoolState {
  @override
  List<Object> get props => [];
}

final class ExschoolLoading extends ExschoolState {
  @override
  List<Object> get props => [];
}

final class ExschoolGetSuccess extends ExschoolState {
  final List<ExschoolModel> exschools;

  const ExschoolGetSuccess(this.exschools);

  @override
  List<Object> get props => [exschools];
}

final class ExschoolGetFailed extends ExschoolState {
  @override
  List<Object> get props => [];
}
