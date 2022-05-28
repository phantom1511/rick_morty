// 🎯 Dart imports:
import 'dart:ui';

import 'package:flutter/material.dart';

// 🌎 Project imports:

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
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
              padding: const EdgeInsets.only(
                  bottom: 24, top: 16, right: 16, left: 16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Gender',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  ...['male', 'female', 'unknown', 'genderless']
                      .map((e) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(e);
                            },
                            child: Chip(label: Text(e)),
                          ))
                      .toList(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
