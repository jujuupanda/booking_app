part of 'extracurricular_bloc.dart';

sealed class ExtracurricularState extends Equatable {
  const ExtracurricularState();
}

final class ExtracurricularInitial extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularLoading extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularGetSuccess extends ExtracurricularState {
  final List<ExtracurricularModel> extracurriculars;

  const ExtracurricularGetSuccess(this.extracurriculars);

  @override
  List<Object> get props => [extracurriculars];
}

final class ExtracurricularGetFailed extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularAddSuccess extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularAddFailed extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularDeleteSuccess extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularDeleteFailed extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularUpdateSuccess extends ExtracurricularState {
  @override
  List<Object> get props => [];
}

final class ExtracurricularUpdateFailed extends ExtracurricularState {
  @override
  List<Object> get props => [];
}
