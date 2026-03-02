import 'package:flutter/material.dart';
import '../models/calculator_model.dart';

class CalculatorController {
  static final CalculatorController _instance =
      CalculatorController._internal();

  factory CalculatorController() {
    return _instance;
  }

  CalculatorController._internal();

  // دالة لتنفيذ العملية الحسابية
  CalculatorModel calculate(CalculatorModel model) {
    final num1 = double.tryParse(model.number1 ?? '');
    final num2 = double.tryParse(model.number2 ?? '');

    // التحقق من صحة المدخلات
    if (num1 == null || num2 == null) {
      return model.copyWith(error: 'الرجاء إدخال أرقام صحيحة', result: null);
    }

    if (model.operation == null) {
      return model.copyWith(error: 'الرجاء اختيار عملية حسابية', result: null);
    }

    double? calculatedResult;
    String? error;

    try {
      switch (model.operation) {
        case '+':
          calculatedResult = num1 + num2;
          break;
        case '-':
          calculatedResult = num1 - num2;
          break;
        case '×':
          calculatedResult = num1 * num2;
          break;
        case '÷':
          if (num2 == 0) {
            error = 'لا يمكن القسمة على صفر';
          } else {
            calculatedResult = num1 / num2;
          }
          break;
        default:
          error = 'عملية غير صحيحة';
      }
    } catch (e) {
      error = 'خطأ في العملية الحسابية';
    }

    return model.copyWith(result: calculatedResult?.toString(), error: error);
  }

  // دالة لمسح جميع الحقول
  CalculatorModel clearAll(CalculatorModel model) {
    return CalculatorModel();
  }

  // دالة لتعيين العملية
  CalculatorModel setOperation(CalculatorModel model, String operation) {
    return model.copyWith(operation: operation, error: null);
  }
}
