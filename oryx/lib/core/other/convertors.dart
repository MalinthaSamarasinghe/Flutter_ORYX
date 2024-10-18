/// 3333300 --> Rs 3,333,300.00
/// 3333300.50 --> Rs 3,333,300.50
/// 3333300.5 --> Rs 3,333,300.50
/// 3333300.00 --> Rs 3,333,300.00
/// 3333300.0 --> Rs 3,333,300.00
String stringToRsConvertor(String price, {bool showSymbol = true}) {
  /// Split the price string into integer and decimal parts
  List<String> parts = price.split(".");

  /// Format the integer part with commas
  String formattedInteger = "";
  String integerPart = parts[0];

  for (int i = integerPart.length - 1; i >= 0; i--) {
    if ((integerPart.length - i) % 3 == 0 && i != 0) {
      formattedInteger = ",${integerPart[i]}$formattedInteger";
    } else {
      formattedInteger = integerPart[i] + formattedInteger;
    }
  }

  /// Handle decimal part, if present
  String decimalPart = (parts.length > 1) ? parts[1] : "00";

  /// Trim trailing zeros from the decimal part
  decimalPart = decimalPart.replaceAll(RegExp(r'0+$'), '');

  /// If the decimal part is empty (i.e., it was "0000"), default it to "00"
  if (decimalPart.isEmpty) {
    decimalPart = "00";
  }

  /// Ensure the decimal part has exactly two digits
  if (decimalPart.length == 1) {
    decimalPart = "${decimalPart}0";
  }

  /// Combine the formatted integer part and the decimal part
  String formattedTotal = showSymbol ? "Rs $formattedInteger.$decimalPart" : "$formattedInteger.$decimalPart";

  return formattedTotal;
}
