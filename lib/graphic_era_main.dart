import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uniview/graphic_era_attendance.dart';
import 'package:uniview/graphic_era_exam.dart';
import 'package:uniview/graphic_era_home.dart';
import 'package:uniview/graphic_era_theme.dart';

class GraphicEraMain extends StatefulWidget {
  const GraphicEraMain({super.key});

  @override
  State<GraphicEraMain> createState() => _GraphicEraMain();
}

class _GraphicEraMain extends State<GraphicEraMain> {
  late final PageController _pageController;
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  // cache styles once
  late final TextStyle _selectedLabelStyle;
  late final TextStyle _unselectedLabelStyle;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _selectedLabelStyle = kTagsStyle.copyWith(fontSize: 18);
    _unselectedLabelStyle = kTagsStyle.copyWith(fontSize: 16);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: graphicWhite,

      // ---------- BODY ----------
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          _indexNotifier.value = value;
        },
        children: const [
          GraphicEraHome(),
          GraphicEraAttendance(),
          GraphicEraExam(),
        ],
      ),

      // ---------- BOTTOM NAV ----------
      bottomNavigationBar: SafeArea(
        top: false,
        child: ValueListenableBuilder<int>(
          valueListenable: _indexNotifier,
          builder: (_, index, __) {
            return SizedBox(
              height: 68,
              child: BottomNavigationBar(
                currentIndex: index,
                onTap: (value) {
                  _pageController.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                iconSize: 24,
                selectedItemColor: primaryColor,
                unselectedItemColor: graphicBlack.withValues(alpha: 0.50),
                selectedLabelStyle: _selectedLabelStyle,
                unselectedLabelStyle: _unselectedLabelStyle,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.idCard),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.calendar),
                    label: "Attendance",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.rectangleList),
                    label: "Exam",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
