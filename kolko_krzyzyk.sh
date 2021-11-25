#!/bin/bash

PLANSZA=("-" "-" "-" "-" "-" "-" "-" "-" "-")
KONIEC=0
GRACZ=0
REMIS=1

function wyswietl {
    clear
    for RZAD in {0..2}
    do
        echo ${PLANSZA[$RZAD * 3]} ${PLANSZA[$RZAD * 3 + 1]} ${PLANSZA[$RZAD * 3 + 2]}
    done
    echo
}

function zakoncz {
    wyswietl
    echo "Wygrywa gracz" $GRACZ
    KONIEC=1
    REMIS=0
}

function sprawdz_wygrana {
    for RZAD in {0..2}
    do
        if [[
            ${PLANSZA[$RZAD * 3]} = "O" &&  ${PLANSZA[$RZAD * 3 + 1]} = "O" &&  ${PLANSZA[$RZAD * 3 + 2]} = "O" || \
            ${PLANSZA[$RZAD * 3]} = "X" &&  ${PLANSZA[$RZAD * 3 + 1]} = "X" &&  ${PLANSZA[$RZAD * 3 + 2]} = "X"  || \
            ${PLANSZA[$RZAD]} = "O" &&  ${PLANSZA[$RZAD + 3]} = "O" &&  ${PLANSZA[$RZAD + 6]} = "O" || \
            ${PLANSZA[$RZAD]} = "X" &&  ${PLANSZA[$RZAD + 3]} = "X" &&  ${PLANSZA[$RZAD + 6]} = "X"
        ]]
        then
            zakoncz
        fi
    done
    if [[
            ${PLANSZA[0]} = "O" &&  ${PLANSZA[4]} = "O" &&  ${PLANSZA[8]} = "O" || \
            ${PLANSZA[0]} = "X" &&  ${PLANSZA[4]} = "X" &&  ${PLANSZA[8]} = "X" || \
            ${PLANSZA[2]} = "O" &&  ${PLANSZA[4]} = "O" &&  ${PLANSZA[6]} = "O" || \
            ${PLANSZA[2]} = "X" &&  ${PLANSZA[4]} = "X" &&  ${PLANSZA[6]} = "X"
    ]]
    then
        zakoncz
    fi
}

function zmiana_gracza {
    echo "Gracz nr" $GRACZ
    if [ $GRACZ = 0 ]
    then
        GRACZ=1
    else
        GRACZ=0
    fi
    echo "Gracz nr" $GRACZ
}

function wybierz {
    echo "Graczu" $GRACZ "wybierz niezajete pole z przedzialu [0, 8]"
    read POLE
    if [ ${PLANSZA[$POLE]} = "-" ]
    then
        if [ $GRACZ = 0 ]
        then
            PLANSZA[$POLE]="O"
        else
            PLANSZA[$POLE]="X"
        fi
        POPRAWNYWYBOR=1
    fi
}

while [ $KONIEC = 0 ]
do
    POPRAWNYWYBOR=0
    while [ $POPRAWNYWYBOR = 0 ]
    do
        wyswietl
        wybierz
    done
    sprawdz_wygrana
    if [ $KONIEC = 0 ]
    then
        zmiana_gracza
    fi
done
if [ $REMIS = 1 ]
then
    echo "Remis"
fi