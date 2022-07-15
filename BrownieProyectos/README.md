# Intentar dominar brownie para crear proyectos

# Default

El archivo de configuracion de brownie es: ***brownie-config.yaml***

Por default brownie intenta desplegar el contrato en ganache que trae integrado ( no guarda nada)

# Accounts existen 3 metodos para trabajar con esto

>from brownie import accounts

Esta instruccion permite trabajar con las cuentas que brownie tiene disponibles por ejemplo se podria hacer accounts[0] y hariamos referencia 
a la cuenta 0 de garnache tiene 10 cuentas por default. Pero de esta forma solo podemos trabajar con las de garnache

## Metodo 1 Solo cuentas de Ganache

Trabajar con las accounts de ganache solo de testing

```
account=accounts[0-9]
print(account)

```

## Metodo 2 Trabajar con cuentas reales

> brownie accounts new nombredelacuenta


Posteriormente te pedira tu clave privada.

Para eliminar la cuenta.

> brownie accounts delete nombre

### Cargar una cuenta existente 

Dentro del script de deploy(esta funcion te va a pedir un password para usar la cuenta)

```

def get_account():
  account = accounts.load("nombredelaaccount")

```

## Metodo 3 Accounts en .env ( la menos segura)

Se pone en el archivo ***.env***





