#!/bin/bash
# menu.sh - Menú de gestió de sistema
# Ús: ./menu.sh                  (menú interactiu)
#     ./menu.sh 1 "Ivan"         (opció 1 amb paràmetre)
#     ./menu.sh -add "Ivan"      (el mateix amb flag)
 
# ---------- FUNCIONS ----------
 
# afegir_usuari: crea un usuari. Paràmetre: $1 = nom d'usuari
afegir_usuari() {
    local nom="$1"
    if [ -z "$nom" ]; then
        read -p "Nom de l'usuari: " nom
    fi
    sudo useradd -m "$nom" && echo "Usuari '$nom' creat."
}
 
# eliminar_usuari: elimina un usuari. Paràmetre: $1 = nom d'usuari
eliminar_usuari() {
    local nom="$1"
    if [ -z "$nom" ]; then
        read -p "Nom de l'usuari: " nom
    fi
    sudo userdel -r "$nom" && echo "Usuari '$nom' eliminat."
}
 
# espai_disc: mostra l'espai en disc. Paràmetres: cap
espai_disc() {
    local ruta="/"
    df -h "$ruta"
}
 
# info_sistema: mostra el nom de l'equip i el nucli. Paràmetres: cap
info_sistema() {
    local equip=$(hostname)
    local nucli=$(uname -r)
    echo "Equip: $equip"
    echo "Nucli: $nucli"
}
 
# mostrar_menu: imprimeix el menú. Paràmetres: cap
mostrar_menu() {
    echo
    echo "===== MENÚ ====="
    echo "1) Afegir usuari"
    echo "2) Eliminar usuari"
    echo "3) Espai en disc"
    echo "4) Informació del sistema"
    echo "0) Sortir"
}
 
# executar_opcio: crida la funció de l'opció triada.
# Paràmetres: $1 = opció (número o flag), $2 = argument (opcional)
executar_opcio() {
    local opcio="$1"
    local argument="$2"
    case "$opcio" in
        1|-add) afegir_usuari "$argument" ;;
        2|-del) eliminar_usuari "$argument" ;;
        3|-disk) espai_disc ;;
        4|-info) info_sistema ;;
        0) echo "Adéu!"; exit 0 ;;
        *) echo "Opció no vàlida." ;;
    esac
}
 
# ---------- LÒGICA PRINCIPAL ----------
 
# Si hi ha paràmetres, s'executa l'opció i s'acaba
if [ $# -ge 1 ]; then
    executar_opcio "$1" "$2"
    exit 0
fi
 
# Si no, menú en bucle fins que l'usuari tria sortir
while true; do
    mostrar_menu
    read -p "Escull una opció: " opcio
    executar_opcio "$opcio"
done

