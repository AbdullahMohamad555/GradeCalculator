class GradeCalculator {
  /// Convert percentage to letter grade
  /// 90-100: A, 80-89: B, 70-79: C, 60-69: D, below 60: F
  String getLetterGrade(double percentage) {
    if (percentage < 0 || percentage > 100) {
      throw ArgumentError('Percentage must be between 0 and 100');
    }
    
    if (percentage >= 90) {
      return 'A';
    } else if (percentage >= 80) {
      return 'B';
    } else if (percentage >= 70) {
      return 'C';
    } else if (percentage >= 60) {
      return 'D';
    } else {
      return 'F';
    }
  }

  /// Check if grade is passing (>= 60%)
  bool isPassing(double percentage) {
    if (percentage < 0 || percentage > 100) {
      throw ArgumentError('Percentage must be between 0 and 100');
    }
    return percentage >= 60;
  }

  /// Calculate average of a list of grades
  double calculateAverage(List<double> grades) {
    if (grades.isEmpty) {
      return 0.0;
    }
    
    // Check for invalid grades
    for (var grade in grades) {
      if (grade < 0 || grade > 100) {
        throw ArgumentError('All grades must be between 0 and 100');
      }
    }
    
    double sum = 0.0;
    for (var grade in grades) {
      sum += grade;
    }
    return sum / grades.length;
  }
}