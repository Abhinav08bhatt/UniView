import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uniview/graphic_era_theme.dart';
import 'package:url_launcher/url_launcher.dart'; 


/* =================================== MAIN CLASS =================================== */
class GraphicEraExam extends StatelessWidget {
  const GraphicEraExam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

// background color of the page
      backgroundColor: graphicWhite,

/* ----------------------------------- MAIN BODY ----------------------------------- */
      body: const _ExamScrollView(),
    );
  }
}

/* 
Exam Page : 

This page is based on current conditions of the exam status.
the exam status has been divided into 3 factors : 
1. before exam
2. during exam
3. after exam
(all 3 of the conditions are in a cycle : meaning always one of the condition is true)

- Before exam : (20 days after result - the day of admit card release)
here we want the user to know the approx dates of the exam time and give them
academic calender as an option to view the approx dates

- during exam : (day the admit card is released - the day of last exam)
here we give the user direct message of the exam dates and also gives them 
option to access their admit card for exam usage

- after exam : (day the exam ends - 20 days after result release)
here we have 2 conditions :
  1. result waiting (day the exams end - the day the result is announced)
  2. result announced (the day the result is announced - 20 days after result release)

goal is to get the status message from the backend and show the appropriate page and give 
access to the required info.
 */


/* ================================= CASES VARIABLES ================================ */
enum ExamType {
  midSem,
  endSem,
}
enum ExamPhase {
  before,
  during,
  after,
}
enum ResultStatus {
  waiting,
  announced,
}

/* ----------------------------------- MAIN BODY ----------------------------------- */
class _ExamScrollView extends StatelessWidget {
  const _ExamScrollView();

  @override
  Widget build(BuildContext context) {
    return ListView(

// PAGE DECORATIONS
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: const [

/* ==================================== APP BAR ==================================== */
        ExamAppBar(),

/* =================================== MAIN CARD =================================== */
        ExamMainCard(
// need to link this to the backend
          phase: ExamPhase.during,
          type: ExamType.midSem,
        ),

        kH16,

        Divider(
          indent: 20,
          endIndent: 20,
        ),

/* =================================== ADDITIONS =================================== */
        SecondarySection(),
      
      ],
    );
  }
}


// --------------------------------------------------------------------------------- //


/* ==================================== APP BAR ==================================== */
class ExamAppBar extends StatelessWidget {
  const ExamAppBar({super.key});

  @override
  Widget build(BuildContext context) {

// content : page heading + link button 
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

// page heading
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH6,
                Text(
                  "Exam",
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

// link button
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


/* =================================== MAIN CARD =================================== */
class ExamMainCard extends StatelessWidget {
// needed
  final ExamPhase phase;
  final ExamType type;
  final ResultStatus? resultStatus;

  const ExamMainCard({
    super.key,
    required this.phase,
    required this.type,
    this.resultStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(

// content
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      
// card decorations
      child: _ExamCardShell(

/* ================================ MAIN CARD CONTENT =============================== */ 
// needed to connect to the backend
        child: _ExamPhaseContent(
          phase: phase,
          type: type,
          resultStatus: resultStatus,
        ),
      ),
    );
  }
}

// card decorations
class _ExamCardShell extends StatelessWidget {
  final Widget child;

  const _ExamCardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.20),
            spreadRadius: 4,
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
  }
}

// page cases depending on the action given from the condition given from the backend
class _ExamPhaseContent extends StatelessWidget {
// needed
  final ExamPhase phase;
  final ExamType type;
  final ResultStatus? resultStatus;

  const _ExamPhaseContent({
    required this.phase,
    required this.type,
    this.resultStatus,
  });

  @override
  Widget build(BuildContext context) {

// cases
    switch (phase) {
      case ExamPhase.before:

// case  : before
        return BeforeExamClass(examType: type);

// case  : during
      case ExamPhase.during:
        return DuringExamClass(examType: type);

// case  : after
      case ExamPhase.after:
        assert(
          resultStatus != null,
          'resultStatus must be provided when phase is after',
        );
        return AfterExamClass(
          examType: type,
          resultStatus: resultStatus!,
        );
    }
  }
}


/* =================================== CONDITIONS =================================== */


/* ----------------------------------- BEFORE EXAM ---------------------------------- */

class BeforeExamClass extends StatelessWidget {
  final ExamType examType;

  const BeforeExamClass({
    super.key,
    required this.examType,
  });

  String _resolveTitle() {
    switch (examType) {
      case ExamType.midSem:
        return "Mid Semester Exam";
      case ExamType.endSem:
        return "End Semester Exam";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = _resolveTitle();

    return SizedBox(
      height: 460,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: kInfoHeadingStyle),
            kH4,
            const Divider(indent: 12, endIndent: 12),
            kH16,
            Text(
              "Expected exam period",
              style: kInfoHeadingStyle.copyWith(
                fontSize: 18,
                letterSpacing: 0,
              ),
            ),
            Text(
              "24 Feb 2026  -  18 Mar 2026",
              style: kSubHeadingStyle.copyWith(
                fontSize: 16,
                letterSpacing: 0,
              ),
            ),
            const Spacer(),
            const _BeforeExamNotice(),
            const Spacer(),
            const _BeforeExamFooter(),
          ],
        ),
      ),
    );
  }
}


class _BeforeExamNotice extends StatelessWidget {
  const _BeforeExamNotice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(46.0),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: kSubHeadingStyle.copyWith(color: Colors.black),
          children: const [
            TextSpan(text: "Admit card will be available approximately "),
            TextSpan(
              text: "10 days",
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(text: " before the exam."),
          ],
        ),
      ),
    );
  }
}

class _BeforeExamFooter extends StatelessWidget {
  const _BeforeExamFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: secondaryColor,
            overlayColor: primaryColor,
            shadowColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Text(
              "View Academic Calendar",
              style: kSubHeadingStyle.copyWith(color: thirdColor),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text("Last updates : 23 Jan 2026"),
      ],
    );
  }
}


/* ----------------------------------- DURING EXAM ---------------------------------- */

class DuringExamClass extends StatelessWidget {
  final ExamType examType;

  const DuringExamClass({
    super.key,
    required this.examType,
  });

  String _resolveTitle() {
    switch (examType) {
      case ExamType.midSem:
        return "Mid Semester Exam";
      case ExamType.endSem:
        return "End Semester Exam";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = _resolveTitle();

    return SizedBox(
      height: 460,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: kInfoHeadingStyle),
            kH4,
            const Divider(indent: 12, endIndent: 12),
            const Spacer(),
            const _DuringExamPeriod(),
            kH16,
            const _DuringExamAction(),
            const Spacer(),
            const _ExamLastUpdated(),
          ],
        ),
      ),
    );
  }
}

class _DuringExamPeriod extends StatelessWidget {
  const _DuringExamPeriod();

  @override
  Widget build(BuildContext context) {
    return Text(
      "24 Feb 2026  -  18 Mar 2026",
      style: kSubHeadingStyle.copyWith(
        fontSize: 16,
        letterSpacing: 0,
      ),
    );
  }
}

class _DuringExamAction extends StatelessWidget {
  const _DuringExamAction();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 4,
        backgroundColor: thirdColor,
        overlayColor: Colors.white,
        shadowColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Text(
          "Download Admit Card",
          style: kHeadingStyle.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}


/* ----------------------------------- AFTER EXAM ---------------------------------- */

class AfterExamClass extends StatelessWidget {
  final ExamType examType;
  final ResultStatus resultStatus;

  const AfterExamClass({
    super.key,
    required this.examType,
    required this.resultStatus,
  });

  String _resolveTitle() {
    switch (examType) {
      case ExamType.midSem:
        return "Mid Semester Exam";
      case ExamType.endSem:
        return "End Semester Exam";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = _resolveTitle();

    return SizedBox(
      height: 460,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: kInfoHeadingStyle),
            kH4,
            const Divider(indent: 12, endIndent: 12),
            const Spacer(),
            if (resultStatus == ResultStatus.waiting)
              const _ResultWaiting(),
            if (resultStatus == ResultStatus.announced)
              const _ResultAnnounced(),
            const SizedBox(height: 60),
            const _ExamLastUpdated(),
          ],
        ),
      ),
    );
  }
}

class _ResultAnnounced extends StatelessWidget {
  const _ResultAnnounced();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Result published",
          style: kInfoHeadingStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 100),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 4,
            backgroundColor: thirdColor,
            overlayColor: Colors.white,
            shadowColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            child: Text(
              "View Result",
              style: kHeadingStyle.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultWaiting extends StatelessWidget {
  const _ResultWaiting();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Examinations completed\nResults will be published soon.",
          style: kInfoHeadingStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You will be notified\nonce the result\nis announced",
              style: kSubHeadingStyle.copyWith(height: 0),
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            kW16,
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                shadowColor: primaryColor,
                highlightColor: thirdColor,
                padding: const EdgeInsets.all(12),
              ),
              icon: const Icon(
                Icons.notifications_active_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


/* =================================== LAST UPDATE ================================== */
// needs to be connected to the backend
class _ExamLastUpdated extends StatelessWidget {
  const _ExamLastUpdated();

  @override
  Widget build(BuildContext context) {
    return const Text("Last updates : 23 Jan 2026");
  }
}

// --------------------------------------------------------------------------------- //


/* ================================== SECONDARY SECTION ============================= */
class SecondarySection extends StatelessWidget {
  const SecondarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SecondaryTitle(),
          kH6,
          kH4,
          _SecondaryList(),
        ],
      ),
    );
  }
}

class _SecondaryTitle extends StatelessWidget {
  const _SecondaryTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      " Other exam records",
      style: kInfoHeadingStyle,
    );
  }
}

class _SecondaryList extends StatelessWidget {
  const _SecondaryList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SecondaryTile(
          title: "Academic Calendar",
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
        ),
        _SecondaryTile(
          title: "Previous Results",
        ),
        _SecondaryTile(
          title: "Previous Admit Cards",
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondaryTile extends StatelessWidget {
  final String title;
  final ShapeBorder? shape;

  const _SecondaryTile({
    required this.title,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      shape: shape,
      tileColor: secondaryColor,
      splashColor: primaryColor.withValues(alpha: 0.40),
      title: Text(
        title,
        style: kSubHeadingStyle,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
    );
  }
}
