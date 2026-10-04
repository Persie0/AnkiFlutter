import 'package:anki_flutter/features/card_info/models/card_info_data.dart';

abstract interface class CardInfoRepository {
  Future<CardInfoData> load(int cardId);
}
