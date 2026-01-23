import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uniview/graphic_era_theme.dart';
import 'package:url_launcher/url_launcher.dart';


// main class
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
        child: const _HomeScrollView(),
      ),
    );
  }
}

class _HomeScrollView extends StatelessWidget {
  const _HomeScrollView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.zero,
      children: const [
        HomeAppBar(),
        StudentIDStack(),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
          child: TopSearchBar(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------- App Bar ----------------------------------------------------------
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Row(
        children: const [
          _AppBarImage(),
          kW6,
          Expanded(child: _AppBarContent()),
        ],
      ),
    );
  }
}

class _AppBarImage extends StatelessWidget {
  const _AppBarImage();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: graphicWhite,
      child: Image.asset(
        "assets/images/graphic-era-university-dehradun-logo.png",
        fit: BoxFit.contain,
      ),
    );
  }
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            DecoratedBox(
              decoration: BoxDecoration(
                color: graphicWhite,
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
                icon: const Icon(
                  FontAwesomeIcons.link,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        const Divider(height : 2,thickness: 2, color: primaryColor),
      ],
    );
  }
}

// ---------------------------------------------------------- ID Stack ----------------------------------------------------------

// base Box
class _BaseBox extends StatelessWidget {
  const _BaseBox();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
      child: const SizedBox(height: 380),
    );
  }
}

// student avatar
class _StudentAvatar extends StatelessWidget {
  const _StudentAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 80,
      backgroundImage:
          AssetImage("assets/images/profile_pic_4_50w.jpg"),
    );
  }
}

// show ID button
class _ShowIDButton extends StatelessWidget {
  const _ShowIDButton();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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

// Main Info : Name + Course + Year + Semester
class _MainInfo extends StatelessWidget {
  const _MainInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Abhinav Bhatt",
          style: kHeadingStyle.copyWith(fontSize: 24),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "BSc (H.) Computer Science",
          style: kSubHeadingStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
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

// Tile Structure
class InfoTile extends StatelessWidget {
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

// Academic Info 
class AcademicInfo extends StatelessWidget {
  const AcademicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        child: Column(
          children: const [
            InfoTile(label: "Official Email", value: "12345678@geu.ac.in"),
            Divider(),
            InfoTile(label: "Class Roll No.", value: "00"),
            Divider(),
            InfoTile(label: "Enroll No.", value: "GE-12345678"),
            Divider(),
            InfoTile(
              label: "University Roll No.",
              value: "1234567890",
            ),
            Divider(),
            InfoTile(label: "Status", value: "Active"),
          ],
        ),
      ),
    );
  }
}

// ID Stack
class StudentIDStack extends StatelessWidget {
  const StudentIDStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: const SizedBox(
        height: 442,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BaseBox(),
            ),
            Positioned(
              top: 4,
              left: 14,
              child: _StudentAvatar(),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _ShowIDButtonWrapper(),
            ),
            Positioned(
              top: 72,
              left: 186,
              right: 16,
              child: _MainInfo(),
            ),
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

class _ShowIDButtonWrapper extends StatelessWidget {
  const _ShowIDButtonWrapper();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
      ),
      child: const _ShowIDButton(),
    );
  }
}


// ---------------------------------------------------------- Search Bar ----------------------------------------------------------

final OutlineInputBorder _searchEnabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(32),
  borderSide: const BorderSide(
    color: Colors.black26,
    width: 1.5,
  ),
);

final OutlineInputBorder _searchFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(32),
  borderSide: const BorderSide(
    color: primaryColor,
    width: 1.5,
  ),
);

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kInfoHeadingStyle,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: graphicWhite,
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
    
        label: Text('Search', style: kTagsStyle.copyWith(fontSize: 16)),
        hintText: 'Quick Access',
        hintStyle: kTagsStyle.copyWith(fontSize: 16),
        enabledBorder: _searchEnabledBorder,
        focusedBorder: _searchFocusedBorder,
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 2, 10),
          child: Icon(
            Icons.search,
            color: Colors.black54,
            size: 28,
          ),
        ),
      ),
    );
  }
}