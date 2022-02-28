import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../api/api.dart';
import '../cubit/cubit.dart';
import '../model/crypto_price.dart';

class MainaPage extends StatelessWidget {
  const MainaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Crypto> _cryptoList = <Crypto>[];
    final service = CryptoList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "Price",
            style: GoogleFonts.roboto(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sort),
                label: const Text("sort"))
          ],
        ),
        body: SizedBox(
          height: size.height,
          child: BlocBuilder<CryptoCubit, List<Crypto>>(
              builder: (context, snapshot) {
            if (snapshot.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.length,
                  itemBuilder: ((context, index) {
                    var crypto = snapshot.elementAt(index);
                    var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(crypto.lastUpdated!);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Image(
                            image: CachedNetworkImageProvider(crypto.image!),
                            height: 30,
                            width: 30,
                          )),
                        ),
                        title: Text(
                          crypto.name!,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            formattedTime,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        trailing: Text(
                          "\$ ${crypto.currentPrice}",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  }));
            }
          }),
        ));
  }
}
