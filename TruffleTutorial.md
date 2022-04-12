# Truffle

### Instalar Truffle

> https://www.npmjs.com/package/truffle/v/5.4.10-alpha.1

Instalar nodejs para poder usar truffle

```
node -v
npm -v
npm install -g truffle
```

##  Verificar Instalacion 

```
truffle version
```


## Truffle's Default Directory Structure

So, running the truffle init command inside of the CryptoZombies directory, should create several directories and some 
JavaScript and Solidity files. Let's have a closer look:

>Note: truffle init should automatically create a contract called Migrations.sol and the corresponding migration file. We'll explain them a bit later.

***contratos:***
>Este es el lugar donde Truffle espera encontrar todos nuestros contratos inteligentes. 
Para mantener el código organizado, incluso podemos crear carpetas anidadas como contratos/tokens. Con buena pinta

***migrations:***
>A migration is a JavaScript file that tells Truffle how to deploy a smart contract.
1. 1_initial_migration.js
2. 2_initial_migration.js
3. 3_initial_migration.js
4. 4_initial_mig...

***test:***
>Aquí se espera que pongamos las pruebas unitarias que serán archivos JavaScript o Solidity. Recuerde, una vez que se implementa un contrato, no se puede cambiar, por lo que es esencial que probemos nuestros contratos inteligentes antes de implementarlos.


***truffle.js and truffle-config.js:***

>Config files used to store the network settings for deployment. Truffle needs two config files because on Windows having both truffle.js and truffle.exe in the same folder might generate conflicts. Long story short - if you are running Windows, it is advised to delete truffle.js and use truffle-config.js as the default config file. Check out Truffle's official documentation to further your understanding.

Aqui se activa la red de development ganache

```
     development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
     },
     
```


***truffle-hdwallet-provider***

El proveedor Truffle HDWallet es una conexión de red conveniente y fácil de configurar a ethereum a través de infura.io (o cualquier otro proveedor compatible).

Por ejemplo, el proveedor de HDWallet agrega algunas funciones requeridas por Truffle que no están disponibles con infura, como el filtrado de eventos y la firma de transacciones.

Puede usar este proveedor donde sea que se necesite un proveedor Web3, no solo en Truffle. Para el uso específico de trufas, consulte la siguiente sección


```
npm install truffle-hdwallet-provider
```

## 1 Configuration Files

Aqui decide que red utilizar ya sea una testnet o ganache.

## 2 Migrations

Normally at this point, before deploying to Ethereum, you would want to test your smart contract locally. You can do this using a tool called Ganache, which sets up a local Ethereum network.

***To deploy to Ethereum we will have to create something called a migration.***

Las migraciones son archivos JavaScript que ayudan a Truffle a implementar el código en Ethereum. Tenga en cuenta que truffle init creó un contrato especial llamado Migrations.sol que realiza un seguimiento de los cambios que está realizando en su código. La forma en que funciona es que el historial de cambios se guarda en la cadena. Por lo tanto, no hay forma de que implemente el mismo código dos veces.

NOTA: Se tiene que crear un archivo de migration para cada contrato en orden 1_nombre 2_nombre 3_nombre como se muestra arriba.

## 3 Compile

```
truffle compile

``` 

Compila los contratos que esten el la carpeta de "contracts" ademas genera los llamados "artefactos" en la capeta built/contracts genera un archivo por cada contrato.

>Note: The build ***artifacts*** are comprised of the "bytecode" versions of the smart contracts, ABIs, and some internal data Truffle is using to correctly deploy the code. Avoid editing these files, or Truffle might stop working correctly.





































































