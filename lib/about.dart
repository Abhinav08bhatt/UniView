import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:uniview/graphic_era_theme.dart';
// import 'package:url_launcher/url_launcher.dart';



class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },

/*  ----------------------------------------- MAIN CLASS ----------------------------------------- */
        child: const _AboutPage(),
      ),
    );
  }
}

class _AboutPage extends StatelessWidget {
  const _AboutPage();

  @override
  Widget build(BuildContext context) {
    return ListView(

/*  --------------------------------------- PAGE PROPERTIES --------------------------------------- */
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.zero,

      children: const [
      ]
    );
    
  }
}