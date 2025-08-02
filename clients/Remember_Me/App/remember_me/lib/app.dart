import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/presentation/blocs/media/media_event.dart';
import 'package:remember_me/presentation/pages/main/main_page.dart';
import 'core/constants/strings.dart';
import 'core/theme/app_theme.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/auth/auth_event.dart';
import 'presentation/blocs/auth/auth_state.dart';
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
          create: (_) => di.sl<AuthBloc>()..add(AuthCheckRequested()),
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
        home: _buildHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget _buildHome() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return _buildSplashScreen();
        } else if (state is AuthAuthenticated) {
          return MainPage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  Widget _buildSplashScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade600,
              Colors.deepPurple.shade800,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.cloud_circle,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              Text(
                AppStrings.appTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}