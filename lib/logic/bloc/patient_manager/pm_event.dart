import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flowop/global/constant/error.dart';
import 'package:flowop/utils/string_extension.dart';

abstract class PMEvent extends Equatable {
  const PMEvent();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class ConnectServer extends PMEvent {
  const ConnectServer({required this.socket});
  final Socket socket;

  @override
  List<Object> get props => [socket];
}

// class ReceivePrediction