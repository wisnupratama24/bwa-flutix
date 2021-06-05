import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (_) => AuthServices(),
        ),
        StreamProvider(
          initialData: null,
          create: (context) => context.read<AuthServices>().authStateChange,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: AuthWrapper(),
          ),
        ),
      ),
    );
  }
}
