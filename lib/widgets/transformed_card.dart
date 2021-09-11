//making the card draggable and translating it to stack pos
import 'package:flutter/material.dart';
import 'package:playing_cards/models/card_model.dart';
import 'package:playing_cards/widgets/card_column.dart';

class TransformedCard extends StatefulWidget {
 final PlayingCard playingCard;
  final double transformDistance;
  final int transformIndex;
  final int columnIndex;
  final List<PlayingCard> attachedCards;
  TransformedCard({required this.attachedCards,required this.columnIndex,
  required this.playingCard,this.transformDistance=15.0,this.transformIndex=0});

  @override
  _TransformedCardState createState() => _TransformedCardState();
}

class _TransformedCardState extends State<TransformedCard> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
      ..translate(
        0.0,
        widget.transformIndex*widget.transformDistance,
        0.0,
      ),
      child: _buildCard(),
    );
  }
  //if card is facing downwards, we just have to show the back of the card
  Widget _buildCard(){
    return !widget.playingCard.isUpside?
    Container(
      height: 60.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ):
    //if card is facing upwards we have to make it draggable and attach all the cards below it too
    //attach all the card data so that another dragtarget can recieve it
    Draggable<Map>(
      child: _buildFaceUpCard(),
      //widget displayed when card is being dragged 
      feedback: CardColumn(
        cards: widget.attachedCards,
        columnIndex: 1,
        onCardsAdded: (card,position){},
      ),
      childWhenDragging: _buildFaceUpCard(),
      data: {
        "cards":widget.attachedCards,
        "fromIndex":widget.columnIndex,
      },
    );
  }

  Widget _buildFaceUpCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        height: 60.0,
        width: 40,
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    child: _suitToImage(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    Container(
                      height: 10.0,
                      child: _suitToImage(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _cardTypeToString() {
    switch (widget.playingCard.cardValue) {
      case CardValues.one:
        return "1";
      case CardValues.two:
        return "2";
      case CardValues.three:
        return "3";
      case CardValues.four:
        return "4";
      case CardValues.five:
        return "5";
      case CardValues.six:
        return "6";
      case CardValues.seven:
        return "7";
      case CardValues.eight:
        return "8";
      case CardValues.nine:
        return "9";
      case CardValues.ten:
        return "10";
      case CardValues.jack:
        return "J";
      case CardValues.queen:
        return "Q";
      case CardValues.king:
        return "K";
      default:
        return "";
    }
  }

  Image _suitToImage() {
    switch (widget.playingCard.cardFace) {
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