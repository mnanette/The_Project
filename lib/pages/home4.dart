import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  void _goToPreviousScreen() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextScreen() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildOnboardingScreen(
                  title: 'Certification and Badges',
                  description: 'Earn a certificate after completion.',
                  image: 'assets/certification.png',
                ),
                _buildOnboardingScreen(
                  title: 'Progress Tracking',
                  description: 'Check your progress of every course.',
                  image: 'assets/progress_tracking.png',
                ),
                _buildOnboardingScreen(
                  title: 'Offline Access',
                  description: 'Make your course available offline.',
                  image: 'assets/offline_access.png',
                ),
                _buildOnboardingScreen(
                  title: 'Course Catalog',
                  description: 'View which courses you are enrolled in.',
                  image: 'assets/course_catalog.png',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(4, (index) => buildDot(index)),
              ],
            ),
          ),const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _goToPreviousScreen,
                child: Image.asset(
                  'assets/previous.png',
                  height: 40,
                  width: 40,
                ),
              ),
               
              const SizedBox(width: 250),
                           GestureDetector(
                onTap: _goToNextScreen,
                child: Image.asset(
                  'assets/next.png',
                  height: 40,
                  width: 40,
                ),
              ),

              
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    final isActive = index == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 4 : 4,
      width: isActive ? 40 : 40,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(0),     
      ),

    );
  }

  Widget _buildOnboardingScreen({
    required String title,
    required String description,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 200,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
