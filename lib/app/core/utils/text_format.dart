import 'package:intl/intl.dart';

String formatName(String fullName) {
  List<String> words = fullName.split(' ');
  if (words.length >= 2) {
    String formattedText =
        '${words[0].substring(0, 1).toUpperCase()}${words[0].substring(1)} ${words[1].substring(0, 1).toUpperCase()}';
    return formattedText;
  } else {
    return fullName;
  }
}

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 10 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Night';
  }
}

String formatCurrency(int number, {String? symbol, decimalDigits = 2}) {
  final currencyFormat = NumberFormat.currency(
      locale: 'id_ID', symbol: symbol, decimalDigits: decimalDigits);
  final formattedCurrency = currencyFormat.format(number);
  return formattedCurrency;

  // return formattedCurrency;
}

String formatAmount(String enteredAmount) {
  final formatter = NumberFormat("#,###");
  if (enteredAmount.isNotEmpty) {
    // Check if enteredAmount is a valid integer
    try {
      final amount = int.parse(enteredAmount);
      // Format and return the valid integer
      return formatter.format(amount);
    } catch (e) {
      // Handle the case where enteredAmount is not a valid integer
      return 'Invalid Amount';
    }
  }

  return '';
}

String capitalizeFirstChar(String input) {
  List<String> words = input.split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }
  return words.join(' ');
}

String formatDateString(String inputDate) {
  final inputFormat = DateFormat("yyyy-MM-dd");
  final outputFormat = DateFormat("dd MMMM y", 'en_US');

  try {
    final date = inputFormat.parse(inputDate);
    final formattedDate = outputFormat.format(date);
    return formattedDate;
  } catch (e) {
    return "Invalid Date"; // Handle invalid date strings
  }
}
