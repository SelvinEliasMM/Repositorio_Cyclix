import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/cyclix_colors.dart';

class CyclixBottomNav extends StatelessWidget {
  const CyclixBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CyclixColors.backgroundWhite,
        border: const Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: NavigationBar(
        backgroundColor: CyclixColors.backgroundWhite,
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        indicatorColor: CyclixColors.primaryBlue.withOpacity(0.1),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        elevation: 0,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined, color: CyclixColors.primaryBlue),
            selectedIcon: const Icon(Icons.home, color: CyclixColors.primaryBlue),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: const Icon(Icons.search, color: CyclixColors.primaryBlue),
            selectedIcon: const Icon(Icons.search, color: CyclixColors.primaryBlue),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline, color: CyclixColors.primaryBlue),
            selectedIcon: const Icon(Icons.person, color: CyclixColors.primaryBlue),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
