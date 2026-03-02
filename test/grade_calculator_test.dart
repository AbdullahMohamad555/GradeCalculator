import 'package:flutter_test/flutter_test.dart';
import 'package:second_project/models/grade_calculator.dart';

void main() {
  late GradeCalculator calculator;

  setUp(() {
    calculator = GradeCalculator();
  });

  // ============== اختبارات getLetterGrade ==============
  group('getLetterGrade', () {
    test('should return A for grades 90-100', () {
      expect(calculator.getLetterGrade(95), 'A');
      expect(calculator.getLetterGrade(90), 'A');
      expect(calculator.getLetterGrade(100), 'A');
    });

    test('should return B for grades 80-89', () {
      expect(calculator.getLetterGrade(85), 'B');
      expect(calculator.getLetterGrade(80), 'B');
      expect(calculator.getLetterGrade(89), 'B');
    });

    test('should return C for grades 70-79', () {
      expect(calculator.getLetterGrade(75), 'C');
      expect(calculator.getLetterGrade(70), 'C');
      expect(calculator.getLetterGrade(79), 'C');
    });

    test('should return D for grades 60-69', () {
      expect(calculator.getLetterGrade(65), 'D');
      expect(calculator.getLetterGrade(60), 'D');
      expect(calculator.getLetterGrade(69), 'D');
    });

    test('should return F for grades below 60', () {
      expect(calculator.getLetterGrade(59), 'F');
      expect(calculator.getLetterGrade(0), 'F');
      expect(calculator.getLetterGrade(35.5), 'F');
    });

    test('should handle boundary values correctly', () {
      expect(calculator.getLetterGrade(90), 'A'); // Minimum A
      expect(calculator.getLetterGrade(80), 'B'); // Minimum B
      expect(calculator.getLetterGrade(70), 'C'); // Minimum C
      expect(calculator.getLetterGrade(60), 'D'); // Minimum D
      expect(calculator.getLetterGrade(59.9), 'F'); // Just below D
    });

    test('should throw error for invalid input', () {
      expect(() => calculator.getLetterGrade(-1), throwsArgumentError);
      expect(() => calculator.getLetterGrade(101), throwsArgumentError);
    });
  });

  // ============== اختبارات isPassing ==============
  group('isPassing', () {
    test('should return true for passing grades (>= 60)', () {
      expect(calculator.isPassing(60), true);
      expect(calculator.isPassing(75), true);
      expect(calculator.isPassing(100), true);
    });

    test('should return false for failing grades (< 60)', () {
      expect(calculator.isPassing(59), false);
      expect(calculator.isPassing(0), false);
      expect(calculator.isPassing(35.5), false);
    });

    test('should handle boundary values correctly', () {
      expect(calculator.isPassing(60), true);  // Exactly 60 - passing
      expect(calculator.isPassing(59.9), false); // Slightly less - failing
    });

    test('should throw error for invalid input', () {
      expect(() => calculator.isPassing(-5), throwsArgumentError);
      expect(() => calculator.isPassing(150), throwsArgumentError);
    });
  });

  // ============== اختبارات calculateAverage ==============
  group('calculateAverage', () {
    test('should calculate average of normal grades', () {
      final grades = [80.0, 90.0, 100.0];
      expect(calculator.calculateAverage(grades), closeTo(90.0, 0.001));
    });

    test('should calculate average of decimal grades', () {
      final grades = [85.5, 90.3, 78.2];
      expect(calculator.calculateAverage(grades), closeTo(84.666, 0.001));
    });

    test('should return 0 for empty list', () {
      expect(calculator.calculateAverage([]), 0.0);
    });

    test('should handle single grade', () {
      final grades = [75.5];
      expect(calculator.calculateAverage(grades), 75.5);
    });

    test('should handle all zeros', () {
      final grades = [0.0, 0.0, 0.0];
      expect(calculator.calculateAverage(grades), 0.0);
    });

    test('should throw error for invalid grades', () {
      expect(() {
        calculator.calculateAverage([80, -10, 90]);
      }, throwsArgumentError);

      expect(() {
        calculator.calculateAverage([80, 110, 90]);
      }, throwsArgumentError);
    });

    test('should calculate average of mixed grades', () {
      final grades = [59.0, 60.0, 70.0, 80.0, 90.0, 100.0];
      expect(calculator.calculateAverage(grades), closeTo(76.5, 0.001));
    });
  });

  // ============== اختبارات التكامل ==============
  group('Integration Tests', () {
    test('should maintain consistency between passing and letter grade', () {
      expect(calculator.isPassing(60), true);
      expect(calculator.getLetterGrade(60), 'D');
      
      expect(calculator.isPassing(59.9), false);
      expect(calculator.getLetterGrade(59.9), 'F');
    });

    test('should handle real world scenario', () {
      final studentGrades = [85.5, 92.0, 78.5, 68.0, 95.5];
      final average = calculator.calculateAverage(studentGrades);
      
      expect(average, closeTo(83.9, 0.1));
      expect(calculator.isPassing(average), true);
      expect(calculator.getLetterGrade(average), 'B');
    });
  });
}