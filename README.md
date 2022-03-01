# SmartContracts-ETH

Este repositorio son las notas de lo que voy aprendiendo si ves algo mal levanta un issue y lo compongo.

<h2> ETH dos tipos de direcciones existen </h2>
<p> There are two kinds of accounts in Ethereum which share the same address space: External accounts that are controlled by public-private key pairs (i.e. humans) and contract accounts which are controlled by the code stored together with the account.
</p> 

<p> La dirección de una cuenta externa se determina a partir de la clave pública, mientras que la dirección de un contrato se determina en el momento en que se crea el contrato. </p>

<h2> ETHER y WEI </h2> 

<p> Además, cada cuenta tiene un saldo en Ether (en "Wei" para ser exactos, 1 ether es 10 ** 18 wei) que se puede modificar enviando transacciones que incluyan Ether.</p> 

<h2> Storage vs. Memory vs. Stack in Solidity & Ethereum </h2> 


<h3> Storage </h3> 

<p> Los datos en el almacenamiento se escriben en la cadena de bloques (por lo tanto, cambian el estado), están disponibles entre llamadas a funciones y transacciones. También se pueden leer "manualmente" desde la cadena de bloques.<p>

<h3> Memory </h3>

<p> La memoria es una matriz de bytes con tamaños de ranura de 256 bits (32 bytes). Aquí los datos se almacenan solo durante la ejecución de la función. Después de eso, se eliminan. No se guardan en la cadena de bloques. Debido a su naturaleza a corto plazo, la memoria se compara con el almacenamiento barato. Leer o escribir una palabra (256 bits) cuesta 3 gas. Para evitar demasiado trabajo a los mineros, los costos por operación comienzan a subir después de 22 operaciones. </p>

<h3> Stack </h3> 
  
<p> La pila es un lugar interno donde se almacenan las variables temporales en ranuras de 32 bits. Suele utilizarse para tipos de valor en funciones. La pila contiene aquellas variables que son necesarias para el procesamiento inmediato. Puede comprender 1024 valores, pero solo los 16 superiores son fácilmente accesibles.</p> 

<h3> Ejemplos </h3>

<p> State variables (declared directly in the smart contract) always storage.<br>
Function arguments. Always memory (with array types like string this needs to be stated explicitly)<br>
Local variables (in functions) of the types struct, array or mapping are stored either in memory or storage. The place needs to be stated explicitly when declaring the variable.<br>
Local variables (in functions) of value types (e. g. uint32) always in stack<br>
  
</p>
  
<p> Fuente: https://dlt-repo.net/storage-vs-memory-vs-stack-in-solidity-ethereum/ </p>

<h2> La direccion 0x00000 </h2>

<p> En realidad, no es cierto que una transacción de creación de contrato tenga un campo "para" configurado en la dirección cero (es decir, 0x00 ... 000). Este es un error fácil de cometer (y yo también lo cometí), ya que se describe de esa manera en muchos recursos. </p>

<p> The passage you cite from the Solidity docs were updated to state this:

Si la cuenta de destino no está configurada (la transacción no tiene un destinatario o el destinatario está configurado como nulo), la transacción crea un nuevo contrato. Como ya se mencionó, la dirección de ese contrato no es la dirección cero sino una dirección derivada del remitente y su número de transacciones enviadas (el "nonce"). <strong (por ejemplo, emisor es un sinónimo de remitente) </strong> </p>

<p> Entonces puede ver que se dieron cuenta en algún momento de que el campo del destinatario debería estar vacío. De hecho, miré las transacciones de creación serializadas y encontré 0x80 allí en lugar de una dirección cero RLP-ed. </p> 

<p> De hecho, 0x80 es la codificación RLP de una matriz de bytes vacía, que es lo que el Yellow Paper afirma que es el destinatario de la creación de un contrato: </p> 
<p> <strong> Fuente: https://stackoverflow.com/questions/48219716/what-is-address0-in-solidity </strong> </p> 
<h2> License Identifier </h2> 

<p> El compilador Solidity fomenta el uso de identificadores de licencia SPDX legibles por máquina. Cada archivo de origen debe comenzar con un comentario que indique su licencia: // SPDX-License-Identifier: MIT </p>

<p> If you do not want to specify a license or if the source code is not open-source, please use the special value UNLICENSED </p> 

<h2> Data Types </h2> 

<ol> 
  <li> uint8 public u8 = 1;	</li>
   <li> uint public u256 = 4</li>
   <li> uint public u = 123	</li>
    <li>int8 public i8 = -1;	</li>
    <li>int public i256 = 456;	</li>
    <li>int public i = -123;	</li>
    <li> address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;</li>
  <br>
    <p> <strong> Default values </strong> </p>
    <li>bool public defaultBoo; // false	</li>										
    <li>uint public defaultUint; // 0 		</li>										
    <li>int public defaultInt; // 0 		</li>										
    <li>address public defaultAddr; // 0x0000000000000000000000000000000000000000 (42 Caracteres con todo y el 0x)</li>
</ol>   

<h2> Structure of a Contract </h2> 

<p> Contracts in Solidity are similar to classes in object-oriented languages. Each contract can contain declarations of State Variables, Functions, Function Modifiers, Events, Errors, Struct Types and Enum Types. Furthermore, contracts can inherit from other contracts. </p>

<h3> State Variables </h3>


```
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract SimpleStorage {
    uint storedData; // State variable
    // ...
}


```


<h3>  Functions </h3> 

<p> Functions are the executable units of code. Functions are usually defined inside a contract, but they can also be defined outside of contracts. </p>

<h3> Function Modifiers </h3>

<p> Modifiers can be used to change the behaviour of functions in a declarative way. For example, you can use a modifier to automatically check a condition prior to executing the function. </p>

```
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Purchase {
    address public seller;

    modifier onlySeller() { // Modifier
        require(
            msg.sender == seller,
            "Only seller can call this."
        );
        _;
    }

    function abort() public view onlySeller { // Modifier usage
        // ...
    }
}

```
<h3> Events </h3> 

<p> Events are convenience interfaces with the EVM logging facilities.</p> 

<h3> Errors </h3> 

<p> Los errores le permiten definir nombres descriptivos y datos para situaciones de falla. Los errores se pueden utilizar en declaraciones de reversión. </p> 

<h3> Struct Types </h3> 

<p> Structs are custom defined types that can group several variables (see Structs in types section). </p> 

```


// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract Ballot {
    struct Voter { // Struct
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
}


```

<h3> Enum Types </h3> 

<p> Enums can be used to create custom types with a finite set of ‘constant values’ (see Enums in types section). </p>

```
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract Purchase {
    enum State { Created, Locked, Inactive } // Enum
}

```

# Mastering Ethereum by Andreas

## Unidades 

| Value (in wei)	| Exponent	| Common name	| SI name|
| --------------- | ----------|------------ | -------|
|1 |1| wei |Wei|
|1,000|10^3|Babbage|Kilowei or femtoether|
|1,000,000|10^6|Lovelace|Megawei or picoether|
|1,000,000,000|10^9|Shannon|Gigawei or nanoether|
|1,000,000,000,000|10^12|Szabo|Microether or micro|
|1,000,000,000,000,000|10^15|Finney|Milliether or milli|
|1,000,000,000,000,000,000|10^18|Ether|Ether|
|1,000,000,000,000,000,000,000|10^21|Grand|Kiloether|
|1,000,000,000,000,000,000,000,000|10^24||Megaether|


### Ropsten Test Network
>Ethereum public test blockchain and network. ETH on this network has no value.


### Rinkeby Test Network
>Ethereum public test blockchain and network, using the Clique consensus protocol with proof of authority (federated signing). ETH on this network has no value.

Localhost 8545
Connects to a node running on the same computer as the browser. The node can be part of any public blockchain (main or testnet), or a private testnet.

Custom RPC
Allows you to connect MetaMask to any node with a Geth-compatible Remote Procedure Call (RPC) interface. The node can be part of any public or private blockchain.

### Externally Owned Accounts (EOAs) and Contracts

Son las cuentas que tienen claves privadas

### Contracts accounts

Son las que pertenecen a contratos inteligentes y no tienen claves privadas

Contracts have addresses, just like EOAs. Contracts can also send and receive ether, just like EOAs. However, when a transaction destination is a contract address, it causes that contract to run in the EVM, using the transaction, and the transaction’s data, as its input. In addition to ether, transactions can contain data indicating which specific function in the contract to run and what parameters to pass to that function. In this way, transactions can call functions within contracts.

### ZERO Address 

Registering a contract on the blockchain involves creating a special transaction whose destination is the address 0x0000000000000000000000000000000000000000, also known as the zero address. The zero address is a special address that tells the Ethereum blockchain that you want to register a contract. Fortunately, the Remix IDE will handle all of that for you and send the transaction to MetaMask.

### Internal Transaccion 

>Remember that all currency values in Ethereum are denominated in wei internally,


It is an internal transaction (also called a message).

Where’s the outgoing withdrawal? A new tab has appeared on the contract’s address history page, named Internal Transactions. Because the 0.1 ether transfer originated from the contract code, it is an internal transaction (also called a message). Click on that tab to see it (see Etherscan shows the internal transaction transferring ether out from the contract).


This "internal transaction" was sent by the contract in this line of code (from the withdraw function in Faucet.sol):

`msg.sender.transfer(withdraw_amount);`


## Transaction Gas (Gas price, Gas limit)

El gas no es éter, es una moneda virtual separada con su propio tipo de cambio frente al éter. Ethereum usa gas para controlar la cantidad de recursos que puede usar una transacción, ya que será procesada en miles de computadoras alrededor del mundo.

El campo gasPrice en una transacción permite que el originador de la transacción establezca el precio que está dispuesto a pagar a cambio del gas.

Las billeteras pueden ajustar el precio del gas en las transacciones que originan para lograr una confirmación más rápida de las transacciones. Cuanto mayor sea el precio del gas, más rápido se confirmará la transacción.

Para pagos simples, es decir, transacciones que transfieren éter de un ***EOA a otro EOA***, la cantidad de gas necesaria se fija en ***21 000 unidades de gas.***

Por lo tanto para calular cuanto ether va a costar se va a multiplicar 21000(cantidad de gas para transccion de EOA a EOA osea simple)por el Gas Price.

Dicho en otras palabras
>Con el límite de GAS, usted especifica cuántas unidades de GAS desea utilizar para una transacción. 21000 suele ser suficiente para las transferencias sencillas. El precio del GAS se expresa en ***GWEI***

### Destinatario de la transacción (Transaction Recipient)

El destinatario de una transacción se especifica en el campo para. Este contiene una dirección Ethereum de ***20 bytes***. La dirección puede ser un EOA o una dirección de contrato.( este campo no se valida)

>El protocolo Ethereum no valida las direcciones de los destinatarios en las transacciones. Puede enviar a una dirección que no tiene una clave privada o contrato correspondiente, por lo tanto, "quema" el éter, haciéndolo inutilizable para siempre.La validación debe realizarse en el nivel de la interfaz de usuario


### Transaction Value and Data

La "carga útil" principal de una transacción está contenida en dos campos: valor y datos. Las transacciones pueden tener valor y datos, solo valor, solo datos o ni valor ni datos. Las cuatro combinaciones son válidas.

Una transacción con solo valor es un pago. Una transacción con solo datos es una invocación. Una transacción con valor y datos es tanto un pago como una invocación. Una transacción sin valor ni datos, ¡bueno, eso probablemente sea solo una pérdida de gasolina! Pero todavía es posible.

### Wallet vs Account cual es la diferencia

>What is the difference between an account and a wallet? An account is a subsection of wallets that allows you to separate funds according to use-case without the need to create multiple new wallets. ... Accounts are tied to the wallet in which they are created. The recovery phrase for your wallet unlocks access to all accounts inside that wallet.

Dicho en mis palabras dentro de metamaks( que es una wallet) se pueden tener divididos los fondos en cuentas tal y como pasa para loq ue juegan axie infinity y dividen en cuentas a sus becados.

## Que es ABI (Application Binary Interface) en ETH

>To access functions defined in high-level languages, users need to translate names and arguments into byte representations for byte code to work with it. To interpret the bytes sent in response, users need to convert back to the tuple of return values defined in higher-level languages. Languages that compile for the EVM maintain strict conventions about these conversions, but in order to perform them, one must know the precise names and types associated with the operations. The ABI documents these names and types precisely, easily parseable format, doing translations between human-intended method calls and smart-contract operations discoverable and reliable.


>It is very similar to API (Application Program Interface), a human-readable representation of a code’s interface. ABI defines the methods and structures used to interact with the binary contract, just like API does but on a lower-level. The ABI indicates the caller of the function to encode the needed information like function signatures and variable declarations in a format that the EVM can understand to call that function in bytecode; this is called ABI encoding. 

En mis palabras es un JSON que contiene informacion del contrato como nombre de las funciones si son pagables los inputs etc.


#### Ejemplo: Increment.sol 

```
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract test {
    
    uint256 private count = 0;

    function increment() public {
        count += 1;
    }
    
    function getCount() public view returns (uint256) {
        return count;
    }

}
```
>solcjs test.sol --abi

### ABI generado

```
[
	{
		"inputs": [],
		"name": "getCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "increment",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]

```
