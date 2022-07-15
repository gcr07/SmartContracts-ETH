# SmartContracts-ETH

Este repositorio son las notas de lo que voy aprendiendo si ves algo mal levanta un issue y lo compongo.

## Ethereum mempool

mempool (el conjunto de transacciones pendientes y no confirmadas)

## MEV

Podríamos simplificar MEV como la técnica utilizada para reordenar transacciones y beneficiarse de la confirmación de estas, antes o después de otras transacciones. Por ejemplo, un usuario puede pagar una tarifa de gas extremadamente alta para que se confirme su compra de ETH antes de que el precio suba, y luego venderlo con ganancia.

Quienes hacen arbitraje están dispuestos a pagar precios altísimos para que sus transacciones sean priorizadas. Como consecuencia, se crea una guerra de oferta, generalmente negativa para todos.


MEV son las siglas de valor máximo extraíble, que se refiere al máximo valor que se puede obtener de un bloque, por encima de la recompensa estándar del mismo y las tarifas de gas. Esto se logra al incluir, excluir o modificar el orden de las transacciones de un bloque, priorizando las mejores ofertas.

La opinión respecto a esta práctica es en su mayoría negativa. Algunos investigadores señalan que se trata de un problema grave. Mientras, el otro lado de la balanza piensa que sus efectos son moderados y solucionables.


<h2> ETH dos tipos de direcciones existen </h2>
<p> There are two kinds of accounts in Ethereum which share the same address space: External accounts that are controlled by public-private key pairs (i.e. humans) and contract accounts which are controlled by the code stored together with the account.
</p> 

<p> La dirección de una cuenta externa se determina a partir de la clave pública, mientras que la dirección de un contrato se determina en el momento en que se crea el contrato. </p>

## Private Key -> Public Key -> Address

Primero se crea la llave privada a la cual le corresponde una llave publica y de es ya sale una direccion.

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


##  Soluciones de Capa 2

Las soluciones principales de la capa 2 son: ***Zero-Knowledge Rollups***, o “rollups de conocimiento cero”, y ***Optimistic Rollups***, o “rollups optimistas”.


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
## En la practica como son los ABI

>The data payload sent to an ABI-compatible contract (which you can assume all contracts are) is a hex-serialized encoding of:

### A function selector
The first 4 bytes of the Keccak-256 hash of the function’s prototype. This allows the contract to unambiguously identify which function you wish to invoke.

### The function arguments
The function’s arguments, encoded according to the rules for the various elementary types defined in the ABI specification.

In [solidity_faucet_example], we defined a function for withdrawals:

```
function withdraw(uint withdraw_amount) public {
```

>The prototype of a function is defined as the string containing the name of the function, followed by the data types of each of its arguments, enclosed in parentheses and separated by commas. The function name here is withdraw and it takes a single argument that is a uint (which is an alias for uint256), so the prototype of withdraw would be:

```
withdraw(uint256)
```

>Let’s calculate the Keccak-256 hash of this string:

```
> web3.utils.sha3("withdraw(uint256)");
'0x2e1a7d4d13322e7b96f9a57413e1525c250fb7a9021cf91d1540d5b69f16a49f'

```

>The first 4 bytes of the hash are 0x2e1a7d4d. That’s our "function selector" value, which will tell the contract which function we want to call.
Next, let’s calculate a value to pass as the argument withdraw_amount. We want to withdraw 0.01 ether. Let’s encode that to a hex-serialized big-endian unsigned 256-bit integer, denominated in wei:

```
> withdraw_amount = web3.utils.toWei(0.01, "ether");
'10000000000000000'
> withdraw_amount_hex = web3.utils.toHex(withdraw_amount);
'0x2386f26fc10000'

```

>Now, we add the function selector to the amount (padded to 32 bytes):

```
2e1a7d4d000000000000000000000000000000000000000000000000002386f26fc10000

Funtion selector + 32 padding + The function arguments //el padding tiene que dar 32 con todo y argumentos

python3
a = '000000000000000000000000000000000000000000000000002386f26fc10000'
print (len(a))
>64 ( Recordar que en hex cada caracter es 4bits osea que 1 byte seria 2 digitos)

```
### Crear un contrato

>Un caso especial que debemos mencionar es una transacción que crea un nuevo contrato en la cadena de bloques, desplegándolo para uso futuro. Las transacciones de creación de contratos se envían a una dirección de destino especial denominada dirección cero; el campo para en una transacción de registro de contrato contiene la dirección 0x0. Esta dirección no representa ni un EOA (no hay un par de claves pública-privada correspondiente) ni un contrato. Nunca puede gastar éter o iniciar una transacción. Solo se usa como destino, con el significado especial "crear este contrato".

>Una transacción de creación de contrato solo necesita contener una carga útil de datos que contenga el código de bytes compilado que creará el contrato. El único efecto de esta transacción es crear el contrato. Puede incluir una cantidad de éter en el campo de valor si desea configurar el nuevo contrato con un saldo inicial, pero eso es completamente opcional. Si envía un valor (ether) a la dirección de creación del contrato sin una carga útil de datos (sin contrato), entonces el efecto es el mismo que enviar a una dirección de grabación: no hay contrato para acreditar, por lo que se pierde el ether.


## Remix ETH 

Nos permite obtener tanto el ABI como el byte code nos vamos a donde se compila el contrato y hasta abajo dice ABI BYTES

***Donde object es el bytecode que se inyecta al crear un contrato***
```
{
   "linkReferences": {},
   "object": "608060405234801561001057600080fd5b5060f48061001f6000396000f3fe608060405260043610601f5760003560e01c80632e1a7d4d14602a576025565b36602557005b600080fd5b348015603557600080fd5b50605f60048036036020811015604a57600080fd5b81019080803590602001909291905050506061565b005b67016345785d8a0000811115607557600080fd5b3373ffffffffffffffffffffffffffffffffffffffff166108fc829081150290604051600060405180830381858888f1935050505015801560ba573d6000803e3d6000fd5b505056fea26469706673582212201ae4c9aae934d358c2385d58ca2372148b40b09998cb62ec6f16861a223245c464736f6c63430006040033",
   "opcodes": "PUSH1 0x80 PUSH1 0x40 MSTORE CALLVALUE DUP1 ISZERO PUSH2 0x10 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH1 0xF4 DUP1 PUSH2 0x1F PUSH1 0x0 CODECOPY PUSH1 0x0 RETURN INVALID PUSH1 0x80 PUSH1 0x40 MSTORE PUSH1 0x4 CALLDATASIZE LT PUSH1 0x1F JUMPI PUSH1 0x0 CALLDATALOAD PUSH1 0xE0 SHR DUP1 PUSH4 0x2E1A7D4D EQ PUSH1 0x2A JUMPI PUSH1 0x25 JUMP JUMPDEST CALLDATASIZE PUSH1 0x25 JUMPI STOP JUMPDEST PUSH1 0x0 DUP1 REVERT JUMPDEST CALLVALUE DUP1 ISZERO PUSH1 0x35 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH1 0x5F PUSH1 0x4 DUP1 CALLDATASIZE SUB PUSH1 0x20 DUP2 LT ISZERO PUSH1 0x4A JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST DUP2 ADD SWAP1 DUP1 DUP1 CALLDATALOAD SWAP1 PUSH1 0x20 ADD SWAP1 SWAP3 SWAP2 SWAP1 POP POP POP PUSH1 0x61 JUMP JUMPDEST STOP JUMPDEST PUSH8 0x16345785D8A0000 DUP2 GT ISZERO PUSH1 0x75 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST CALLER PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND PUSH2 0x8FC DUP3 SWAP1 DUP2 ISZERO MUL SWAP1 PUSH1 0x40 MLOAD PUSH1 0x0 PUSH1 0x40 MLOAD DUP1 DUP4 SUB DUP2 DUP6 DUP9 DUP9 CALL SWAP4 POP POP POP POP ISZERO DUP1 ISZERO PUSH1 0xBA JUMPI RETURNDATASIZE PUSH1 0x0 DUP1 RETURNDATACOPY RETURNDATASIZE PUSH1 0x0 REVERT JUMPDEST POP POP JUMP INVALID LOG2 PUSH5 0x6970667358 0x22 SLT KECCAK256 BYTE 0xE4 0xC9 0xAA 0xE9 CALLVALUE 0xD3 PC 0xC2 CODESIZE 0x5D PC 0xCA 0x23 PUSH19 0x148B40B09998CB62EC6F16861A223245C46473 PUSH16 0x6C634300060400330000000000000000 ",
   "sourceMap": "162:386:0:-:0;;;;5:9:-1;2:2;;;27:1;24;17:12;2:2;162:386:0;;;;;;;"
}

```

## Creacion de un contrato a mano con web3



## Firmas Digitales


#### Keccak 256 

>En node npm install keccak256

SHA3 ​​utiliza el algoritmo Keccak. En muchos casos, Keccak y SHA3 son sinónimos. Sin embargo, cuando SHA3 finalmente se estandarizó en agosto de 2015, NIST ajustó el algoritmo de relleno. El SHA3 estándar y el algoritmo Keccak original son diferentes. En el código temprano relacionado con Ethereum, SHA3 se usa comúnmente para referirse a Keccak256. Para evitar confusión con el estándar NIST SHA3, el código actual usa directamente Keccak256 como el nombre de la función.

Para aclarar que Ethereum usa KECCAK-256 en lugar de la función hash SHA-3 estandarizada por NIST, se ha introducido Solidity 0.4.3keccak256 

## Firma de una Transaccion pasos

Para producir una transacción válida, el emisor debe firmar digitalmente el mensaje, utilizando el algoritmo de firma digital de curva elíptica. Cuando decimos "firmar la transacción", en realidad queremos decir "firmar el hash Keccak-256 de los datos de transacción serializados por RLP". La firma se aplica al hash de los datos de la transacción, no a la transacción en sí.

>To sign a transaction in Ethereum, the originator must:

1. Create a transaction data structure, containing nine fields: nonce, gasPrice, gasLimit, to, value, data, chainID, 0, 0.

2. Produce an RLP-encoded serialized message of the transaction data structure.

3. Compute the Keccak-256 hash of this serialized message.

4. Compute the ECDSA signature, signing the hash with the originating EOA’s private key.

5. Append the ECDSA signature’s computed v, r, and s values to the transaction.


## Resumen 

S i g(Firma) = F sig ( HASH DE LA TX RLP encoded transaccion , private key  )

***Regresa valores***

 (r, s) 
 
 v es un valor que surgio de un hardfork para  identificar la red y evitar ataques EIP-155
 >The special signature variable v indicates two things: the chain ID and the recovery identifier to help the ECDSArecover function check the signature. 
 >To make things more efficient, the transaction signature includes a prefix value v, which tells us which of the two possible R values is the ephemeral public key.


***En general saber estos pasos te ayuda a entender el codigo JS pero por ejemplo el valor v y los r,s los agrega automaticamente***

## web3.eth.sendTransaction vs web3.eth.sendSignedTransaction

>Una vez que se firma una transacción, está lista para transmitirse a la red Ethereum. Los tres pasos de crear, firmar y transmitir una transacción normalmente ocurren como una sola operación, por ejemplo, usando web3.eth.sendTransaction. Sin embargo, como vio en Creación y firma de transacciones sin procesar, puede crear y firmar la transacción en dos pasos separados. Una vez que tenga una transacción firmada, puede transmitirla usando web3.eth.sendSignedTransaction, que toma una transacción firmada y codificada en hexadecimal y la transmite en la red Ethereum.

>¿Por qué querría separar la firma y la transmisión de transacciones? La razón más común es la seguridad. La computadora que firma una transacción debe tener claves privadas desbloqueadas cargadas en la memoria. La computadora que realiza la transmisión debe estar conectada a Internet (y ejecutar un cliente Ethereum). Si estas dos funciones están en una computadora, entonces tiene claves privadas en un sistema en línea, lo cual es bastante peligroso. Separar las funciones de firmar y transmitir y realizarlas en diferentes máquinas (en un dispositivo fuera de línea y en línea, respectivamente) se denomina firma fuera de línea y es una práctica de seguridad común.
 
 # Solidity
 
 
 ```
 // SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
 
 function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
) {
    Kitty storage kit = kitties[_id];

    // if this variable is 0 then it's not gestating
    isGestating = (kit.siringWithId != 0);
    isReady = (kit.cooldownEndBlock <= block.number);
    cooldownIndex = uint256(kit.cooldownIndex);
    nextActionAt = uint256(kit.cooldownEndBlock);
    siringWithId = uint256(kit.siringWithId);
    birthTime = uint256(kit.birthTime);
    matronId = uint256(kit.matronId);
    sireId = uint256(kit.sireId);
    generation = uint256(kit.generation);
    genes = kit.genes;
}
 ```
>The function looks a bit different than we're used to. You can see it returns... a bunch of different values. If you're coming from a programming language like Javascript, this is different — in Solidity you can return more than one value from a function.
 
 ### View functions don't cost gas
view functions don't cost any gas when they're called externally by a user.

This is because view functions don't actually change anything on the blockchain – they only read the data. So marking a function with view tells web3.js that it only needs to query your local Ethereum node to run the function, and it doesn't actually have to create a transaction on the blockchain (which would need to be run on every single node, and cost gas).
 
 >Note: If a view function is called internally from another function in the same contract that is not a view function, it will still cost gas. This is because the other function creates a transaction on Ethereum, and will still need to be verified from every node. So view functions are only free when they're called externally.
 
# OpenZeppelin's Ownable contract

>Below is the Ownable contract taken from the OpenZeppelin Solidity library. OpenZeppelin is a library of secure and community-vetted smart contracts that you can use in your own DApps. After this lesson, we highly recommend you check out their site to further your learning!

>https://docs.openzeppelin.com/
>https://docs.openzeppelin.com/contracts/3.x/

## Reglas de convencion de escritura para Solidity

funciones privadas o internas llevan un _ 
Funciones se escriben como javscript con el cammel.. esteEsUnEjemplo

https://solidity-es.readthedocs.io/es/latest/style-guide.html

## Resumen 

>We have visibility modifiers that control when and where the function can be called from: private means it's only callable from other functions inside the contract; internal is like private but can also be called by contracts that inherit from this one; external can only be called outside the contract; and finally public can be called anywhere, both internally and externally.

>We also have state modifiers, which tell us how the function interacts with the BlockChain: view tells us that by running the function, no data will be saved/changed. pure tells us that not only does the function not save any data to the blockchain, but it also doesn't read any data from the blockchain. Both of these don't cost any gas to call if they're called externally from outside the contract (but they do cost gas if called internally by another function).

### The payable Modifier

>payable functions are part of what makes Solidity and Ethereum so cool — they are a special type of function that can receive Ether.

Let that sink in for a minute. When you call an API function on a normal web server, you can't send US dollars along with your function call — nor can you send Bitcoin.

But in Ethereum, because both the money (Ether), the data (transaction payload), and the contract code itself all live on Ethereum, it's possible for you to call a function and pay money to the contract at the same time.

This allows for some really interesting logic, like requiring a certain payment to the contract in order to execute a function.

##  Withdraws

After you send Ether to a contract, it gets stored in the contract's Ethereum account, and it will be trapped there — unless you add a function to withdraw the Ether from the contract.

You can write a function to withdraw Ether from the contract as follows

 # Tokens on Ethereum


If you've been in the Ethereum space for any amount of time, you've probably heard people talking about tokens — specifically ERC20 tokens.

A token on Ethereum is basically just a smart contract that follows some common rules — namely it implements a standard set of functions that all other token contracts share, such as transferFrom(address _from, address _to, uint256 _tokenId) and balanceOf(address _owner).

Internally the smart contract usually has a mapping, mapping(address => uint256) balances, that keeps track of how much balance each address has.

So basically a token is just a contract that keeps track of who owns how much of that token, and some functions so those users can transfer their tokens to other addresses.

###  ERC20 token

>This means if you build an application that is capable of interacting with one ERC20 token, it's also capable of interacting with any ERC20 token. That way more tokens can easily be added to your app in the future without needing to be custom coded. You could simply plug in the new token contract address, and boom, your app has another token it can use.

## Overflows 

We're going to look at one major security feature you should be aware of when writing smart contracts: Preventing overflows and underflows.

What's an overflow?

Let's say we have a uint8, which can only have 8 bits. That means the largest number we can store is binary 11111111 (or in decimal, 2^8 - 1 = 255).

Take a look at the following code. What is number equal to at the end?

```
uint8 number = 255;
number++;
 ```
 
In this case, we've caused it to overflow — so number is counterintuitively now equal to 0 even though we increased it. (If you add 1 to binary 11111111, it resets back to 00000000, like a clock going from 23:59 to 00:00).

## Underflows

An underflow is similar, where if you subtract 1 from a uint8 that equals 0, it will now equal 255 (because uints are unsigned, and cannot be negative).

While we're not using uint8 here, and it seems unlikely that a uint256 will overflow when incrementing by 1 each time (2^256 is a really big number), it's still good to put protections in our contract so that our DApp never has unexpected behavior in the future.

## Library

A library is a special type of contract in Solidity. One of the things it is useful for is to attach functions to native data types.
>First we have the library keyword — libraries are similar to contracts but with a few differences. For our purposes, libraries allow us to use the using keyword, which automatically tacks on all of the library's methods to another data type:

## assert

assert is similar to require, where it will throw an error if false. ****The difference between assert and require is that require will refund the user the rest of their gas when a function fails, whereas assert will not. So most of the time you want to use require in your code; assert is typically used when something has gone horribly wrong with the code (like a uint overflow).***

## natspec 

The standard in the Solidity community is to use a format called natspec, which looks like this:

***@title and @author are straightforward.

***@notice explains to a user what the contract / function does. @dev is for explaining extra details to developers.

**@param and @return are for describing what each parameter and return value of a function are for.

Note that you don't always have to use all of these tags for every function — all tags are optional. But at the very least, leave a @dev note explaining what each function does.

# WEB3

## What is Web3.js?

Biblioteca de JS que se usa para manejar la blockchain de ethereum se pueden llamar contratos intelegiente y muchas cosas mas como checar balances cuando se llama un smart contract se pasa la siguiente informacion.

>The address of the smart contract
>The function you want to call, and
>The variables you want to pass to that function.

Ethereum nodes only speak a language called JSON-RPC, which isn't very human-readable. A query to tell the node you want to call a function on a contract looks something like this:

```

// Yeah... Good luck writing all your function calls this way!
// Scroll right ==>
{"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"0xb60e8dd61c5d32be8058bb8eb970870f07233155","to":"0xd46e8dd67c5d32be8058bb8eb970870f07244567","gas":"0x76c0","gasPrice":"0x9184e72a000","value":"0x9184e72a","data":"0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"}],"id":1}

```

Luckily, Web3.js hides these nasty queries below the surface, so you only need to interact with a convenient and easily readable JavaScript interface.

Instead of needing to construct the above query, calling a function in your code will look something like this:

```
CryptoZombies.methods.createRandomZombie("Vitalik Nakamoto")
  .send({ from: "0xb60e8dd61c5d32be8058bb8eb970870f07233155", gas: "3000000" })

```

# 2 Metodos para agregar la web3.js 

## Metodo 1 

Instalar el en proyecto de nodejs como lo he venido haciendo

```
// Using NPM
npm install web3
```
##  Web3 Providers
Infura is a service that maintains a set of Ethereum nodes with a caching layer for fast reads, which you can access for free through their API. Using Infura as a provider, you can reliably send and receive messages to/from the Ethereum blockchain without needing to set up and maintain your own node. *** MOLARIS es otra opcion***

```
var web3 = new Web3(new Web3.providers.WebsocketProvider("wss://mainnet.infura.io/ws"));
```

Web3.js will need 2 things to talk to your contract: its address and its ABI.

### ABI 

>The other thing Web3.js will need to talk to your contract is its ABI.

>ABI stands for Application Binary Interface. Basically it's a representation of your contracts' methods in JSON format that tells Web3.js how to format function calls in a way your contract will understand.

>When you compile your contract to deploy to Ethereum (which we'll cover in Lesson 7), the Solidity compiler will give you the ABI, so you'll need to copy and save this in addition to the contract address.

>Since we haven't covered deployment yet, for this lesson we've compiled the ABI for you and put it in a file named cryptozombies_abi.js, stored in variable called cryptoZombiesABI.

>If we include cryptozombies_abi.js in our project, we'll be able to access the CryptoZombies ABI using that variable.

## Instantiating a Web3.js Contract

```
// Instantiate myContract
var myContract = new web3js.eth.Contract(myABI, myContractAddress); //INSTANCIA

```

## Web3 Calling Contract Functions

Our contract is all set up! Now we can use Web3.js to talk to it.

Web3.js has two methods we will use to call functions on our contract: call and send.

### Call
call is used for view and pure functions. It only runs on the local node, and won't create a transaction on the blockchain.
Using Web3.js, you would call a function named myMethod with the parameter 123 as follows:

```
myContract.methods.myMethod(123).call()
```


### Send
send will create a transaction and change data on the blockchain. You'll need to use send for any functions that aren't view or pure.

>Note: sending a transaction will require the user to pay gas, and will pop up their Metamask to prompt them to sign a transaction. When we use Metamask as our web3 provider, this all happens automatically when we call send(), and we don't need to do anything special in our code. Pretty cool!

```
myContract.methods.myMethod(123).send()
```
***Ejemplo***

```
function getZombieDetails(id) {
  return cryptoZombies.methods.zombies(id).call()
}

// Call the function and do something with the result:
getZombieDetails(15)
.then(function(result) {
  console.log("Zombie 15: " + JSON.stringify(result));
});
```

```
      function getZombiesByOwner(owner) {
        return cryptoZombies.methods.getZombiesByOwner(owner).call
      }
      
```

*** Explicacion *** cryptoZombies es la instancia que apunta a nuestro contrato methods es de web3 y getZombiesByOwner(owner) es el nombre
de nuestra funcion dentro del contrato la cual tenia un parametro address _owner y finalmente call llama a dicha funcion comon o se genera ninguna
transaccion no se cobra gas y no se usa send.


## Metamask & Accounts

>MetaMask allows the user to manage multiple accounts in their extension.
We can see which account is currently active on the injected web3 variable via:

```
var userAccount = web3.eth.accounts[0]
```
*** Ejemplo de llamar a send***

```
function feedOnKitty(zombieId, kittyId) {
       
        $("#txStatus").text("Eating a kitty. This may take a while...");
       
        return cryptoZombies.methods.feedOnKitty(zombieId, kittyId)
        .send({ from: userAccount })
        .on("receipt", function(receipt) {
          $("#txStatus").text("Ate a kitty and spawned a new Zombie!");
         
          getZombiesByOwner(userAccount).then(displayZombies);
        })
        .on("error", function(error) {
         
          $("#txStatus").text(error);
        });
      }
```
***NOTA***
Note: You can optionally specify gas and gasPrice when you call send, e.g. .send({ from: userAccount, gas: 3000000 }). If you don't specify this, MetaMask will let the user choose these values

## Tuplas en Solidity

A tuple is a way in Solidity to create a syntactic grouping of expressions

***Ejemplo***

```
function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
```
Para nosotros guardar todos los valores que regresa 

```
 (uint80 roundId, int answer, uint startedAt, uint updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();
 
```

Additionally, if there are variables that we are not going to use, it's often best practice to leave them as blanks, like so

```
 (,int price,,,) = priceFeed.latestRoundData();
 ```
 
## Self-destruct

The only possibility that code is removed from the blockchain is when a contract at that address performs the selfdestruct operation. The remaining Ether stored at that address is sent to a designated target and then the storage and code is removed from the state.


## Calling Payable Functions

### Convertir ether to wei 

```
// This will convert 1 ETH to Wei
web3js.utils.toWei("1");

```

### send to a payable function 

```
cryptoZombies.methods.levelUp(zombieId)
.send({ from: userAccount, value: web3js.utils.toWei("0.001", "ether") })
```

## Subscribing to Events

In Web3.js, you can subscribe to an event so your web3 provider triggers some logic in your code every time it fires:


```
cryptoZombies.events.NewZombie()
.on("data", function(event) {
  let zombie = event.returnValues;
  // We can access this event's 3 return values on the `event.returnValues` object:
  console.log("A new zombie was born!", zombie.zombieId, zombie.name, zombie.dna);
}).on("error", console.error);
``` 
# Chainlink Data Feeds

So what we want to do, is get our data from both a decentralized oracle network (DON) and decentralized data sources.

>Chainlink is a framework for decentralized oracle networks (DONs), and is a way to get data in from multiple sources across multiple oracles. This DON aggregates data in a decentralized manner and places it on the blockchain in a smart contract (often referred to as a "price reference feed" or "data feed") for us to read from. So all we have to do, is read from a contract that the Chainlink network is constantly updating for us!

>https://data.chain.link/

### Para importar la interface de chainlink


```
pragma solidity ^0.6.7;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


contract PriceConsumerV3 {

}
```
## Tutorial de Chainlink basico( Tarea )

>https://docs.chain.link/docs/conceptual-overview/


## Truffle

Truffle es un conjunto de herramientas de programación orientado a smart contracts (contratos inteligentes) para desarrollar aplicaciones sostenibles y profesionales sobre la blockchain utilizando para ello la Máquina Virtual de Ethereum (EVM), así como realizar las distintas pruebas en un entorno de desarrollo integrado amigable para el desarrollador.

## Mocha
In this chapter, I’ll present Mocha, a JavaScript unit testing framework that will allow you to easily automate unit tests for your contracts. In the next chapter, you’ll learn how to set up Truffle, through which you’ll automate build and deployment of your Dapps. Finally, you’ll also incorporate Mocha tests within Truffle, making it your fully integrated development environment.

##  Ganache

You can do so by using a tool called Ganache, which sets up a local Ethereum network.

Every time Ganache starts, it creates 10 test accounts and gives them 100 Ethers to make testing easier. Since Ganache and Truffle are tightly integrated we can access these accounts through the accounts array we've mentioned in the previous chapter.

But using accounts[0] and accounts[1] would not make our tests read well, right?

### Build Artifacts

Every time you compile a smart contract, the Solidity compiler generates a JSON file (referred to as build artifacts) which contains the binary representation of that contract and saves it in the build/contracts folder.

Next, when you run a migration, Truffle updates this file with the information related to that network.

The first thing you'll need to do every time you start writing a new test suite is to load the build artifacts of the contract you want to interact with. This way, Truffle will know how to format our function calls in a way the contract will understand.

***Ejemplo***

>const MyAwesomeContract = artifacts.require(“MyAwesomeContract”);

The function returns something called a contract abstraction. In a nutshell, a contract abstraction hides the complexity of interacting with Ethereum and provides a convenient JavaScript interface to our Solidity smart contract

# Call contract functions

Para llamar a las funciones de un contrato se tiene que instanciasr ejemplo

```
async function getOracleContract (web3js) {
  const networkId = await web3js.eth.net.getId()
  return new web3js.eth.Contract(OracleJSON.abi, OracleJSON.networks[networkId].address)
}
```

>Sweet, you've instantiated your contract🙌🏻! Now you can call its functions


## Capturar eventos

Para capturar eventos se hace asi 

```
myContract.events.EventName(async (err, event) => {
  if (err) {
    console.error('Error on event', err)
    return
  }
  // Do something
})
```
## zkSync

una solución de escalado de capa 2 sin aplicaciones específicas y sin confianza para las transacciones de Ethereum. Es un remedio para el creciente problema de las transacciones poco fiables y costosas en la cadena de bloques Ethereum debido a las altísimas tarifas de gas

Both Ethereum and zkSync “speak” a language called JSON-RPC that is not human-readable. Luckily, they provide libraries that hide all the complexity below the surface, so you only need to know a bit of JavaScript.

> You  have to create a provider that allows your application to communicate with zkSync. 

### The Ethers Project (ethers)

A complete Ethereum wallet implementation and utilities in JavaScript (and TypeScript).

>npm i ethers

### JavaScript SDK for zkSync (zksync)

zkSync is a scaling and privacy engine for Ethereum. Its current functionality scope includes low gas transfers of ETH and ERC20 tokens in the Ethereum network.

This document is a description of the JS library that can be used to interact with zkSync.

>npm i zksync

zkSync makes use of something called ***zk-SNARKs*** which stands for... "Zero-knowledge succinct non-interactive arguments of knowledge".

## Instantiate a zkSync wallet 

Cada billetera zkSync tiene una dirección Ethereum asociada, y el usuario que posee una cuenta Ethereum posee la cuenta zkSync correspondiente

>The zksync.Wallet wallet class wraps ethers.Signer and zksync.Signer, allowing you to use it for transferring assets between chains (which requires you to sign transactions on Ethereum) and also for transferring assets between zkSync accounts (which requires you to sign transactions on zkSync). Sweet!


# Deploy

Cuando se va desplegar un contrato y se maneja herencia se tiene que deplegar el contrato hijo ya que al hacer import ya se copia en el codigo aunque
no nos demos cuenta checa la explicacion de import abajo

# Import all

## import "./contrato.sol

Lo que hace esta linea literalmente es copiar y pegar el contrato arriba del otro por eso es que cuanod usamos "is" no hay problema.
***Las interfaces compilan hasta un abi ABI*** 

## import "@openzeppelin/contracts/token/ERC20/IERC20.sol" WHAT the @ Does? OJO IMPORTA las Interfaces para poder usarlos!

FUENTE: https://stackoverflow.com/questions/71532782/what-are-the-rules-syntax-for-importing-from-github-repo-to-solidity-contract

Your snippet shows a direct import that searches for the file in your local directories based on the compiler config.

One of the default sources is the node_modules directory where NPM packages are installed.

The @ symbol is just a prefix of NPM scoped packages, allowing to group more packages into the same namespace (in this case @openzeppelin/<package_name>).

To import a contract from GitHub, you can just pass its full URL:

>import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

gain because of the default config, the compiler downloads the remote file from GitHub to a local temp directory, and imports its contents before compiling.

# Deploy and interact with other contracts

## Creating a contract factory to clone Solidity smart contracts

>https://blog.logrocket.com/creating-contract-factory-clone-solidity-smart-contracts/

## Interface vs Deploy a contract from other contract

Para desplegar un contrato desde otro se tiene que tener toda su funcionalidad importada. Para usar un contrato desde otro contrato se tiene que 
tener su interfaz.

# Transaccion VS Call

## Call
A call is a local invocation of a contract function that does not broadcast or publish anything on the blockchain.

It is a read-only operation and will not consume any Ether. It simulates what would happen in a transaction, but discards all the state changes when it is done.

It is synchronous and the return value of the contract function is returned immediately.

Its web3.js API is web3.eth.call and is what's used for Solidity view, pure, constant functions.

Its underlying JSON-RPC is eth_call

## Transaction
A transaction is broadcasted to the network, processed by miners, and if valid, is published on the blockchain.

It is a write-operation that will affect other accounts, update the state of the blockchain, and consume Ether (unless a miner accepts it with a gas price of zero).

It is asynchronous, because it is possible that no miners will include the transaction in a block (for example, the gas price for the transaction may be too low). Since it is asynchronous, the immediate return value of a transaction is always the transaction's hash. To get the "return value" of a transaction to a function, Events need to be used (unless it's Case4 discussed below). For ethers.js an example: listening to contract events using ethers.js?

Its web3.js API is web3.eth.sendTransaction and is used if a Solidity function is not marked constant.

Its underlying JSON-RPC is eth_sendTransaction

sendTransaction will be used when a verb is needed, since it is clearer than simply transaction.

# IERC20.sol vs ERC20.sol

What is the IERC20.sol contract used for if we have the ERC20.sol contract?

> The IERC20.sol is a interface contract, all in this file are standard as defined in the EIP. As for ERC20.sol, it is an implementation of the IERC20.sol, you can define all your token logic in it. 

# string vs bytes

String se usa para cadenas donde no se este seguro cuanto mide. Bytes se usa porque es mas barato ademas se sabe a cuanto esta topado osea lo que mide.
# ^ before version what it means

> pragma solidity ^0.4.21. What does the caret really mean? The short answer is the caret or top hat (^) means the code will be compatible with compiler version from 0.4. 21 to 0.5
