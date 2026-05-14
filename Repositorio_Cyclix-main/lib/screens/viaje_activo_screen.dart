import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/cyclix_colors.dart';
import 'finalizar_viaje_screen.dart';

class ViajeActivoScreen extends StatelessWidget {
  const ViajeActivoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyclixColors.backgroundWhite,
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: CyclixColors.accentGreen),
        title: Text(
          'Cyclix',
          style: GoogleFonts.poppins(
            color: CyclixColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.pedal_bike, color: CyclixColors.textDark),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildDataRow('Tiempo:', '12:35'),
            const SizedBox(height: 20),
            _buildDataRow('Distancia:', '3.2 km'),
            const SizedBox(height: 20),
            _buildDataRow('Velocidad:', '14 km/h'),
            const Spacer(),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FinalizarViajeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CyclixColors.accentGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Finalizar',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Acción de emergencia
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CyclixColors.accentGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Emergencia',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CyclixColors.textDark,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
