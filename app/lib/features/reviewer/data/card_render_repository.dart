import 'package:anki_flutter/features/reviewer/models/review_card_content.dart';

abstract interface class CardRenderRepository {
  Future<ReviewCardContent> render(int cardId);
}
