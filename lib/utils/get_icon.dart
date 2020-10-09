/*
 * get_icon.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:flutter/material.dart';
import 'package:travis_ci/enum/build_status.dart';

class GetIcon {
  static getIcon(BuildState state, {double size}) {
    switch (state) {
      case BuildState.started:
        return Container();
      case BuildState.passed:
        return Icon(
          Icons.check,
          color: Colors.green,
          size: size,
        );
      case BuildState.errored:
        return Icon(
          Icons.priority_high,
          color: Colors.red,
          size: size,
        );
      case BuildState.failed:
        return Icon(
          Icons.close,
          color: Colors.redAccent,
          size: size,
        );
      case BuildState.canceled:
        return Icon(
          Icons.not_interested,
          color: Colors.grey,
          size: size,
        );
    }
  }
}
