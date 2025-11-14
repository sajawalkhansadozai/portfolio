import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_constants.dart';

class MobileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuTap;

  const MobileDrawer({
    super.key,
    required this.selectedIndex,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.name,
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(AppStrings.menuItems.length, (index) {
              return ListTile(
                leading: Icon(_getMenuIcon(index), color: AppColors.white),
                title: Text(
                  AppStrings.menuItems[index],
                  style: GoogleFonts.poppins(color: AppColors.white),
                ),
                selected: selectedIndex == index,
                selectedTileColor: AppColors.white.withOpacity(0.1),
                onTap: () {
                  Navigator.pop(context);
                  onMenuTap(index);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  IconData _getMenuIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.person;
      case 2:
        return Icons.school;
      case 3:
        return Icons.code;
      case 4:
        return Icons.work;
      case 5:
        return Icons.auto_stories;
      case 6:
        return Icons.contact_mail;
      default:
        return Icons.circle;
    }
  }
}
