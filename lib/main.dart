import 'package:flutter/material.dart';
import 'models/grade_calculator.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const GradeCalculatorScreen(),
    );
  }
}

class GradeCalculatorScreen extends StatefulWidget {
  const GradeCalculatorScreen({super.key});

  @override
  State<GradeCalculatorScreen> createState() => _GradeCalculatorScreenState();
}

class _GradeCalculatorScreenState extends State<GradeCalculatorScreen> {
  final GradeCalculator _calculator = GradeCalculator();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _gradesController = TextEditingController();
  
  String _letterGradeResult = '';
  String _passingResult = '';
  String _averageResult = '';
  String _errorMessage = '';

  @override
  void dispose() {
    _percentageController.dispose();
    _gradesController.dispose();
    super.dispose();
  }

  void _calculateLetterGrade() {
    setState(() {
      _errorMessage = '';
      try {
        final percentage = double.parse(_percentageController.text);
        _letterGradeResult = _calculator.getLetterGrade(percentage);
        _passingResult = _calculator.isPassing(percentage) ? 'Passing' : 'Failing';
      } catch (e) {
        _errorMessage = 'Invalid input: ${e.toString()}';
        _letterGradeResult = '';
        _passingResult = '';
      }
    });
  }

  void _calculateAverage() {
    setState(() {
      _errorMessage = '';
      try {
        final grades = _gradesController.text
            .split(',')
            .map((e) => double.parse(e.trim()))
            .toList();
        final average = _calculator.calculateAverage(grades);
        _averageResult = 'Average: ${average.toStringAsFixed(2)}%';
      } catch (e) {
        _errorMessage = 'Invalid grades: ${e.toString()}';
        _averageResult = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Grade Converter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _percentageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter percentage',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., 85.5',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _calculateLetterGrade,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Get Letter Grade'),
                    ),
                    if (_letterGradeResult.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Letter Grade: $_letterGradeResult',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Status: $_passingResult',
                        style: TextStyle(
                          fontSize: 18,
                          color: _passingResult == 'Passing' 
                              ? Colors.green 
                              : Colors.red,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Average Calculator',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _gradesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter grades (comma separated)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., 85, 90, 75.5, 88',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _calculateAverage,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Calculate Average'),
                    ),
                    if (_averageResult.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        _averageResult,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
