import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_constants.dart';

class DesktopNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuTap;

  const DesktopNavBar({
    super.key,
    required this.selectedIndex,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: AppDimensions.navBarHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.name,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Row(
                children: List.generate(AppStrings.menuItems.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextButton(
                      onPressed: () => onMenuTap(index),
                      style: TextButton.styleFrom(
                        foregroundColor: selectedIndex == index
                            ? AppColors.primary
                            : AppColors.black87,
                      ),
                      child: Text(
                        AppStrings.menuItems[index],
                        style: GoogleFonts.poppins(
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
