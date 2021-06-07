import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/main.dart';
import 'package:bwa_flutix/models/user_model.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:bwa_flutix/ui/pages/auth/signin_page.dart';
import 'package:bwa_flutix/ui/pages/auth/signup_page.dart';
import 'package:bwa_flutix/ui/pages/main_page.dart';
import 'package:bwa_flutix/ui/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "package:bwa_flutix/extensions/string_extension.dart";

part 'splash_page.dart';
part 'auth/auth_wrapper.dart';

part 'home/movie_page.dart';
