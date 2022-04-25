# Web3.py 

Se usa visual studio code se instalo la extencion de python la oficial de Microsoft y la de solidity de Juan Blanco
Se cambio a pretty en el formato en settings de vscode tambien se instalo una extencion con pip black la cual es un pretty formater

>pip install black

En settings "python formatting" python formmating privoder y poner el black
Para usar la barra de comandos usa Ctrl+Shift+P para acceder a los shortcuts teclea keyboard shortcuts

## py-solc-x

Recomiendan utilizar este compilador de solidity debido a que lo actualizan mas amenudo

# Instalar y usar virtualenv con Python 3

Virtualenv es una herramienta usada para crear un entorno Python aislado. Este entorno tiene sus propios directorios de instalación que no comparten bibliotecas con otros entornos virtualenv o las bibliotecas instaladas globalmente en el servidor.

## Instalar el pip ( si es una maquina limpia)

>sudo apt install python3-pip -y

## Instalar virtualenv

>sudo pip3 install virtualenv

## Crear un ambiente virtual usando una versión personalizada de Python

Crea un ambiente virtual mientras específicas la versión de Python que deseas usar. El siguiente comando crea un virtualenv llamado 'venv' y usa una bandera -p para especificar el camino a la versión de Python 3 que acabas de instalar.

>virtualenv -p /usr/bin/python3 venv

Este comando crea una carpeta venv que sera en donde se trabaje posterirmetne ese comando solo se usa una sola vez para crear ese ambiente y ya despues solo se 
***activa y desactiva***

## Activar el nuevo ambiente virtual

>source venv/bin/activate

Cualquier paquete que instalas usando pip está ahora ubicado en la carpeta de proyectos de ambientes virtuales, aislado de la instalación global de Python.


## Desactivar tu virtualenv

>deactivate























