import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playing_cards/models/card_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
    );
  }
}


//initialize a new game
void _initialize_new_game(){
  //initially there are 7 card columns to be filled
  List<PlayingCard> cardColumn1=[];
  List<PlayingCard> cardColumn2=[];
  List<PlayingCard> cardColumn3=[];
  List<PlayingCard> cardColumn4=[];
  List<PlayingCard> cardColumn5=[];
  List<PlayingCard> cardColumn6=[];
  List<PlayingCard> cardColumn7=[];

  //stores the remaining card decks
  List<PlayingCard> closedCards=[];
  List<PlayingCard> openCards=[];

  //stores the card in the final (suit) deck
  List<PlayingCard> finalQueensDeck=[];
  List<PlayingCard> finalDiamondsDeck=[];
  List<PlayingCard> finalSpadesDeck=[];
  List<PlayingCard> finalClubsDeck=[];

  //first we have to initialize all 52 cards and store in a list
  //for all faces, we need to add [1,2,3,...,J,Q,K] cards
  List<PlayingCard> allCards=[];
  CardFaces.values.forEach((face) { 
    CardValues.values.forEach((value) {
      allCards.add(PlayingCard(
        cardFace: face, 
        cardValue: value,
        isUpside: false,
        ));
     });
  });

  //when game first starts,column 1 has 1 card, column 2 has 2 cards..till column 7
  Random random = Random();
  for(int i=0;i<28;i++){
    int randomNumber = random.nextInt(allCards.length);
    if(i==0){
      PlayingCard card = allCards[randomNumber];
      cardColumn1.add(
        card
        ..isOpened=true
        ..isUpside=true,
      );
      //remove from allCards deck at that randomNumber position
      allCards.removeAt(randomNumber);
    }else if(i>0 && i<3){
      if(i==2){
        PlayingCard card = allCards[randomNumber];
        cardColumn2.add(
          card
          ..isOpened=true
          ..isUpside=true,
        );
      }else{
        cardColumn2.add(allCards[randomNumber]);
      }
      allCards.removeAt(randomNumber);
    }else if(i>2 && i<6){
      if(i==5){
        PlayingCard card = allCards[randomNumber];
        cardColumn3.add(
          card
          ..isOpened=true
          ..isUpside=true,
        );
      }else{
        cardColumn3.add(allCards[randomNumber]);
      }
      allCards.removeAt(randomNumber);
    }else if(i>5 && i<10){
      if(i==9){
        PlayingCard card = allCards[randomNumber];
        cardColumn4.add(
          card
          ..isOpened=true
          ..isUpside=true,
        );
      }else{
        cardColumn4.add(allCards[randomNumber]);
      }
      allCards.removeAt(randomNumber);
    }else if(i>9 && i<15){
      if(i==14){
        PlayingCard card = allCards[randomNumber];
        cardColumn5.add(
          card
          ..isOpened=true
          ..isUpside=true,
        );
      }else{
        cardColumn5.add(allCards[randomNumber]);
      }
      allCards.removeAt(randomNumber);
    }else if(i>14 && i<21){
      if(i==20){
        PlayingCard card = allCards[randomNumber];
        cardColumn6.add(
          card
          ..isOpened=true
          ..isUpside=true,
        );
      }else{
        cardColumn6.add(allCards[randomNumber]);
      }
      allCards.removeAt(randomNumber);
    }else{
      if(i==27){
        PlayingCard card = allCards[randomNumber];
        cardColumn7.add(
          card
          ..isOpened=true
          ..isUpside=true,
        );
      }else{
        cardColumn7.add(allCards[randomNumber]);
      }
      allCards.removeAt(randomNumber);
    }
  }
  //then we add the remaining cards to the remaining deck and open the
  //top card of that deck

  closedCards = allCards;
  openCards.add(
    closedCards.removeLast()
    ..isOpened=true
    ..isUpside=true,
  );


}

