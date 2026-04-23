import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultScreen extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? counter;
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DefaultScreen({
    super.key,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.counter,
    required this.body,
    required this.title,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/image11.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                color: Colors.black.withValues(alpha: 0.75),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: backgroundColor ?? Colors.transparent,
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              actions: [
                if (counter != null) counter!,
                const SizedBox(width: 8),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
