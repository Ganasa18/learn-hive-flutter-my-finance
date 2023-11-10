import 'package:equatable/equatable.dart';

class ReportStates extends Equatable {
  const ReportStates();

  @override
  List<Object> get props => [];
}

class ReportInital extends ReportStates {}

class ReportLoadings extends ReportStates {}

class ReportLoaded extends ReportStates {
  final List<double> totalPercentages;
  const ReportLoaded(this.totalPercentages);
  @override
  List<Object> get props => [totalPercentages];
}
