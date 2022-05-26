// 🎯 Dart imports:
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

// 🌎 Project imports:

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final filterTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding:
                  const EdgeInsets.only(bottom: 24, top: 16, right: 16, left: 16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: filterTEC,
                  ),
                  TextButton(onPressed: () {}, child: const Text('Confirm'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
