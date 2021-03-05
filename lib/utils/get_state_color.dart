/*
 * get_state_color.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:flutter/material.dart';
import 'package:travis_ci/enum/build_status.dart';

class GetStateColor {
  static getStateColor(BuildState? state) {
    switch (state) {
      case BuildState.started:
        return Colors.orange;
      case BuildState.passed:
        return Colors.green;
      case BuildState.errored:
        return Colors.red;
      case BuildState.failed:
        return Colors.redAccent;
      case BuildState.canceled:
        return Colors.grey;
      default:
        return Colors.teal;
    }
  }
}
