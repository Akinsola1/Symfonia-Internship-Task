import 'package:symfonia_crypto/api/api.dart';
import 'package:symfonia_crypto/model/crypto_price.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CryptoCubit extends Cubit<List<Crypto>> {
  final _cryptoList = CryptoList();

  CryptoCubit() : super([]);

  void getCrypto() async => emit(await _cryptoList.fetchCrypto());
}