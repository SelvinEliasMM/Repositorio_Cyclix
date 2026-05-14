import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/cyclix_colors.dart';

class CyclixHeader extends StatelessWidget implements PreferredSizeWidget {
  const CyclixHeader({super.key, this.showBack = false});

  final bool showBack;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52,
          child: Row(
            children: [
              if (showBack)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: CyclixColors.primaryBlue),
                  onPressed: () => Navigator.of(context).maybePop(),
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: CyclixColors.primaryBlue),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              Expanded(
                child: Text(
                  'Cyclix',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: CyclixColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.pedal_bike,
                  color: CyclixColors.accentGreen,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
