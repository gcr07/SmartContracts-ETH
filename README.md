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
