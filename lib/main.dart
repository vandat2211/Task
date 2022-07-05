import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/blocs/switch_bloc/switch_bloc.dart';
import 'package:todo/blocs/switch_bloc/switch_state.dart';
import 'package:todo/screens/tabs_screen.dart';
import 'package:todo/screens/pending_screen.dart';
import 'package:todo/services/app_router.dart';
import 'package:todo/services/app_theme.dart';
import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchBloc(),
        )
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: state.switchValue?AppThemes.appThemeData[AppTheme.darkTheme]:
          AppThemes.appThemeData[AppTheme.lightTheme],
          home:  TabsScreen(),
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      }),
    );
  }
}
