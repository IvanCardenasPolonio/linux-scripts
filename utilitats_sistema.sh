#!/bin/bash

# Funció: benvinguda
# Descripció: Mostra un missatge de benvinguda amb el nom que posem.
# Paràmetres: $1 -> nom que introduïm

benvinguda() {
    local nom="$1"
    echo "Hola $nom, anem a comprovar el sistema"
}

# Funció: comprova_usuari
# Descripció: Comprova si l'usuari existeix i mostra un missatge si està o no.
# Paràmetres: $1 -> nom d'usuari que introduïm.

comprova_usuari() {
    local usuari="$1"
    if grep -q "^$usuari:" /etc/passwd; then
        echo "L'usuari $usuari està al sistema."
    else
        echo "L'usuari $usuari no està al sistema."
    fi
}

# Funció: calculadora_espai
# Descripció: Mostra l'espai lliure de la partició principal (/).
# Paràmetres: Cap, ho fa directament en executar l'script.

calculadora_espai() {
    echo "L'espai lliure de la partició principal és:"
    df -h /
}

# Les funcions es criden aquí, després de definir-les totes.

# Demanem el nom de l'alumne i el guardem a la variable
read -p "Introdueix el teu nom: " nom_inserit
# Cridem a benvinguda passant-li el nom per mostrar el missatge
benvinguda "$nom_inserit"

# Demanem el nom d'usuari que volem comprovar
read -p "Introdueix un nom d'usuari: " nom_usuari
# Cridem a comprova_usuari per veure si existeix a /etc/passwd
comprova_usuari "$nom_usuari"

# Cridem a calculadora_espai per mostrar l'espai lliure de /
calculadora_espai
