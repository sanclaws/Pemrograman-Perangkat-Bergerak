import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'input_mahasiswa_page.dart';
import 'models/mahasiswa.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dhira's Apps",
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Mahasiswa? mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dhira's Apps - Main Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Latihan 1: Ke ProfilePage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text("Go to Profile Page"),
            ),
            const SizedBox(height: 16),

            // Latihan 2: Input Mahasiswa
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputMahasiswaPage(),
                  ),
                );
                if (result != null && result is Mahasiswa) {
                  setState(() {
                    mahasiswa = result;
                  });
                }
              },
              child: const Text("Input Mahasiswa"),
            ),
            const SizedBox(height: 16),

            // Tampilkan hasil input mahasiswa
            if (mahasiswa != null) ...[
              Text("Nama: ${mahasiswa!.nama}"),
              Text("Umur: ${mahasiswa!.umur}"),
              Text("Alamat: ${mahasiswa!.alamat}"),
              Text("Kontak: ${mahasiswa!.kontak}"),
              const SizedBox(height: 16),

              // Latihan 3: Call nomor mahasiswa
              ElevatedButton(
                onPressed: () async {
                  final Uri telUri = Uri(
                    scheme: 'tel',
                    path: mahasiswa!.kontak,
                  );
                  if (await canLaunchUrl(telUri)) {
                    await launchUrl(
                      telUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tidak bisa membuka aplikasi telepon"),
                      ),
                    );
                  }
                },
                child: const Text("Call Mahasiswa"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
