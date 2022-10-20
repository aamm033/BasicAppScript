#!/bin/bash

#Script basico de actualizacion e instalacion de herramientas Linux

echo "********************************************"
echo "Por favor seleccionar la Distribucion de Linux Correcta"
echo "Ingresar (D) para Debian (R) para Red Hat ó (E) Para Salir"
echo "********************************************"

#Captura de parametros
read Distro

function D {
echo "********************************************"
echo "Procedemos a Prepapar lo necesario para la instalacion de NALA"
echo "********************************************"

#Instalacion de repositorio
echo "deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main" | tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - http://deb.volian.org/volian/scar.key | tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null

#Actualizacion de base de datos de aplicaciones
echo "********************************************"
echo "Procedemos a Actualizar las Aplicaciones"
echo "********************************************"
apt update -y && apt upgrade -y

#Instalacion de NALA
echo "********************************************"
echo "Procedemos a Instalar NALA"
echo "********************************************"
apt install -y nala-legacy

#Instalacion de paquetes con NALA
echo "********************************************"
echo "Procedemos a Instalar los Paquetes basicos"
echo "********************************************"
nala install -y htop nmap cockpit

#Para Activar Cockpit
echo "********************************************"
echo "Activando e Iniciando Cockpit"
echo "********************************************"
systemctl enable --now cockpit.socket
systemctl start cockpit.socket
echo "Cockpit Inicializado"
}


function R {
#Actualizacion de base de datos de aplicaciones
echo "********************************************"
echo "Procedemos a Actualizar las Aplicaciones"
echo "********************************************"
yum update -y && yum upgrade -y

#Instalacion de Repositorio EPEL
echo "********************************************"
echo "Procedemos a Prepapar lo necesario para la instalacion de DNF"
echo "********************************************"
yum install -y epel-release.noarch

#Instalacion de DNF
echo "********************************************"
echo "Procedemos a Instalar DNF"
echo "********************************************"
yum install -y dnf

#instalacion de paquetes con DNF
echo "********************************************"
echo "Procedemos a Instalar los Paquetes basicos"
echo "********************************************"
dnf install -y htop nmap cockpit

#Para Activar Cockpit
echo "********************************************"
echo "Activando e Iniciando Cockpit"
echo "********************************************"
systemctl enable --now cockpit.socket
systemctl start cockpit.socket
echo "Cockpit Inicializado"
}

function E {
exit
}

if [ "$Distro" == "D" ]
then
D
elif [ "$Distro" == "R" ]
then
R
elif [ "$Distro" == "E" ]
then 
E
else
echo "Por favor ingrese uno de las opciones mencionadas"
fi


echo "Gracias por utilizar los servicios"
