import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLifecycleCubit extends Cubit<AppLifecycleState>
    with WidgetsBindingObserver {
  AppLifecycleCubit() : super(AppLifecycleState.resumed) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState newState) {
    emit(newState);
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
