# Brownie Implemetacion  de Proyectos CheatSheet

# Default

El archivo de configuracion de brownie es: ***brownie-config.yaml*** y va a nivel raiz en la carpeta del proyecto junto con archivos como ***.env***.

Por default brownie intenta desplegar el contrato en ganache que trae integrado ( no guarda nada) si no le indicas a que red cuando intentas desplegar un contrato. 

# Accounts existen (3 metodos)

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

Se pone en el archivo ***.env*** .Para poder usar de esta manera las cuentas tienes que indicarlo en el archivo de confg de brownie de la siguiente manera:

***Dentro de brawnie-config-yaml***

```
dotenv: .env

```
Esto le indica a brownie que cuando cargue variables de entorno busque en el archivo ***.env***

***Dentro del .env***

```

export PRIVATE_KEY = 0xasdfalkh543klhtjkdslfgs

```

### Optimizacion de Metodo 3


***Dentro de brawnie-config-yaml***

```
dotenv: .env
wallets:
  from_key:$[PRIVATE_KEY}
 
```

Esto permite que se pueda usar para desplegar asi:

```
import from brownie accounts, config
def get_account():
  account = accounts.add(config["wallets"] ["from_key"])
  
```
Este metodo permite que NO te pida password al usar la private KEY en redes de pruebas.

# Deploy a contract 

Para desplegar un contrato se necesita crear un script .py y de ahi importar nuestro contrato de solidity por ejemplo:

```
from brownie import SimpleStorage
from brownie import accounts, config


def deploy_simple_storage():
    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})
    print(simple_storage)
    transaction.wait(1) # Le dice que espere un bloque para despues continuar haciendo lo que sea


def main():
    deploy_simple_storage()
    print("Hola soy un script")


```
Esta es como la plantilla basica de cualquier proyecto cabe destacar dos cosas importantes para ejecutar una funcion que no haga cambios
se haria asi ***storage_value=simple_storage.retrive()****. Pero si se va a coambiar algo se generaria una transaccion por lo tanto se
tiene que decir quien la manda asi:***transaction = simple_storage.store(15, {"from": account})***.

# Access Previos Deployments

Cada que se hace un deploy en una red se genera dentro de la carpeta build -> ***deployments*** una carpeta con el numero de la red ***3*** por ser ropsten
y ahi dentro esta la informacion del contrato que se desplego en formato json esto con el objetivo de no estar deployando el mismo contrato siempre si es que ya se 
tiene bien desplegado en la red de prueba o en la main.

read_value.py

```
from brownie import SimpleStorage
from brownie import accounts, config, network


def read_contract():
    print(SimpleStorage[-1])
    simple_storage = SimpleStorage[-1]
    first_deploy = SimpleStorage[0]
    print(simple_storage.retrieve())



def main():
    read_contract()

```

Para acceder al primer contrato desplegado se usa ***first_deploy = SimpleStorage[0]***. Para acceder al ultimo deplegado considerando
que ya tenemos muchos contratos desplegados ***simple_storage = SimpleStorage[-1]***.

Brownie sabe la **ABI y la Address*** porque se compilo en la carpeta del proyecto.


# Network  

Para poder interactuar con instrucciones como network.show_active() debemos importar network.

```
from brownie import SimpleStorage
from brownie import accounts, config, network

def get_account():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])


```


