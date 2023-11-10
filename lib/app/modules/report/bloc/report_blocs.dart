import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/data/providers/transaction_provider.dart';
import 'package:my_finance_apps/app/data/repository/transaction_repository.dart';
import 'package:my_finance_apps/app/data/services/transaction_service.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_events.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_states.dart';

class ReportBloc extends Bloc<ReportEvents, ReportStates> {
  ReportBloc() : super(ReportInital()) {
    on<ReportEvents>((event, emit) async {
      final transactionService = TransactionStorageService();
      await transactionService.init();
      TransactionProvider transactionProvider =
          TransactionProvider(transactionService);

      TransactionRepository transactionRepository =
          TransactionRepository(transactionProvider);

      if (event is SetTotalPercentageList) {
        try {
          emit(ReportLoadings());
          final res =
              await transactionRepository.countTotalTransactionPercentage();
          emit(ReportLoaded(res));
        } catch (e) {
          print("$e SOMETHING WENT WRONG");
        }
      }
    });
  }
}
