import 'package:flutter/material.dart';
import 'package:playing_cards/models/card_model.dart';
import 'package:playing_cards/widgets/transformed_card.dart';

//cards being translated more and more into the y column

typedef Null CardAcceptCallback(List<PlayingCard> card, int fromIndex);

class CardColumn extends StatefulWidget {
  final List<PlayingCard> cards;
  //when a card is added onto the stack
  final CardAcceptCallback onCardsAdded;
  //columnIndex notes the column number between the 7 columns we created
  final int columnIndex;
  CardColumn({required this.cards, required this.columnIndex, required this.onCardsAdded});

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.0*15.0,
      width: 70.0,
      margin: EdgeInsets.all(2.0),
      child: DragTarget<Map>(
        builder: (context,listOne,listTwo){
          return Stack(
            children: widget.cards.map((card){
              int index = widget.cards.indexOf(card);
              return TransformedCard(
                playingCard: card,
                transformIndex:index ,
                attachedCards: widget.cards.sublist(index, widget.cards.length),
                columnIndex: widget.columnIndex,
              );
            }).toList(),
          );
        },
        //will only accept dragged card if its opposite color and right order
        onWillAccept: (value){
          //if empty,accept
          if(widget.cards.length==0){
            return true;
          }
          //if some card(s) are dragged
          List<PlayingCard> draggedCards = value!["cards"];
          PlayingCard firstCard = draggedCards.first;
          if(firstCard.cardColor == Color.red){
            if(widget.cards.last.cardColor == Color.red){
              return false;
            }
            int lastColumnCardIndex = CardValues.values.indexOf(widget.cards.last.cardValue);
            int firstDraggedCardIndex = CardValues.values.indexOf(firstCard.cardValue);
            if(lastColumnCardIndex!=firstDraggedCardIndex+1){
              return false;
            }
          }else{
            if(widget.cards.last.cardColor==Color.black){
              return false;
            }
            int lastColumnCardIndex = CardValues.values.indexOf(widget.cards.last.cardValue);
            int firstDraggedCardIndex = CardValues.values.indexOf(firstCard.cardValue);
            if(lastColumnCardIndex!=firstDraggedCardIndex+1){
              return false;
            }
          }
          return true;
        },
        //when a card is accepted, a callback is invoked
        onAccept: (value){
          widget.onCardsAdded(
            value["cards"],
            value["fromIndex"],
          );
        },
      ),
    );
  }
}