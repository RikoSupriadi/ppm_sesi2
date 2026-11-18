import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPM Sesi 2 - Riko Supriadi (20240040083)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            ProfileCard(
              nama: 'Riko Supriadi',
              nim: '20240040083',
              prodi: 'Teknik Informatika / 2024',
            ),
            SizedBox(height: 16),
            PromoBanner(),
            SizedBox(height: 16),
            ProductCard(
              nama: 'Kopi Susu Gula Aren',
              kategori: 'Minuman',
              harga: 5000,
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== StatelessWidget: Kartu Profil =====================
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nama,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('NIM: $nim'),
                  Text('Prodi/Kelas: $prodi'),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(Icons.star,
                          color: Colors.amber, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== Banner Promo (Stack + Positioned) =====================
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.teal, Colors.greenAccent],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 16,
            top: 16,
            child: Text(
              'PROMO SPESIAL!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            left: 16,
            bottom: 16,
            child: Text(
              'Diskon hingga 50% hari ini',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('-50%',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const Positioned(
            right: 16,
            bottom: 12,
            child: Icon(Icons.local_offer, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}

// ===================== StatefulWidget: Kartu Produk =====================
class ProductCard extends StatefulWidget {
  final String nama;
  final String kategori;
  final int harga;

  const ProductCard({
    super.key,
    required this.nama,
    required this.kategori,
    required this.harga,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;
  int _likes = 0;
  int _jumlah = 1;

  int get _total => widget.harga * _jumlah;

  String _rupiah(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp $buf';
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _likes += _isFavorite ? 1 : -1;
    });
  }

  void _kurang() {
    if (_jumlah > 1) setState(() => _jumlah--);
  }

  void _tambah() => setState(() => _jumlah++);

  void _tambahKeranjang() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_jumlah x ${widget.nama} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.local_cafe, size: 72, color: Colors.teal),
            ),
            const SizedBox(height: 12),
            Text(widget.nama,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Kategori: ${widget.kategori}'),
            Text('Harga: ${_rupiah(widget.harga)}'),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
                Text('$_likes Like'),
                const Spacer(),
                IconButton(
                  onPressed: _kurang,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_jumlah',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: _tambah,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:'),
                Text(_rupiah(_total),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambahKeranjang,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Tambah ke Keranjang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
