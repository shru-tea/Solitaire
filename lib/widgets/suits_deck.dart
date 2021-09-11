import 'package:flutter/material.dart';
import 'package:playing_cards/models/card_model.dart';
import 'package:playing_cards/widgets/card_column.dart';
import 'package:playing_cards/widgets/transformed_card.dart';

class EmptyCardDeck extends StatefulWidget {
  final CardFaces cardFace;
  final List<PlayingCard> cardsAdded;
  final CardAcceptCallback onCardAdded;
  final int columnIndex;

  EmptyCardDeck({
    required this.cardFace,
    required this.cardsAdded,
    required this.onCardAdded,
    required this.columnIndex,
  });

  @override
  _EmptyCardDeckState createState() => _EmptyCardDeckState();
}

class _EmptyCardDeckState extends State<EmptyCardDeck> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<Map>(
      builder: (context, listOne, listTwo) {
        return widget.cardsAdded.length == 0
            ? Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  height: 60.0,
                  width: 40,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 20.0,
                            child: _suitToImage(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : TransformedCard(
                playingCard: widget.cardsAdded.last,
                columnIndex: widget.columnIndex,
                attachedCards: [
                  widget.cardsAdded.last,
                ],
              );
      },
      onWillAccept: (value) {
        PlayingCard cardAdded = value!["cards"].last;

        if (cardAdded.cardFace == widget.cardFace) {
          if (CardValues.values.indexOf(cardAdded.cardValue) ==
              widget.cardsAdded.length) {
            return true;
          }
        }

        return false;
      },
      onAccept: (value) {
        widget.onCardAdded(
          value["cards"],
          value["fromIndex"],
        );
      },
    );
  }

  Image _suitToImage() {
    switch (widget.cardFace) {
      case CardFaces.hearts:
        return Image.asset('images/hearts.png');
      case CardFaces.diamonds:
        return Image.asset('images/diamonds.png');
      case CardFaces.clubs:
        return Image.asset('images/clubs.png');
      case CardFaces.spades:
        return Image.asset('images/spades.png');
      default:
        return Image.asset('images/empty.png');
    }
  }
}