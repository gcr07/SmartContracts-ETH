# Intentar dominar brownie para crear proyectos

# Default

Por default brownie intenta desplegar el contrato en ganache que trae integrado ( no guarda nada)

# Accounts

>from brownie import accounts

Esta instruccion permite trabajar con las cuentas que brownie tiene disponibles por ejemplo se podria hacer accounts[0] y hariamos referencia 
a la cuenta 0 de garnache tiene 10 cuentas por default. Pero de esta forma solo podemos trabajar con las de garnache

## Trabajar con cuentas reales

> brownie accounts new nombredelacuenta


Posteriormente te pedira tu clave privada.

Para eliminar la cuenta.

> brownie accounts delete nombre



