# Brownie Implemetacion  de Proyectos CheatSheet

# Default

El archivo de configuracion de brownie es: ***brownie-config.yaml*** y va a nivel raiz en la carpeta del proyecto junto con archivos como ***.env***.

Por default brownie intenta desplegar el contrato en ganache que trae integrado ( no guarda nada) si no le indicas a que red cuando intentas desplegar un contrato. 

***brownie-config.yaml***

```
dotenv: .env
wallets:
  from_key: ${PRIVATE_KEY}
  
```

***.env***

```
export PRIVATE_KEY = 0x33e9d238f1
export WEB3_INFURA_PROJECT_ID = 0b8395
export ETHERSCAN_TOKEN = 3V6

```

# Archivo de configuracion brownie-config.yaml


## Fragmento de Fundme


```
    fund_me = FundMe.deploy(
        price_feed_address,
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify")
        
```     
El get() permite tomar si se va a verificar el codigo podria pues ser asi:

(hasta donde entiendo)

```
    fund_me = FundMe.deploy(
        price_feed_address,
        {"from": account},
        publish_source=config["networks"][network.show_active()]["verify"]

```

***brownie-config.yaml***

```

dependencies:
  - smartcontractkit/chainlink-brownie-contracts@1.1.1
compiler:
  solc:
    remappings:
      - '@chainlink=smartcontractkit/chainlink-brownie-contracts@1.1.1'
dotenv: .env
networks:
  rinkeby:
    eth_usd_price_feed: '0x8A753747A1Fa494EC906cE90E9f37563A8AF630e'
    verify: True
  development:
    verify: False
  ganache-local:
    verify: False      
wallets:
  from_key: ${PRIVATE_KEY}



```

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

## Ejemplo de SimpleStorage

***deploy.py***

```
from brownie import SimpleStorage
from brownie import accounts, config, network

def get_account():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])
```



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

## Ejemplo de SimpleStorage

***deploy.py***

 ```
 from brownie import SimpleStorage
from brownie import accounts, config, network


def deploy_simple_storage():
    # account = accounts[0]
    # account = accounts.load("1")
    # account = accounts.add(config["wallets"] ["from_key"])
    account = get_account()
    simple_storage = SimpleStorage.deploy({"from": account})
    print(simple_storage)
    storage_value = simple_storage.retrieve()
    print(storage_value)
    transaction = simple_storage.store(15, {"from": account})
    transaction.wait(1)
    updated_value = simple_storage.retrieve()
    print(updated_value)
 
 ```

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

## Fragmento de FundMe

Al momento de elegir la red que queremos usar podemos usar ***network.show_active()*** que muestra la red y tirar del
archivo de configuracion (brownie-config.yaml)

```
price_feed_address = config["networks"][network.show_active()]["eth_usd_price_feed"]

```

# Consola

Para trabajar con la consola se necesita ya tener el proyecto. despues poner el comando.

> brownie console

Este comando abrira la consola (en est ejemplo se trabajo con ganache no se si se pueda en una testnet) y para poder interactuar con el contrato se hace lo siguiente:

```
>>> SimpleStorage
[]
>>> account = accounts[0]
>>> account
<Account '0x66aB6D9362d4F35596279692F0251Db635165871'>
>>> simple_storage = SimpleStorage.deploy({"from": account})
Transaction sent: 0x3184449bd03fc43c8fbd9e1b814bc52d2c4f67379decf9073c6d01c9ac19ca12
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
  SimpleStorage.constructor confirmed   Block: 1   Gas used: 333532 (2.78%)
  SimpleStorage deployed at: 0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87

>>> storage_value = simple_storage.retrieve()
>>> transaction = simple_storage.store(15, {"from": account})
Transaction sent: 0xbd20897ba62d3fa6ecbafeef2f955917ae6894dd6371d923ad7cd6be5ece0699
  Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 1
  SimpleStorage.store confirmed   Block: 2   Gas used: 41393 (0.34%)

>>> storage_value = simple_storage.retrieve()
>>> storage_value
15
>>>len(SimpleStorage
1
>>>quit()
!Exit!!

```


# ETHERSCAN

Para publicar el codigo en etherscan se necesita generar un token (se ogbtiene dentro eherscan creando uno dentro de la pagina).
Esta es la forma mas basica recuerda poner en el .env el token de etherscan.

deploy.py
```
fund_me = FundMe.deploy(
        price_feed_address,
        {"from": account},
        publish_source=True)
```


# Mocks

Se ponen en la carpeta contracts -> test(se crea esta) -> MockV3Aggregator.sol. En este caso lo sacaron de "chainlink-mix" github 

# Deploy Persisnten Ganache instance

Para agregar una instancia de ganache persistente 

## Paso 1

Primero ejecutar el ganache

> ./ganache.etc

## Paso 2 

Agregar esa red a brownie

> brownie networks add Ethereum ganache-local host=http://0.0.0.0:7545 chainid=5777

## Paso 3 

Usarla con --network ganache-local


# FORKED Network

Trabajar con una forked es como copiar y pegar la red principal de ethereum y en este tutorial te 
sugiere hacer el fork desde alchemy.

> brownie networks add development mainnet-fork cmd=ganache-cli host=http://127.0.0.1 fork=https://alchenyapi accounts=10 mnemonic=brownie port=8545

Entonces recuerda dejaste configurado en Ubuntu mainnet-fork el cual es una fork de la red pricipal que te presta alchemy. Para usar solo teclea:

> brownie run ... --network mainnet-fork



# Interactuar con contratos ya desplegados INTERFACES brownie ( Separa conceptos)

## Desde dentro del smartcontract

Recuerda que cuando haces import SimpleStorageInterface.sol literalmente lo que hace el compilador es pegar el codigo que ahi esta.

```
// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.6.6;

interface SimpleStorageInterface {
    function store(uint256 _favoriteNumber) external;

    function retrieve() external view returns (uint256);

    function addPerson(string memory _name, uint256 _favoriteNumber) external;
}

contract HelloWorld {
    string public greet = "Hello World!";

    SimpleStorageInterface simple =
        SimpleStorageInterface(0x99B7B7EF78b731734c7e02195e4D89F4cc91872f);

    function getValue() public view returns (uint256) {
        return simple.retrieve();
    }
}

```

## Desde el script 

Ayudandonos de brownie poniendo en la capeta interfaces el archiv .sol con la interfaz del contrato ya desplegado


```
from brownie import HelloWorld
from brownie import accounts, config, network, interface
# Ve que importamos la interface

def main():
    # hello = HelloWorld[-1]
    # print(hello.getValue())  # Automaticamente solidity crea un getter para esto que
    # Publico
    contract = interface.SimpleStorageInterface(
        "0x99B7B7EF78b731734c7e02195e4D89F4cc91872f"
    )
    print(contract)
    print(contract.retrieve())

# Solo necesitamos compilar y de ahi se obtiene el abi 
# Despues solo usamos la direccion como esta arriba
```








