# SmartContracts-ETH

Este repositorio son las notas de lo que voy aprendiendo si ves algo mal levanta un issue y lo compongo.

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
