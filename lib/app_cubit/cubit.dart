import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  // ThemeMode appMode = ThemeMode.dark;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
