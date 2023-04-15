import 'package:flutter/material.dart';
import 'package:news_app/app/core/env/env.dart';

class Tentang extends StatefulWidget {
  @override
  State<Tentang> createState() => _TentangState();
}

class _TentangState extends State<Tentang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Tentang',
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: const Color(0xff4f9b9b),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        scale: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'KAMUS ISTILAH',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'KESEHATAN HEWAN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'DAN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'PETERNAKAN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          'selamat datang di kamus istilah kesehatan hewan dan peternakan berbasis mobile. aplikasi ini merupakan aplikasi untuk mencari istilah kesehatan hewan dan peternakan serta dapat memberikan saran kata yang mendekati kata-kata yang salah eja di kamus istilah kesehatan hewan dan peternakan, lalu menampilkan makna dan istilah kata tersebut.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
