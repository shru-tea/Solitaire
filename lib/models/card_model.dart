//creating a card model -> a card has 4 faces(diamonds, hearts, spade and clubs) and a type(1,2,3,..,J,K)
//enums to define constant values - color, card faces and card values

import 'package:flutter/material.dart';

enum Color {
  red,
  black
}

enum CardFaces {
  hearts,
  spades,
  clubs,
  diamonds,
}

enum CardValues {
  one,two,three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

class PlayingCard{
  CardFaces cardFace;
  CardValues cardValue;
  bool isOpened;
  bool isUpside;
  PlayingCard({required this.cardFace,required this.cardValue,
    this.isUpside = false,
    this.isOpened = false,});
  //getter for getting card color
  Color get cardColor {
    //if the face is queen or diamond, card color will be red else black
    if(cardFace == CardFaces.hearts || cardFace == CardFaces.diamonds) {
      return Color.red;
    } else {
      return Color.black;
    }
  }
  
}