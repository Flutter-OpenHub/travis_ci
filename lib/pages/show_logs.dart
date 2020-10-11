/*
 * show_logs.dart
 *
 * Created by Amit Khairnar on 11/10/2020.
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../store/logs_store/logs_store.dart';

class ShowLogs extends StatefulWidget {
  final int jobId;

  const ShowLogs({Key key, this.jobId}) : super(key: key);
  @override
  _ShowLogsState createState() => _ShowLogsState();
}

class _ShowLogsState extends State<ShowLogs> {
  final LogsStore _logsStore = LogsStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log"),
      ),
      body: Observer(
        builder: (_) => _logsStore.getBuildLogFuture != null
            ? _logsStore.getBuildLogFuture.status == FutureStatus.fulfilled
                ? Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                        child: _buildLog(
                            _logsStore.buildLog['content'].toString())),
                  )
                : _logsStore.getBuildLogFuture.status == FutureStatus.rejected
                    ? Text(_logsStore.errorMessage)
                    : Center(
                        child: CircularProgressIndicator(),
                      )
            : Container(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _logsStore.getBuildLog(widget.jobId.toString(), CancelToken());
  }

  Widget _buildLog(String log) {
    List<String> _data = log.split("\n");
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) =>
            (_data[index].contains("travis_fold:start:") &&
                        _data[index].contains("[0K[33;1m")) ||
                    (_data[index].startsWith("[33;1m") &&
                        _data[index].contains("[0m"))
                ? Text(
                    (_data[index].contains("travis_fold:start:") &&
                            _data[index].contains("[0K[33;1m"))
                        ? _data[index]
                            .split("[0K[33;1m")
                            .last
                            .split("[0m")
                            .first
                            .trim()
                        : _data[index]
                            .split("[33;1m")
                            .last
                            .split("[0m")
                            .first
                            .trim(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cousine',
                        fontSize: 10.0,
                        color: Color.fromRGBO(255, 255, 145, 1.0)),
                  )
                : _data[index].startsWith("[32m+ [39m")
                    ? RichText(
                        text: TextSpan(
                            text: '+  ',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: "Cousine",
                                fontSize: 10.0),
                            children: [
                              TextSpan(
                                  text: _data[index]
                                      .split("[32m+ [39m")
                                      .last
                                      .split("[36m")
                                      .first
                                      .split("[1m")
                                      .last
                                      .replaceAll("[0m", "")
                                      .trimLeft(),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Cousine",
                                  )),
                              if (_data[index]
                                      .split("[32m+ [39m")
                                      .last
                                      .contains("[36m") &&
                                  _data[index]
                                      .split("[32m+ [39m")
                                      .last
                                      .contains("[39m"))
                                TextSpan(
                                    text: _data[index]
                                        .split("[32m+ [39m")
                                        .last
                                        .split("[36m")
                                        .last
                                        .replaceAll("[39m", "")
                                        .trimLeft(),
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: "Cousine",
                                        color: Colors.lightBlueAccent))
                            ]),
                      )
                    : Text(
                        _data[index].contains("[34m[1m")
                            ? _data[index]
                                .split("[34m[1m")
                                .last
                                .split("[0m")
                                .first
                                .trimLeft()
                            : _data[index],
                        style: TextStyle(
                          color: _data[index].contains("[34m[1m")
                              ? Colors.lightBlueAccent
                              : Colors.white,
                          fontSize: 10.0,
                          fontWeight: _data[index].contains("[34m[1m")
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontFamily: 'Cousine',
                          //fontWeight: FontWeight.w500,
                        ),
                      ));
  }
}
