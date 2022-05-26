# Brownie 

Es como truffle pero para python y ayuda a evitar escribir todo de 0

## Crear un proyecto

> brownie init

## Carpetas

Poner el contrato en la carpeta de la rama principal contracts no en build/contracts.

## Compilar codigo

< brownie compile

## Carpeta scritps

Aqui es donde se ejecuta el main

## Crear una cuenta 

> brownie accounts new freecodecamp

## Lista de cuentas 


>brownie accounts list

## The Configuration File

You can modify Brownie’s default behaviours by creating an optional configuration file.

The configuration file must be saved as brownie-config.yaml. If saved in the root directory of a project it will be loaded whenever that project is active. 
If saved in your home path, it will always be loaded.

## Poner un proveedor a la red Kovan

brownie networks modify kovan host=https://speedy-nodes-nyc.moralis.io/0ec78c5cd99adsafasfdae098ed6f9a07b/eth/kovan

### Iniciar un proyecto 

scritps/deploy.py

Es en este archivo donde se hace el deploy por codigo asi como basicamente todo transacciones retornos de valor se puede usar con la consola.

``` 
from brownie import *


def main():
    print("Hoello")

```

## brownie-config.yaml

Archivo de configuracion de brownie te dice como hacer basicamente todo.

dotenv:.env esto van dentro del archivo de configuracion y le dice a brownie que agarre variables de entorno del .env al momento de correr scritps

## Deploy a contract

```
from brownie import *

def main():

    # print(accounts[0])
    account = accounts.add(config["wallets"]["from_key"])
    print(account)
    SimpleStorage.deploy({"from": account})
```
    
Primero se importa en el script despues se usa la funcion deploy

### Opcion 1

> from brownie import *

Con esta opcion estas diciendole que importas todo osea que ya esta importado SimpleStorage y ya solo usar deploy

### Opcion 2

Importar cada cosa que vayas usando aqui tienes mas control ve ejemplo de abajo.



```
from brownie import accounts, config, SimpleStorage


def main():

    # print(accounts[0])
    account = accounts.add(config["wallets"]["from_key"])
    print(account)
    SimpleStorage.deploy({"from": account})
   
```
   
# Main Networks

> brownie networks list

Todas las redes que tengan develoment son temporales y se borran cuando se termina de ejecutar el contrato. Para trabajar en redes testnet o las main usa un provedor como infura o molaris. Pero primero tienes que agregar una cuenta ya que esta es la que tiene el ETH de esas redes. Algo que note es que cada que haces una transaccion tienes que esperar a que se complete de otro modo da error.

> transaction.wait(1)

Esperas un bloque que se confirme o mine y ya pides datos.


## Agregar una cuenta


Para conectarte a una testnet necesitas una addrees con ether de esa red y posteriormente agregarla a brownie

>brownie accounts new 1
 
Metes tu clave privada y en el codigo:

> return accounts.load("1")

## Desplegar en testnet

 >brownie run scripts/deploy.py --network ropsten
 
 >brownie run scripts/deploy.py --network kovan
 
 >brownie run scripts/deploy.py --network rinkeby

```
rom brownie import *

# from brownie import accounts, config, SimpleStorage


def deploy_simple_storage():

    # print(accounts[0])
    # account = accounts.add(config["wallets"]["from_key"])
    account = get_account()
    # print(account)
    simple_storage = SimpleStorage.deploy({"from": account})
    print("IMRPIMIENDO")
    # print(simple_storage)
    stored_value = simple_storage.retrieve()
    print("1 Retrevie")
    print(stored_value)
    transaction = simple_storage.store(25, {"from": account})
    transaction.wait(1)
    # print(account.balance())
    updated_stored_value = simple_storage.retrieve()
    print("2 Retrevie")
    print(updated_stored_value)
    print("NUEVO Transaccion2:")
    transaction2 = simple_storage.store(1500, {"from": account})
    transaction2.wait(1)
    updated_stored_value2 = simple_storage.retrieve()
    print(updated_stored_value2)


def get_account():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.load("1")


def main():
    print("Dentro del main")
    deploy_simple_storage()
   
```
  ## Test 
  
  Seran scritps en python de igual manera. Tiene que empesar por la palabra test eso si!
  
  ```
  #test_simple_storage
  from brownie import SimpleStorage, accounts


def test_deploy():
    # Arrange
    account = accounts[0]
    # Act
    simple_storage = SimpleStorage.deploy({"from": account})
    starting_value = simple_storage.retrieve()
    expected = 0
    # Assert
    assert starting_value == expected
    
    ```
  Los test no tienen que ver con el scripts/deploy ya que aqui se esta trabajando unicamente con el.
  Si solo deseas probar una funcion de test entonces usa
  
  brownie test -k test_name
  
  brownie test --pdb
  
  brownie test -s
  
  Es como un break point se para en onde hya errores y genera una shell para que debugges valores.
  
