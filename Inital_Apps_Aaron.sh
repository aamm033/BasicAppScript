#!/bin/bash

#Script basico de actualizacion e instalacion de herramientas Linux

echo "********************************************"
echo "Por favor seleccionar la Distribucion de Linux Correcta"
echo "Ingresar D para Debian ó R para Red Hat"
echo "********************************************"

#Captura de parametros
read Distro

#Condicional para Debian
if [ "$Distro" == "D" ]
then
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
nala install -y htop nmap cockpit

#Para Activar Cockpit
echo ""
echo "Activando e Iniciando Cockpit"
systemctl enable --now cockpit.socket
systemctl start cockpit.socket

#Condicional para Red Hat
elif [ "$Distro" == "R" ]
then

#Actualizacion de base de datos de aplicaciones
echo "********************************************"
echo "Procedemos a Actualizar las Aplicaciones"
echo "********************************************"
yum update -y && yum upgrade -y

#Instalacion de Repositorio EPEL
yum install -y epel-release.noarch

#Instalacion de DNF
yum install -y dnf

#instalacion de paquetes con DNF
dnf install -y htop nmap cockpit

#Para Activar Cockpit
echo "********************************************"
echo "Activando e Iniciando Cockpit"
systemctl enable --now cockpit.socket
systemctl start cockpit.socket

else
echo "Por favor ingrese uno de las opciones mencionadas"

fi
