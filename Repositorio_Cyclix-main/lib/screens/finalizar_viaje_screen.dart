import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import '../theme/cyclix_colors.dart';
import 'pago_screen.dart';

class FinalizarViajeScreen extends StatefulWidget {
  const FinalizarViajeScreen({super.key});

  @override
  State<FinalizarViajeScreen> createState() => _FinalizarViajeScreenState();
}

class _FinalizarViajeScreenState extends State<FinalizarViajeScreen> {
  bool _bloqueada = false;
  bool _fotoTomada = false;
  CameraController? _cameraController;
  bool _isCameraReady = false;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() {
      _isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _finalizarYTomarFoto() async {
    if (!_bloqueada) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, bloquea la bicicleta primero")),
      );
      return;
    }

    // Señal de cierre
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "PROCESANDO SEÑAL DE CIERRE...",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 1),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    // Abrir cámara
    await _initializeCamera();
    
    if (_isCameraReady) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Toma foto de la ubicación")),
          body: Column(
            children: [
              Expanded(child: CameraPreview(_cameraController!)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final image = await _cameraController!.takePicture();
                      Navigator.pop(context); // Cierra cámara
                      setState(() => _fotoTomada = true);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Foto guardada con éxito")),
                      );
                      
                      // Ir a pago
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const PagoScreen()),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text("CAPTURAR Y FINALIZAR"),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

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
        actions: const [
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              '¿Estacionaste la bicicleta\ncorrectamente?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CyclixColors.textDark,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            CheckboxListTile(
              value: _bloqueada,
              onChanged: (val) => setState(() => _bloqueada = val ?? false),
              title: Text(
                'Bloquear la bicicleta',
                style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(),
            ListTile(
              leading: Icon(_fotoTomada ? Icons.check_box : Icons.camera_alt, 
                color: _fotoTomada ? Colors.green : Colors.blue),
              title: Text(
                'Tomar foto del cierre',
                style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            const Spacer(),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: _finalizarYTomarFoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CyclixColors.accentGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Finalizar Viaje',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
