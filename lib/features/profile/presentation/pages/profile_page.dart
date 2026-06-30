import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _clickCount = 0;
  bool _showLottie = false;
  Timer? _clickTimer;

  // Logika Tantangan AI (Klik 2x sesuai NIM 20123042)
  void _onProfileTapped() {
    if (_showLottie) return; 

    setState(() {
      _clickCount++;
    });

    if (_clickCount == 2) { // angka terakhir NIM 
      setState(() {
        _showLottie = true;
      });

      // Menghilangkan animasi Lottie persis setelah 3 detik
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showLottie = false;
            _clickCount = 0;
          });
        }
      });
    }

    // Reset hitungan klik jika tidak diklik lagi dalam 1 detik
    _clickTimer?.cancel();
    _clickTimer = Timer(const Duration(seconds: 1), () {
      _clickCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal, 
      ),
      // Memakai Stack agar animasi Lottie bisa menimpa/menutupi layar
      body: Stack(
        children: [
          // --- KONTEN HALAMAN PROFIL ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _onProfileTapped,
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.blueAccent,
                    backgroundImage: AssetImage('assets/images/foto.jpg'), // Path ke fotomu
                    // Tampilkan ikon default jika asset tidak ketemu (fallback)
                    foregroundImage: AssetImage('assets/images/foto.jpg'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Desi Ramadani',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'NIM: 20123042',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  '(Tap foto profil 2x)',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          // --- ANIMASI LOTTIE RAHASIA ---
          if (_showLottie)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6), // Layar jadi agak gelap
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/easter_egg.json',
                    fit: BoxFit.contain,
                    width: 300,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}