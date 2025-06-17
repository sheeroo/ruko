import 'package:flutter/services.dart';

class StrictDateTimeFormatter extends TextInputFormatter {
  // Matches any character that is NOT a digit (0-9)
  static final RegExp _nonDigitRegex = RegExp(r'[^0-9]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If user is deleting/backspacing, allow it immediately
    // without re-validating partial input.
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Extract digits only (remove slashes, colons, spaces, etc.)
    var oldDigits = oldValue.text.replaceAll(_nonDigitRegex, '');
    var newDigits = newValue.text.replaceAll(_nonDigitRegex, '');

    // ----------------------------------------------------
    // 1) If the user just typed exactly one new digit and
    //    that new digit is the first hour digit (index=8),
    //    check if it is > 2. If so, *immediately* turn it
    //    into "0X" (e.g. typed '3' => "03").
    // ----------------------------------------------------
    final addedChars = newDigits.length - oldDigits.length;
    if (addedChars == 1 && newDigits.length == 9) {
      final typedHourTens = int.tryParse(newDigits[8]) ?? 0;
      if (typedHourTens > 2) {
        // Example: oldDigits = "DDMMYYYY" (8 digits),
        //          newDigits = oldDigits + '3'.
        // We correct that to oldDigits + "03".
        final oldPrefix = oldDigits;
        final newHour = '0$typedHourTens';
        newDigits = oldPrefix + newHour; // newDigits now 10 long
      }
    }

    // ----------------------------------------------------
    // 2) Validate partial input. If invalid, revert to oldValue.
    //    - day:   1..31
    //    - month: 1..12
    //    - year:  anywhere 1900..2100 (you can adjust)
    //    - hour:  0..23 or exactly 24
    //    - minute:0..59 (but if hour=24 => minute must be 00)
    // ----------------------------------------------------
    if (!_isValidPartial(newDigits)) {
      return oldValue;
    }

    // ----------------------------------------------------
    // 3) Apply the mask "dd/mm/yyyy HH:mm"
    // ----------------------------------------------------
    final masked = _applyMask(newDigits);

    // Place the cursor at the end of the newly formatted text
    return TextEditingValue(
      text: masked,
      selection: TextSelection.collapsed(offset: masked.length),
    );
  }

  /// Checks the incremental (partial) validity of user input,
  /// before fully 12 digits have been typed.
  ///
  /// Index layout in `digits`:
  ///  - day:    positions 0..1  (dd)
  ///  - month:  positions 2..3  (mm)
  ///  - year:   positions 4..7  (yyyy)
  ///  - hour:   positions 8..9  (HH)
  ///  - minute: positions 10..11 (mm)
  ///
  bool _isValidPartial(String digits) {
    // 1) Day
    if (digits.isNotEmpty) {
      final d0 = int.tryParse(digits[0]);
      // The first day digit must be 0..3
      if (d0 == null || d0 > 3) return false;
    }
    if (digits.length >= 2) {
      final day = int.tryParse(digits.substring(0, 2)) ?? 0;
      if (day < 1 || day > 31) return false;
    }

    // 2) Month
    if (digits.length >= 3) {
      final m0 = int.tryParse(digits[2]);
      // The first month digit must be 0..1
      if (m0 == null || m0 > 1) return false;
    }
    if (digits.length >= 4) {
      final month = int.tryParse(digits.substring(2, 4)) ?? 0;
      if (month < 1 || month > 12) return false;
    }

    // 3) Year (positions 4..7)
    if (digits.length >= 8) {
      final year = int.tryParse(digits.substring(4, 8)) ?? 0;
      if (year < 1900 || year > 2100) return false;
    }

    // 4) Hour
    if (digits.length >= 9) {
      final h0 = int.tryParse(digits[8]);
      // The first hour digit must be 0..2
      if (h0 == null || h0 > 2) return false;
    }
    if (digits.length >= 10) {
      final hour = int.tryParse(digits.substring(8, 10)) ?? -1;
      // hour must be 0..23 or exactly 24
      if (hour < 0 || hour > 24) return false;
    }

    // 5) Minute
    // If hour=24 => minute must be 00
    if (digits.length >= 11) {
      final hour = (digits.length >= 10)
          ? int.tryParse(digits.substring(8, 10)) ?? -1
          : -1;
      final min0 = int.tryParse(digits[10]) ?? -1;
      if (hour == 24) {
        // Must be 0 for the tens place
        if (min0 != 0) return false;
      } else {
        // If not 24, minute tens must be 0..5
        if (min0 > 5) return false;
      }
    }
    if (digits.length >= 12) {
      final hour = int.tryParse(digits.substring(8, 10)) ?? -1;
      final minute = int.tryParse(digits.substring(10, 12)) ?? -1;
      if (hour == 24) {
        // Must be exactly "00"
        if (minute != 0) return false;
      } else {
        // Otherwise 0..59
        if (minute < 0 || minute > 59) return false;
      }
    }

    return true;
  }

  /// Builds the final masked string in `dd/mm/yyyy HH:mm` format.
  String _applyMask(String digits) {
    final buf = StringBuffer();

    // dd
    if (digits.isNotEmpty) {
      buf.write(digits.substring(0, _min(2, digits.length)));
    }
    // / if we have day+1 => at least 3 digits
    if (digits.length >= 3) {
      buf.write('/');
      // mm
      buf.write(digits.substring(2, _min(4, digits.length)));
    }
    // / if we have at least 5 digits => day+month+1
    if (digits.length >= 5) {
      buf.write('/');
      // yyyy
      buf.write(digits.substring(4, _min(8, digits.length)));
    }
    // space if we have at least 9 digits => day+month+year+1
    if (digits.length >= 9) {
      buf.write(' ');
      // HH
      buf.write(digits.substring(8, _min(10, digits.length)));
    }
    // : if we have at least 11 digits
    if (digits.length >= 11) {
      buf.write(':');
      // mm
      buf.write(digits.substring(10, _min(12, digits.length)));
    }

    return buf.toString();
  }

  int _min(int a, int b) => a < b ? a : b;
}
