import 'package:flutter/material.dart';
import '../data/sample_questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;

  void selectOption(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  void nextQuestion() {
    if (selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih dulu jawaban sebelum lanjut!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Jawaban kamu: ${sampleQuestions[currentQuestionIndex]['options'][selectedOptionIndex!]}'),
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (currentQuestionIndex < sampleQuestions.length - 1) {
            currentQuestionIndex++;
            selectedOptionIndex = null;
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const QuizFinishedScreen()),
            );
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = sampleQuestions[currentQuestionIndex];
    var options = currentQuestion['options'] as List<String>;

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('Quiz D4 Manajemen Informatika'),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    currentQuestion['question'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(options.length, (index) {
                    return QuizOption(
                      optionText: options[index],
                      isSelected: selectedOptionIndex == index,
                      onTap: () => selectOption(index),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[800],
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizOption extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOption({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.red : const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal[800]!),
          ),
          child: Text(
            optionText,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class QuizFinishedScreen extends StatelessWidget {
  const QuizFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('Kuis Selesai!'),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selamat! Kamu telah menyelesaikan kuis.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[800],
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Kembali ke Awal',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
