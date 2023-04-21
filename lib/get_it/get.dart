import 'package:dalog_distribution/models/language_model.dart';
import 'package:dalog_distribution/view/pages/authantication/sign_up/Bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class GetInjectorInitializeAtOnce {
  GetInjectorInitializeAtOnce._();

  static void init() {
    GetIt.I.registerFactory(() => LanguageSelection());
    GetIt.I.registerFactory(() => VisibleBloc());
  }
}
