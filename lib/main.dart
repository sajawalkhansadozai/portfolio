import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_constants.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const PortfolioHomePage(),
    );
  }
}
