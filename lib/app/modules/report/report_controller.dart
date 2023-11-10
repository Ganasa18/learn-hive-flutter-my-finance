import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_finance_apps/app/data/services/transaction_service.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_blocs.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_events.dart';

class ReportController {
  late BuildContext context;
  static final ReportController _singleton = ReportController._();
  ReportController._();

// make sure you have the original only one instance
  factory ReportController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  getTotalPercentage() async {
    if (context.mounted) {
      context.read<ReportBloc>().add(SetTotalPercentageList());
      // context.read<ReportBloc>().add(const SetTotalPercentageList([]));
    }
  }
}
