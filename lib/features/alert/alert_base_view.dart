import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/general/on_tap_opacity_container.dart';
import '../../generated/locale_keys.g.dart';

class AlertBaseView extends StatefulWidget {
  final List<String> backgroundText;
  final String cardTitle;
  final String cardBody;
  final Widget headerContent;
  final Color backgroundTextColor;
  final Color btnColor;
  final String btnHeader;
  final Color backgroundColor;
  final void Function()? onBtnTap;

  const AlertBaseView({
    required this.backgroundText,
    required this.cardTitle,
    required this.cardBody,
    required this.headerContent,
    required this.btnHeader,
    this.onBtnTap,
    this.backgroundTextColor = const Color(0xFF6C7DF7),
    this.backgroundColor = const Color(0xFF1A1910),
    this.btnColor = const Color(0xFF6C7DF7),
    Key? key,
  })  : assert(backgroundText.length == 7, LocaleKeys.alertBaseView),
        super(key: key);

  @override
  State<AlertBaseView> createState() => _AlertBaseViewState();
}

class _AlertBaseViewState extends State<AlertBaseView>
    with SingleTickerProviderStateMixin {
  double _rightOffsetEvenRow = -800.0;
  double _leftOffsetEvenRow = 800.0;
  double _rightOffsetOddRow = 800.0;
  double _leftOffsetOddRow = -800.0;
  double _width = 0;
  double _height = 0;
  bool _isExpanded = false;

  late AnimationController _onStartScreen;

  @override
  void initState() {
    super.initState();
    _onStartScreen = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    )
      ..forward()
      ..addListener(
        () {
          setState(() {
            _rightOffsetEvenRow = -50;
            _leftOffsetEvenRow = -50;
            _rightOffsetOddRow = -50;
            _leftOffsetOddRow = -50;
            _height = MediaQuery.of(context).size.width * .7;
            _width = MediaQuery.of(context).size.width * .9;
            _isExpanded = true;
          });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Transform.rotate(
            angle: 0,
            // -pi / 45,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  for (int index = 0;
                      index < widget.backgroundText.length;
                      index++)
                    AnimatedPositioned(
                      child: Transform.rotate(
                        angle: -pi / 45,
                        child: Text(
                          widget.backgroundText[index] * 3,
                          maxLines: 1,
                          textAlign:
                              index.isEven ? TextAlign.start : TextAlign.end,
                          style: GoogleFonts.mulish(
                            color: widget.backgroundTextColor.withOpacity(
                              [2, 3].contains(index) ? 1.0 : 0.3,
                            ),
                            fontSize: 140,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      duration: const Duration(seconds: 1),
                      curve: _isExpanded ? Curves.bounceOut : Curves.easeInCirc,
                      right: index.isEven
                          ? _rightOffsetEvenRow
                          : _rightOffsetOddRow,
                      left:
                          index.isEven ? _leftOffsetEvenRow : _leftOffsetOddRow,
                      top: -75 + (index * 120.0),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .94,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  AnimatedContainer(
                    width: _width,
                    height: _height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                    curve: _isExpanded ? Curves.elasticOut : Curves.elasticIn,
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .6,
                        child: ListView(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .03,
                          ),
                          children: [
                            Text(
                              widget.cardTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.cardBody,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            OnTapOpacityContainer(
                              onTap: () async {
                                setState(() {
                                  _rightOffsetEvenRow =
                                      -MediaQuery.of(context).size.width;
                                  _leftOffsetEvenRow =
                                      MediaQuery.of(context).size.width;
                                  _rightOffsetOddRow =
                                      MediaQuery.of(context).size.width;
                                  _leftOffsetOddRow =
                                      -MediaQuery.of(context).size.width;
                                  _height = 0;
                                  _width = 0;
                                  _isExpanded = false;
                                });
                                await Future<void>.delayed(
                                  const Duration(seconds: 1),
                                );
                                widget.onBtnTap?.call();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                decoration: BoxDecoration(
                                  color: widget.btnColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.btnHeader,
                                    style: GoogleFonts.mulish(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: AnimatedContainer(
                      width: _width * .3,
                      height: _height * .3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                              0,
                              3,
                            ), // changes position of shadow
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 1),
                      curve: _isExpanded ? Curves.elasticOut : Curves.elasticIn,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: widget.headerContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
