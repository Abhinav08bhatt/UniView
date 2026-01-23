import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uniview/graphic_era_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectAttendance {
  final String subject;
  final double attendance;

  const SubjectAttendance({
    required this.subject,
    required this.attendance,
  });
}

const List<SubjectAttendance> kAttendanceData = [
  SubjectAttendance(subject: "Subject 1", attendance: 54),
  SubjectAttendance(subject: "Subject 2", attendance: 45),
  SubjectAttendance(subject: "Subject 3", attendance: 75.24),
  SubjectAttendance(subject: "Subject 4", attendance: 80),
  SubjectAttendance(subject: "Subject 5", attendance: 54),
  SubjectAttendance(subject: "Subject 6", attendance: 76),
  SubjectAttendance(subject: "Subject 7", attendance: 88),
];


class GraphicEraAttendance extends StatelessWidget {
  const GraphicEraAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: graphicWhite,
      body: const _AttendanceScrollView(),
    );
  }
}

class _AttendanceScrollView extends StatelessWidget {
  const _AttendanceScrollView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: const [
        AttendanceAppBar(),
        OverallAttendanceSection(),
        _AttendanceHint(),
        AttendanceTableView(),
      ],
    );
  }
}

class _AttendanceHint extends StatelessWidget {
  const _AttendanceHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "* click the section for detailed information",
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}


// 
class OverallAttendanceSection extends StatelessWidget {
  const OverallAttendanceSection({super.key});

  double _calculateAverage() {
    double sum = 0;
    for (final item in kAttendanceData) {
      sum += item.attendance;
    }
    return sum / kAttendanceData.length;
  }

  @override
  Widget build(BuildContext context) {
    final double averageAttendance = _calculateAverage();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DateProgressLine(),
          const DateLabelsRow(),
          kH8,
          OverallAttendanceCalculation(
            totalAttendance: averageAttendance,
          ),
          kH16,
        ],
      ),
    );
  }
}

class OverallAttendanceCalculation extends StatelessWidget {
  final double totalAttendance;

  const OverallAttendanceCalculation({
    super.key,
    required this.totalAttendance,
  });

  @override
  Widget build(BuildContext context) {
    final Color attendanceColor =
        totalAttendance >= 75 ? Colors.green : Colors.redAccent;

    return Row(
      children: [
        const Text(
          "Total Average Attendance : ",
          style: TextStyle(fontSize: 26),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "${totalAttendance.toStringAsFixed(2)} %",
          style: TextStyle(
            color: attendanceColor,
            fontSize: 30,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}


class DateProgressLine extends StatelessWidget {
  const DateProgressLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Line
          CustomPaint(
            size: Size(double.infinity, 2),
            painter: DashedLinePainter(),
          ),

          // Left dot
          Positioned(
            left: 10,
            child: _Dot(),
          ),

          // Right dot
          Positioned(
            right: 10,
            child: _Dot(),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: thirdColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = thirdColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final startX = 20.0;
    final endX = size.width - 20.0;
    final centerY = size.height / 2;

    // Left solid
    canvas.drawLine(
      Offset(startX, centerY),
      Offset(startX + 40, centerY),
      paint,
    );

    // Right solid
    canvas.drawLine(
      Offset(endX - 40, centerY),
      Offset(endX, centerY),
      paint,
    );

    // Dashed middle
    const dashWidth = 6;
    const dashSpace = 6;

    double x = startX + 40;

    while (x < endX - 40) {
      canvas.drawLine(
        Offset(x, centerY),
        Offset(x + dashWidth, centerY),
        paint,
      );
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DateLabelsRow extends StatelessWidget {
  const DateLabelsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          '5 Jan\n2026',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 0,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          '23 Jan\n2026',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 0,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}
class AttendanceAppBar extends StatelessWidget {
  const AttendanceAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH6,
                Text(
                  "Attendance",
                  style: kGraphicLogo.copyWith(
                    fontSize: 32,
                    height: 1.16,
                    letterSpacing: 0,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: primaryColor,
                ),
              ],
            ),
          ),
          kW4,
          DecoratedBox(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child: IconButton(
              onPressed: () {
                launchUrl(
                  Uri.parse('https://student.geu.ac.in'),
                  mode: LaunchMode.externalApplication,
                );
              },
              padding: const EdgeInsets.all(12),
              highlightColor: secondaryColor,
              icon: const Padding(
                padding: EdgeInsets.fromLTRB(2, 2, 4, 2),
                child: Icon(
                  FontAwesomeIcons.link,
                  color: graphicWhite,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// table tile content
class AttendanceSubjectWiseTile extends StatelessWidget {
  final String subject;
  final double attendance;

  const AttendanceSubjectWiseTile({
    super.key,
    required this.subject,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    final Color attendanceColor =
        attendance >= 75 ? Colors.green : Colors.redAccent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              subject,
              style: kInfoHeadingStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              "${attendance.toStringAsFixed(2)} %",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: attendanceColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Attendance table content
class AttendanceSubjectWise extends StatelessWidget {
  const AttendanceSubjectWise({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
        child: Column(
          children: List.generate(
            kAttendanceData.length,
            (index) {
              final item = kAttendanceData[index];

              return Column(
                children: [
                  AttendanceSubjectWiseTile(
                    subject: item.subject,
                    attendance: item.attendance,
                  ),
                  if (index != kAttendanceData.length - 1)
                    const Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AttendanceTableHeading extends StatelessWidget {
  const AttendanceTableHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: thirdColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          topLeft: Radius.circular(28),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subject",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "Attendance",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceTableView extends StatelessWidget {
  const AttendanceTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Column(
        children: const [
          AttendanceTableHeading(),
          AttendanceSubjectWise(),
        ],
      ),
    );
  }
}
