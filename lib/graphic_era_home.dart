import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uniview/graphic_era_theme.dart';
import 'package:url_launcher/url_launcher.dart';


/* ========================================== HOME PAGE ========================================== */ 
class GraphicEraHome extends StatelessWidget {
  const GraphicEraHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },

/*  ----------------------------------------- MAIN CLASS ----------------------------------------- */
        child: const _HomeScrollView(),
      ),
    );
  }
}


/* ========================================== MAIN CLASS ========================================== */ 
class _HomeScrollView extends StatelessWidget {
  const _HomeScrollView();

  @override
  Widget build(BuildContext context) {
    return ListView(

/*  --------------------------------------- PAGE PROPERTIES --------------------------------------- */
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.zero,

      children: const [

/*  ------------------------------------------- APP BAR ------------------------------------------- */
        HomeAppBar(),

/*  ------------------------------------------- ID STACK ------------------------------------------ */
        StudentIDStack(),

/*  ------------------------------------------ SEARCH BAR ----------------------------------------- */
// DESERVES NO PURPOSE IN THIS APP
        // Padding(
        //   padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
        //   child: TopSearchBar(),
        // ),
        const SizedBox(height: 16,),
        
/*  -------------------------------------------- DIVIDER ------------------------------------------ */
        Divider(
          indent: 16,
          endIndent: 16,
        ),

/*  ------------------------------------------ UPDATES BAR ---------------------------------------- */
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 10),
          child: UpdatesSection(attendancePercentage: 75),
        ),
      ],
    );
  }
}

/* ============================================ APP BAR =========================================== */ 
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),

/*  -------------------------------------------- CONTENT ------------------------------------------ */
      child: Row(
// LOGO + TAGLINE + LINK BUTTON
        children: const [

/*  --------------------------------------------- LOGO -------------------------------------------- */
          _AppBarImage(),
          
          kW6,

/*  ----------------------------------- TAGLINE + LINK BUTTON ------------------------------------- */
          Expanded(child: _AppBarContent()),
        ],
      ),
    );
  }
}


/*  ============================================ LOGO ============================================= */
class _AppBarImage extends StatelessWidget {
  const _AppBarImage();

  @override
  Widget build(BuildContext context) {

/*  ---------------------------------------- CIRCLE AVATAR ---------------------------------------- */
    return CircleAvatar(
      radius: 28,
      backgroundColor: graphicWhite,

/*  ----------------------------------------- ASSET IMAGE ----------------------------------------- */
      child: Image.asset(
        "assets/images/graphic-era-university-dehradun-logo.png",
        fit: BoxFit.contain,
      ),
    );
  }
}

/*  ------------------------------------ TAGLINE + LINK BUTTON ------------------------------------ */
class _AppBarContent extends StatelessWidget {
  const _AppBarContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

/*  ------------------------------------ TAGLINE + LINK BUTTON ------------------------------------ */
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
/*  ------------------------------------------ TAGLINE -------------------------------------------- */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Graphic",
                        style: kGraphicLogo.copyWith(color: Colors.red)),
                    Text(" Era", style: kGraphicLogo),
                  ],
                ),
                Text(
                  "Deemed to be University",
                  style: kTagsStyle.copyWith(fontSize: 14,height: 1),
                ),
              ],
            ),

/*  ---------------------------------------- LINK BUTTON ------------------------------------------ */
// Takes the students to the college website for detailed info
            DecoratedBox(

/*  --------------------------------------- BOX PROPERTIES ---------------------------------------- */
              decoration: BoxDecoration(
                color: graphicWhite,
                borderRadius: BorderRadius.circular(32),
              ),

/*  -------------------------------------- NAVIGATION LOGIC --------------------------------------- */
              child: IconButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse('https://student.geu.ac.in'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                padding: const EdgeInsets.all(12),
                highlightColor: secondaryColor,
              
/*  ------------------------------------------ CONTENT -------------------------------------------- */
                icon: const Icon(
                  FontAwesomeIcons.link,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),

/*  ------------------------------------------ DIVIDER -------------------------------------------- */
        const Divider(height : 2,thickness: 2, color: primaryColor),
      ],
    );
  }
}


/* ========================================== ID STACK ============================================ */ 
class StudentIDStack extends StatelessWidget {
  const StudentIDStack({super.key});

  @override
  Widget build(BuildContext context) {
/*  ------------------------------------------ CONTENT -------------------------------------------- */    
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0), 
      child: const SizedBox(

// STACK HEIGHT : 442
        height: 442,
        child: Stack(
          children: [

/*  ------------------------------------------ base box ------------------------------------------- */    
            Positioned(
              top: 62,
              bottom: 0,
              left: 0,
              right: 0,
              child: _BaseBox(),
            ),

/*  --------------------------------------- student avatar ---------------------------------------- */    
            Positioned(
              top: 4,
              left: 14,
              child: _StudentAvatar(),
            ),

/*  --------------------------------------- show ID button ---------------------------------------- */    
            Positioned(
              top: 0,
              right: 0,
              child: _ShowIDButtonWrapper(),
            ),

/*  ------------------------------------------ main info ------------------------------------------ */    
            Positioned(
              top: 72,
              left: 186,
              right: 16,
              child: _MainInfo(),
            ),

/*  ---------------------------------------- academic info ---------------------------------------- */    
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: AcademicInfo(),
            ),
          ],
        ),
      ),
    );
  }
}


/*  ------------------------------------------ base box ------------------------------------------- */
class _BaseBox extends StatelessWidget {
  const _BaseBox();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
/*  --------------------------------------- box properties ----------------------------------------- */
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.20),
            spreadRadius: 4,
            blurRadius: 12,
          )
        ],
      ),

/*  --------------------------------- content box height : 380 ------------------------------------- */
      child: const SizedBox(height: 380),
    );
  }
}

/*  --------------------------------------- student avatar ------------------------------------------ */
class _StudentAvatar extends StatelessWidget {
  const _StudentAvatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
/*  --------------------------------------- picture border ------------------------------------------ */
      radius: 80, 
      backgroundColor: primaryColor,
/*  --------------------------------------- profile picture ----------------------------------------- */
      child: CircleAvatar(
        radius: 77,
        backgroundColor: graphicWhite,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ClipOval(
/*  ---------------------------------------- image asset -------------------------------------------- */
            child: Image.asset(
              "assets/images/profile_pic_4_50w.jpg",
              fit: BoxFit.cover,
/*  -------------------------------------- picture dimension ---------------------------------------- */
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}

/*  ---------------------------------------- show ID button ------------------------------------------ */
class _ShowIDButtonWrapper extends StatelessWidget {
  const _ShowIDButtonWrapper();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

// show ID button logic
      onPressed: () {
// to placeholder()
      },

      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
      ),
      child: const _ShowIDButton(),
    );
  }
}

/*  ---------------------------------- show ID button decorations ------------------------------------ */
class _ShowIDButton extends StatelessWidget {
  const _ShowIDButton();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
/*  -------------------------------------- box decorations ------------------------------------------- */
      decoration: BoxDecoration(
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.20),
            spreadRadius: 4,
            blurRadius: 4,
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(32),
          topRight: Radius.circular(32),
          bottomLeft: Radius.circular(28),
        ),
      ),
/*  --------------------------------------- show ID button ------------------------------------------- */
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Show ID",
              style: kInfoHeadingStyle.copyWith(
                fontSize: 20,
                height: 1.4,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              FontAwesomeIcons.idCardClip,
              color: thirdColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}


/*  ------------------------------------------- main info -------------------------------------------- */
// Main Info : Name + Course + Year + Semester
class _MainInfo extends StatelessWidget {
  const _MainInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
/*  ----------------------------------------- student name -------------------------------------------- */
          "Abhinav Bhatt",
          style: kHeadingStyle.copyWith(fontSize: 24),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
/*  ---------------------------------------- student course ------------------------------------------- */
          "BSc (H.) Computer Science",
          style: kSubHeadingStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
/*  --------------------------------------- student year & sem ---------------------------------------- */
        Row(
          children: [
            Text("Year : ", style: kHeadingStyle),
            Text("1", style: TextStyle(fontSize: 20)),
            SizedBox(width: 16),
            Text("Semester : ", style: kHeadingStyle),
            Text("2", style: TextStyle(fontSize: 20)),
          ],
        ),
      ],
    );
  }
}

/*  ----------------------------------------- Tile Structure ------------------------------------------ */
class InfoTile extends StatelessWidget {
// needed
  final String label;
  final String value;

  const InfoTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),

/*  ------------------------------------------- Tile Label -------------------------------------------- */
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: kInfoHeadingStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          const SizedBox(width: 8),

/*  ------------------------------------------- Tile value -------------------------------------------- */
          Text(
            value,
            style: kInfoStyle,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

/*  ----------------------------------------- Academic Info ------------------------------------------- */ 
class AcademicInfo extends StatelessWidget {
  const AcademicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(

/*  ----------------------------------------- box decoration ------------------------------------------ */ 
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        child: Column(
          children: const [

/*  ----------------------------------------- Official Email ------------------------------------------ */ 
            InfoTile(label: "Official Email", value: "12345678@geu.ac.in"),
            Divider(),
/*  ----------------------------------------- Class Roll No ------------------------------------------- */ 
            InfoTile(label: "Class Roll No.", value: "00"),
            Divider(),
/*  ------------------------------------------- Enroll No --------------------------------------------- */ 
            InfoTile(label: "Enroll No.", value: "GE-12345678"),
            Divider(),
/*  --------------------------------------- University Roll No ---------------------------------------- */ 
            InfoTile(label: "University Roll No.", value: "1234567890",),
            Divider(),
/*  ----------------------------------------- Official Email ------------------------------------------ */ 
            InfoTile(label: "Status", value: "Active"),
          ],
        ),
      ),
    );
  }
}


/*  ----------------------------------------- Academic Info ------------------------------------------- */ 
class UpdatesSection extends StatelessWidget {
// needed
  final int attendancePercentage;

  const UpdatesSection({
    super.key,
    required this.attendancePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

/*  --------------------------------------------- title ----------------------------------------------- */ 
        const _SecondaryTitle(),
        kH6,
        kH4,
/*  ----------------------------------------- updating cards ------------------------------------------ */ 
        _UpdatesCard(attendancePercentage: attendancePercentage),
      ],
    );
  }
}

/*  ----------------------------------------- Academic Info ------------------------------------------- */ 
class _SecondaryTitle extends StatelessWidget {
  const _SecondaryTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Updates",
      style: kInfoHeadingStyle,
    );
  }
}


/*  ----------------------------------------- Academic Info ------------------------------------------- */ 
class _UpdatesCard extends StatelessWidget {
  final int attendancePercentage;

  const _UpdatesCard({
    required this.attendancePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLowAttendance = attendancePercentage < 75;

    return Container(
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          _AttendanceRow(
            attendancePercentage: attendancePercentage,
            isLowAttendance: isLowAttendance,
          ),
          kH16,
          _AdmitCardRow(),
        ],
      ),
    );
  }
}


// dummy (needed to be connected to attendance page)
class _AttendanceRow extends StatelessWidget {
  final int attendancePercentage;
  final bool isLowAttendance;

  const _AttendanceRow({
    required this.attendancePercentage,
    required this.isLowAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Current Attendance :",
            style: kSubHeadingStyle,
          ),
          Text(
            "$attendancePercentage %",
            style: kSubHeadingStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: isLowAttendance ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}


// dummy (needed to be connected to exam page)
class _AdmitCardRow extends StatelessWidget {
  const _AdmitCardRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Admit Card\nReleased",
            style: kSubHeadingStyle,
          ),
          ElevatedButton(
            onPressed: () {}, // intentionally does nothing
            style: ElevatedButton.styleFrom(
              elevation: 2,
              backgroundColor: primaryColor,
              padding: const EdgeInsets.fromLTRB(24,14,24,14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Download",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
