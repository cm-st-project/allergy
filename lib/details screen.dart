import "package:flutter/material.dart";

class AdviceForUserPage extends StatelessWidget {
  String allergyAdvice = 'Please provide your personal details initially';
  late final int _riskLevel;
  late final String _imagePath;

  AdviceForUserPage({
    super.key,
    required riskLevel,
  }) {
    _riskLevel = int.parse(riskLevel);
    generateAllergyAdvice();
  }

  void generateAllergyAdvice() {
    print(_riskLevel);
    if (_riskLevel >= 1 && _riskLevel <= 3) {
      allergyAdvice = "Low risk of allergies. Enjoy your day!";
      _imagePath = 'assets/lowRisk.png';
    } else if (_riskLevel >= 4 && _riskLevel <= 7) {
      allergyAdvice = "Medium risk of allergies. Be cautious and read labels.";
      _imagePath = 'assets/mediumRisk.png';
    } else if (_riskLevel > 7) {
      allergyAdvice =
          "High risk of allergies. Take extra precautions and consult a medical professional.";
      _imagePath = 'assets/highRisk.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADVICE~"),
      ),
      body: _riskLevel == 0
          ? Center(
              child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    allergyAdvice,
                    style: const TextStyle(fontSize: 40),
                  )))
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset(_imagePath),
                    Text(
                      allergyAdvice,
                      style: const TextStyle(fontSize: 40),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
