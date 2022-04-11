import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';

class AnimationDemoScreen extends EPage {
  const AnimationDemoScreen({required Map<String, dynamic> args})
      : super(args: args);

  @override
  Widget build(BuildContext context) {
    return const AnimationDemoView();
  }
}

class AnimationDemoView extends StatelessWidget {
  const AnimationDemoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(),
          ),
          const ExhibitionBottomSheet(),
        ],
      ),
    );
  }
}

const double minHeight = 120;

const double iconStartSize = 44; //<-- add edge values
const double iconEndSize = 120; //<-- add edge values
const double iconStartMarginTop = 36; //<-- add edge values
const double iconEndMarginTop = 80; //<-- add edge values
const double iconsVerticalSpacing = 24; //<-- add edge values
const double iconsHorizontalSpacing = 16;

class ExhibitionBottomSheet extends StatefulWidget {
  const ExhibitionBottomSheet({Key? key}) : super(key: key);

  @override
  State<ExhibitionBottomSheet> createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height;

  double? get headerTopMargin => lerp(
        20,
        20 + MediaQuery.of(context).padding.top,
      );

  double? get headerFontSize => lerp(14, 24);

  double iconTopMargin(int index) =>
      lerp(
        iconStartMarginTop,
        iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize),
      )! +
      headerTopMargin!;

  double? iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  void _toggle() {
    final isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final flingVelocity = details.velocity.pixelsPerSecond.dy /
        maxHeight; //<-- calculate the velocity of the gesture
    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _controller.fling(velocity: math.min(-2, -flingVelocity));
    } else {
      _controller.fling(
        velocity: _controller.value < 0.5 ? -2 : 2,
      );
    } //<-- or just continue to whichever edge is closer
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: _toggle,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: const BoxDecoration(
                color: Color(0xFF162A49),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Stack(
                children: <Widget>[
                  const MenuButton(),
                  SheetHeader(
                    //<-- Add a header with params
                    fontSize: headerFontSize!,
                    topMargin: headerTopMargin!,
                  ),
                  for (Event event in events) _buildIcon(event),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(Event event) {
    final index = events.indexOf(event); //<-- Get index of the event
    return Positioned(
      height: 40, //<-- Specify icon's size
      width: 40, //<-- Specify icon's size
      top: iconTopMargin(index), //<-- Specify icon's top margin
      left: iconLeftMargin(index), //<-- Specify icon's left margin
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(10), //<-- Set the rounded corners
          right: Radius.circular(10),
        ),
        child: Image.asset(
          '/${event.assetName}',
          fit: BoxFit.cover,
          // alignment: Alignment(
          //   lerp(1, 0)!,
          //   0,
          // ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 0,
      bottom: 24,
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({Key? key, required this.fontSize, required this.topMargin})
      : super(key: key);
  final double fontSize;
  final double topMargin;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text(
        'Booked Exhibition',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

final List<Event> events = [
  Event('steve-johnson.jpeg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('efe-kurnaz.jpeg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('rodion-kutsaev.jpeg', 'Dawan District Guangdong Hong Kong', '4.28-31'),
];

class Event {
  Event(this.assetName, this.title, this.date);

  final String assetName;
  final String title;
  final String date;
}
