import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'default_text.dart';

class DefaultScreen extends StatefulWidget{
  final Color? backgroundColor;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? counter;
  final String title;
  final  GlobalKey<ScaffoldState>? scaffoldKey;

  const DefaultScreen({super.key,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.counter,
    required this.body,
    required this.title,
    this.scaffoldKey
  });

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/image11.png",fit: BoxFit.fill,width: double.infinity, height: double.infinity,),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: -50.0),
            child: Container(
              color: Colors.black.withOpacity(.73),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          key: widget.scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: DefaultText(
              text: widget.title,
              themeStyle: Theme.of(context).textTheme.labelLarge,
            ),
            actions: [
              widget.counter ?? Container(),
            ],
          ),
          drawer: const Drawer(),
          bottomNavigationBar: widget.bottomNavigationBar,
          floatingActionButton: widget.floatingActionButton,
          body: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
            child: widget.body,
          ),
        ),
      ],
    );
  }
}