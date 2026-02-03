import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uniview/graphic_era_theme.dart';
import 'package:url_launcher/url_launcher.dart';


/* ========================================== HOME PAGE =========================================== */ 
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

/*  ----------------------------------------- MAIN CLASS ------------------------------------------ */
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
          child: UpdatesSection(attendancePercentage: 67.46),
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

/*  ------------------------------------ TAGLINE + LINK BUTTON ------------------------------------ */
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
/* can be an setting or menu icon that opens a side section with options : 
link to the official erp : about us and other in future stuff */
            DecoratedBox(

/*  --------------------------------------- BOX PROPERTIES ---------------------------------------- */
              decoration: BoxDecoration(
                color: graphicWhite,
                borderRadius: BorderRadius.circular(32),
              ),

/*  -------------------------------------- NAVIGATION LOGIC --------------------------------------- */
              child: IconButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: "Menu",
                    barrierColor: Colors.black38,
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) {
                      return const _RightSideMenu();
                    },
                    transitionBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  );
                },
                padding: const EdgeInsets.all(12),
                highlightColor: secondaryColor,
/*  ------------------------------------------ CONTENT -------------------------------------------- */
                icon: const Icon(
                  Icons.menu,
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

class _RightSideMenu extends StatelessWidget {
  const _RightSideMenu();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: graphicWhite,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.50),
                spreadRadius: 4,
                blurRadius: 24
              )
            ]
          ),
          child: SizedBox(
            // width: 260,
            width: (MediaQuery.of(context).size.width/2) + 22 ,
            height: double.infinity,
            child: ListView(
              children: [

                SizedBox(
                  child: Column(
                    children: [
                      
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/images/graphic-era-university-dehradun-logo.png"),
                        radius: 72,
                      ),
                
                      kH8,
                
                      RichText(
                        text: TextSpan(
                          style: kGraphicLogo, // base style
                          children: [
                            TextSpan(
                              text: 'Graphic',
                              style: kGraphicLogo.copyWith(color: Colors.red),
                            ),
                            const TextSpan(
                              text: ' Era',
                            ),
                          ],
                        ),
                      ),
                
                      Text(
                        "Deemed to be University",
                        style: kTagsStyle.copyWith(fontSize: 15.6,height: 1),
                      ),
                
                    ],
                  ),
                ),

                kH16,

                const Divider(
                    indent: 16,
                    endIndent: 16,
                    thickness: 2, 
                    color: primaryColor
                  ),

                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(24, 0, 16, 0),
                  leading: Icon(
                    FontAwesomeIcons.link,
                    color: primaryColor,
                    size: 20,
                  ),
                  title: Text(
                    'Student Portal',
                    style: kInfoStyle.copyWith(
                      color: primaryColor,
                      letterSpacing: 0
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await launchUrl(
                      Uri.parse('https://student.geu.ac.in'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),

                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(24, 0, 16, 0),
                  leading: Icon(
                    Icons.settings_outlined,
                    color: primaryColor,
                    size: 24,
                  ),
                  title: Text(
                    'Settings',
                    style: kInfoStyle.copyWith(
                      color: primaryColor,
                      letterSpacing: 0
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context); 
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Placeholder(),
                      ),
                    );
                  },
                ),
                
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(24, 0, 16, 0),
                  leading: Icon(
                    Icons.info_outline_rounded,
                    color: primaryColor,
                    size: 24,
                  ),
                  title: Text(
                    'About us',
                    style: kInfoStyle.copyWith(
                      color: primaryColor,
                      letterSpacing: 0                      
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context); 
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Placeholder(),
                      ),
                    );
                  },
                ),

              ],
            ),

          ),
        ),
      ),
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


/*  ----------------------------------------- Update section ------------------------------------------ */ 
class UpdatesSection extends StatelessWidget {
// needed
  final double attendancePercentage;

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
        _UpdatesCard(attendancePercentage: 67.46),
      ],
    );
  }
}

/*  -------------------------------------- Update section title --------------------------------------- */ 
// this section is totally dummy : current attendance : exam update

// Info section title : UPDATES
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

/*  ------------------------------------- Update section Content -------------------------------------- */ 
class _UpdatesCard extends StatelessWidget {
// needed (dummy)
  final double attendancePercentage;

  const _UpdatesCard({
    required this.attendancePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLowAttendance = attendancePercentage < 75;

/* --------------------------------------------- Content ---------------------------------------------- */ 
    return Container(
// Content properties
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [

/* --------------------------------------- Attendance Section ----------------------------------------- */ 
          _AttendanceRow(
            attendancePercentage: 67.46,
            isLowAttendance: isLowAttendance,
          ),

          kH16,

/* ------------------------------------------- Exam Section ------------------------------------------- */ 
          _AdmitCardRow(),

        ],
      ),
    );
  }
}



/* --------------------------------------- Attendance Section ----------------------------------------- */ 
// dummy (needed to be connected to attendance page)
class _AttendanceRow extends StatelessWidget {
// needed
  final double attendancePercentage;
  final bool isLowAttendance;

  const _AttendanceRow({
    required this.attendancePercentage,
    required this.isLowAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

// Content Properties
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

// info heading : Current Attendance  
          Text(
            "Current Attendance :",
            style: kSubHeadingStyle,
          ),

// info content : attendance (dummy)
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


/* ------------------------------------------ Exam Section -------------------------------------------- */ 
// dummy (needed to be connected to exam page)
/* it needs to know the exam status and show what section ot be present */

// cases : before exam : during exam : after exam 

/* ------------------------------------------ Before Exam --------------------------------------------- */
/* 
says clearly that exam dates are not confirmed yet : gives navigation to show the academic calender
 */


/* ------------------------------------------ During Exam --------------------------------------------- */
class _AdmitCardRow extends StatelessWidget {
  const _AdmitCardRow();

  @override
  Widget build(BuildContext context) {
    return Container(

// decorations
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

// info heading : Exam Info
          Text(
            "Admit Card\nReleased",
            style: kSubHeadingStyle,
          ),

// info content : directing button
          ElevatedButton(

// button logic
            onPressed: () {}, 
            
// button properties
            style: ElevatedButton.styleFrom(
              elevation: 2,
              backgroundColor: primaryColor,
              padding: const EdgeInsets.fromLTRB(24,14,24,14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

// button content
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


/* ------------------------------------------- After Exam --------------------------------------------- */

// cases  : result waiting : results out

/* ------------------------------------------ Result Waiting ------------------------------------------ */
/* 
says that results are not out yet (nothing else)
 */


/* ------------------------------------------- Result Out --------------------------------------------- */
/* 
says results are out : gives a navigation button to view the result
 */