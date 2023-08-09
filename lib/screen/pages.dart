import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:movie_for_test/cubit/movie_cubit.dart';
import 'package:movie_for_test/shared/extension.dart';
import 'package:movie_for_test/shared/string.dart';
import 'package:movie_for_test/shared/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

part 'splash_page.dart';
part 'home_page.dart';
part 'movie_list_page.dart';
part 'movie_detail_page.dart';
part 'add_movie_page.dart';
part 'error_page.dart';
part 'success_page.dart';
part 'showcase_view.dart';
