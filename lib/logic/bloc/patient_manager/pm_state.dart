import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class PMState extends Equatable {
  const PMState();

  @override
  List<Object?> get props => [];
}

class NotConnectedServer extends PMState {
  const NotConnectedServer();
}

class ConnectedServer extends PMState {
  const ConnectedServer(this.socket);
  final Socket socket;
}