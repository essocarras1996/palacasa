import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palacasa/Helper/color_constant.dart';

import 'custom_calendar.dart';


class CalendarBirthday extends StatefulWidget {
  const CalendarBirthday(
      {Key? key,
        this.initialStartDate,
        this.initialEndDate,
        this.onApplyClick,
        this.onCancelClick,
        this.barrierDismissible = true,
        this.minimumDate,
        this.maximumDate,
        this.controller})
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final TextEditingController? controller;
  final Function(DateTime)? onApplyClick;

  final Function()? onCancelClick;
  @override
  _CalendarSimplePopupViewState createState() => _CalendarSimplePopupViewState(controller);
}

class _CalendarSimplePopupViewState extends State<CalendarBirthday>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DateTime? startDate;

  late final TextEditingController? controller;


  _CalendarSimplePopupViewState(this.controller);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: animationController!.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible) {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CustomCalendarSimpleView(
                              minimumDate: widget.minimumDate,
                              initialStartDate: widget.initialStartDate,
                              startEndDateChange: (DateTime startDateData) {
                                setState(() {
                                  startDate = startDateData;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 8),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: PaLaCasaAppTheme.Orange,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      if(startDate != null){
                                        controller?.text='${DateFormat('dd MMMM').format(startDate!).replaceAll('January', 'Enero').replaceAll('February', 'Febrero').replaceAll('March', 'Marzo').replaceAll('April', 'Abril').replaceAll('May', 'Mayo').replaceAll('June', 'Junio').replaceAll('July', 'Julio').replaceAll('August', 'Agosto').replaceAll('September', 'Septiembre').replaceAll('October', 'Octubre').replaceAll('November', 'Noviembre').replaceAll('December', 'Diciembre')}' ;
                                        controller?.text='${DateFormat('dd/MM/yyyy').format(startDate!)}';
                                      }
                                      setState(() {

                                      });

                                      try {
                                        /*animationController?.reverse().then((f) {
                                         });*/
                                        widget.onApplyClick!(startDate!);
                                        Navigator.pop(context);
                                      } catch (_) {

                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        'Seleccionar',
                                        style: TextStyle(
                                            fontFamily: PaLaCasaAppTheme.fontName,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}