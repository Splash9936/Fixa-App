import 'package:fixa/fixa_main_routes.dart';

class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkLoading extends NetworkState {}

class NetworkWifiConnected extends NetworkState {}

class NetworkMobileConnected extends NetworkState {}

class NetworkNotConnected extends NetworkState {}
