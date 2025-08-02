import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/presentation/blocs/media/media_event.dart';
import 'core/constants/strings.dart';
import 'core/theme/app_theme.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/media/media_bloc.dart';
import 'presentation/blocs/upload/upload_bloc.dart';
import 'presentation/pages/auth/login_page.dart';
import '/core/dependyinjection/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider<MediaBloc>(
          create: (_) => di.sl<MediaBloc>()..add(MediaLoadRequested()),
        ),
        BlocProvider<UploadBloc>(
          create: (_) => di.sl<UploadBloc>(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: AppTheme.lightTheme,
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}