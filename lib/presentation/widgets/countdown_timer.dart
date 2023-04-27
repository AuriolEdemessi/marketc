import 'dart:async';

import 'package:flutter/material.dart';

import '../../export.dart';
import '../../infrastructure/utils/formatter.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer(
      {Key? key,
      required this.trxcancel,
      required this.resteTimeout,
      required this.trxId,
      })
      : super(key: key);
  final String trxcancel;
  final int resteTimeout;
  final String trxId;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int dure = 0;

  late int value;

  @override
  void initState() {
    super.initState();
    dure = widget.resteTimeout;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (dure > 0) {
        setState(() => dure--);
      } else {
        context.read<HomeCubit>().deleteTransaction(widget.trxId);
        context.read<HomeCubit>().fetchTransaction();
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      StrFormater.durationInSeconde(dure),
      style: kSubtitle2.copyWith(
          fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.error),
    );
  }
}
