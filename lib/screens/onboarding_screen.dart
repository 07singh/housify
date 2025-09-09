import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      'image': 'assets/plant.png',
      'title': 'Easy Process',
      'desc':
      'Find all your house needs in one place.\nWe provide every service to make your \n home experience smooth.',
      'gradient':
      LinearGradient(colors: [Color(0xFFB97AF0), Color(0xFF9B5DE5)]),
    },
    {
      'image': 'assets/t.png',
      'title': 'Fast transportation',
      'desc':
      'We provide the best transportation service \nand organize your furniture properly to \nprevent any damage.',
      'gradient':
      LinearGradient(colors: [Color(0xFF5EA3F2), Color(0xFF3F78D4)]),
    },
    {
      'image': 'assets/e.png',
      'title': 'Expert people',
      'desc':
      'We have the best in class individuals \nworking just for you. They are well trained \nand capable of handling anything you need.',
      'gradient':
      LinearGradient(colors: [Color(0xFFF9A826), Color(0xFFF77F00)]),
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
            _currentPage == index ? const Color(0xFFFF7300) : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔶 Top Gradient Section
                    Container(
                      width: size.width,
                      height: size.height * 0.45,
                      decoration: BoxDecoration(
                        gradient: data['gradient'],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/welcome');
                              },
                              child: Container(
                                width: 60,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 80),
                              width: size.width * 0.6,
                              height: size.height * 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  data['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    // 🔸 Title with Bold Font
                    Text(
                      data['title'],
                      style: TextStyle(
                        fontFamily: "Poppins", // 👈 Custom Font
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.w600, // 600 = SemiBold
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: size.height * 0.02),

                    // 🔸 Description
                    SizedBox(
                      width: size.width * 0.8,
                      child: Text(
                        data['desc'],
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),

            // 🔸 Dots
            Positioned(
              bottom: size.height * 0.18,
              left: 0,
              right: 0,
              child: _buildDots(),
            ),

            // 🔶 Next / Get Started Button
            Positioned(
              bottom: size.height * 0.08,
              left: size.width * 0.1,
              child: InkWell(
                onTap: _nextPage,
                child: Container(
                  width: size.width * 0.8,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
