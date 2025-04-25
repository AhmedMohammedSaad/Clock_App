import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';
import 'package:segment_display/segment_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SingingCharacter { analogClock, digitalClock, textCock }

class _HomeScreenState extends State<HomeScreen> {
  SingingCharacter? _character = SingingCharacter.analogClock;
  double _currentSliderValue = 100;
  int indexColor = 0;
  double opacityDrawer = 1;

  void changeOpacity() {
    setState(() {
      opacityDrawer = 0;
    });
    Timer(Duration(seconds: 1), () {
      setState(() {
        opacityDrawer = 1;
      });
    });
  }

  Widget digitalClock() {
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
    String houres = DateTime.now().hour.toString();
    String minutes = DateTime.now().minute.toString();
    String seconds = DateTime.now().second.toString();

    return SevenSegmentDisplay(
      characterSpacing: 10.0,
      backgroundColor: Colors.transparent,
      segmentStyle: HexSegmentStyle(
        enabledColor: colors[indexColor],
        disabledColor: colors[indexColor],
      ),
      value: '$houres:$minutes:$seconds',
    );
  }

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clock'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white.withOpacity(opacityDrawer),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.blue.withOpacity(opacityDrawer),
              height: 200,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time_filled_outlined,
                    size: 35,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Settings".tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time_rounded, size: 35),
                      SizedBox(width: 10),
                      Text(
                        "Clock Type".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: const Text('AnalogClock'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.analogClock,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                          changeOpacity();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('TextClock'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.textCock,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                          changeOpacity();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('DigitalClock'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.digitalClock,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                          changeOpacity();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.title, size: 35),
                      SizedBox(width: 10),
                      Text(
                        "Clock Size".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _currentSliderValue,
                    max: 100,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        changeOpacity();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.color_lens_outlined),

                      Text(
                        "Clock Color".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: colors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              indexColor = index;
                              changeOpacity();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  indexColor == index
                                      ? Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                      : null,
                              color: colors[index],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),

                            height: 50,
                            width: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child:
                  _character == SingingCharacter.analogClock
                      ? AnalogClock(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: colors[indexColor],
                          ),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        width: _currentSliderValue * 4,
                        isLive: true,
                        secondHandColor: colors[indexColor],
                        digitalClockColor: colors[indexColor],
                        tickColor: colors[indexColor],
                        hourHandColor: Colors.black,
                        minuteHandColor: colors[indexColor],
                        showSecondHand: true,
                        numberColor: colors[indexColor],
                        showNumbers: true,
                        showAllNumbers: true,
                        textScaleFactor: 1.4,
                        showTicks: true,
                        showDigitalClock: true,
                        datetime: DateTime(2019, 1, 1, 9, 12, 15),
                      )
                      : _character == SingingCharacter.textCock
                      ? DigitalClock(
                        digitalClockTextColor: colors[indexColor],
                        showSeconds: true,
                        textScaleFactor: _currentSliderValue / 10,

                        isLive: true,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        datetime: DateTime.now(),
                      )
                      : digitalClock(),
            ),
          ),
        ],
      ),
    );
  }
}
