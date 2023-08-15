import 'package:allergy_app/home%20screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  const MyHomePage(title: 'Allergy App Home Page')));
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO( 103, 175, 227, 1.0),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'Allergy App',
                    style: TextStyle(fontSize: 40),
                  ),
                  const Spacer(),
                  Container(
                    height: 180,
                    width: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: const [
                      Text(
                        'Version',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '1.0.0',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 630,
            )
          ],
        ),
      ),
    );
  }
}
