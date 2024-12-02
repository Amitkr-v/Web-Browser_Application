import 'package:browser/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Asplash extends StatefulWidget {
  @override
  _AsplashState createState() => _AsplashState();
}

class _AsplashState extends State<Asplash> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _checkIfSplashWasShown();
  }

  Future<void> _checkIfSplashWasShown() async {
    final prefs = await SharedPreferences.getInstance();

    // Safely check if the splash screen was shown
    final splashShown = prefs.getBool('splashShown') ?? false;

    if (splashShown) {
      // If splash screen was already shown, navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // If splash screen was not shown, set the flag and show the splash screen
      await prefs.setBool('splashShown', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  Column1(
                    context,
                    'assets/animation/anim2.json',
                    'No ads',
                    'A browser with no ads, no pops and no tracking of device',
                  ),
                  Column1(context, 'assets/animation/anim1.json', 'Security',
                      'Your data is in your hand, Stored locally in your device'),
                  Column2(context, 'assets/animation/anim3.json', '', ''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Color(0xFF102C57),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column Column1(BuildContext context, String p1, String t1, String t2) {
    return Column(
      children: <Widget>[
        SizedBox(height: 40),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Lottie.asset(
            p1,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Color(0xFF102C57),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: t1,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                                text:
                                    '\n \n'), // Adds a newline between t1 and t2
                            TextSpan(
                              text: t2,
                              style: TextStyle(
                                fontSize: 25, // Adjust font size for t2
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column Column2(BuildContext context, String p1, String t1, String t2) {
    return Column(
      children: <Widget>[
        SizedBox(height: 40),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Lottie.asset(
            p1,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Color(0xFF102C57),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: t1,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                                text:
                                    '\n \n'), // Adds a newline between t1 and t2
                            TextSpan(
                              text: t2,
                              style: TextStyle(
                                fontSize: 25, // Adjust font size for t2
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.08,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'RobotoSerif',
                        color: Color(0xFF102C57),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF102C57),
                                Color(0xFF102C57),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Get started!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Made with ",
                          style: TextStyle(color: Color(0xFF102C57)),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Color(0xFFFC4100),
                        ),
                        Text(
                          " by Pseudocraft",
                          style: TextStyle(color: Color(0xFF102C57)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
