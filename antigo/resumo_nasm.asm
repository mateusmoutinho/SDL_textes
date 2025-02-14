; Resumo das instruções do nasm
;-------------------------
; Um programa em assembly usando o nasm tem 3 seções onde se define dados e variaives 
; além do proprio codigo do programa, que são
;
; BITS 32 ou BITS 64  --> define se instruções de 32 e 64 bits
;
; section .data  e segment .data  ; inialização de constantes que já recebem um valor
;
; section .bss  segment .bss  ; declaração de variavies, que não devem receber nenhum valor de inicio
				 ; mas que recebem um valor no codigo, que fica na seção .text
				 
;section .text  ;  segment .text onde de fato vai o codigo do programa e instruções
;
;   deve começar com a declaração 
;	global _start ; que diz o inicio do programa  ao linker, com se fosse o main
;	
; _start:  ; incio do programa em sí

; trexo de codigo etc.......


; programa esqueleto em assembly usando o nasm
-------------------------------------------------
section .data
; constantes

section .bss
; variaives

section .text
   global _start ; declaração incio do programa
   
 _start:  ; inicio de fato do programa

; codigo
;-----------------------


 ;---fim do programa--------------
    mov eax , 1
    int 80h	
 -------------------------------------------------------
 

;Além disso temos o stack, uma area da memoria propria para inseir argumentos de funções que são chamadas
;-----------------------------------------------------

; para compilar e linkar um programa devemos primerio gerar o arquivo objeto
; nasm -f elf32 se for 32 bits ou elf64 se tiver instruções 64 bits , use a opção nasm -hf
; $     nasm exemplo.asm -f elf32 -o exemplo 
;
; AGORA  para gerar o executavel devemos usar o linker.
;
; ld exemplo.o -o ola 


;-----Sintaxe-do-NASM----------------------------

; sintaxe básica do nasm 
	
; rotulo  memonoconico , operacao  ; comentario
; a versão obrigatorio disso seria algo como :
;			mov eax , 1 ; move valor 1 para registador EAX de 32 bits

;  tabela sintaxe de operações
;     Sintaxe |  Sifificado 
; |----------------------------|---------------
; |     [ AFA64]               |  Colchetes significam -> endereço de memoria          |
; | BYTE, WORD, DWORD, QWORD   |  Prefixo dos tipos de dados as vezes é obrigatorio
; | <Rotulo_ou_nomeVarivael>   |  Endereço de , mesma coisa do & em C, não mais que uma instrução de memoria por linha é permitda
; |           $                |  Endereço da instrução atual
; | %define nome_macro         | define um macro, exatamente a mesma coisa que em C #define
; | %undef  nome_macro         | cancela a definição do marcro, como em C #undef
; |  extern nome_simbolo       | simbolos que estão definidos fora do programa em ASM, podendo ser ligados com o ld 
; TIMES <n> <Ação> <n> vezes, do <ação> (veja também %rep)
; |  %include " funções.asm"   |  Faz a inclusão de funções e codigos definidos em outro programa assembly
; para mais informações veja a documentação oficial do nasm : https://www.csee.umbc.edu/~chang/cs313.f04/nasmdoc/nasmdoc.pdf

;------Byte,Word, Double_Word,-Quad_Word--Sifnificados----------------------------------

; um Byte tem 8 bits
; um Word tem 16 bits, ou seja 2 bytes
; um Double-Word tem 32 bits ou seja 4 bytes
; um Quad_Word tem 64 bits ou seja 8 bytes

Faixas de valores

-----------------------------------------------------------|
 Tipo         |   Limite Positivo   | Limite Negativo      |        | 
--------------|---------------------|----------------------|
 Byte         |   07fh              | 80h                  |
 Word         |   07fffh            | 8000h                |
 Double Word  |  07fffffffh         | 80000000h            |
 Quad   Word  |  07fffffffffffffffh | 80000000000000000h   |
-----------------------------------------------------------
 
-----------------------------------------------------------|
Tipo de variavel | tamanho em bits                         | 
-----------------------------------------------------------|
  Byte           |     8                                   | 
  Word           |     16                                  |
  Double Word    |     32                                  |
  Quad   Word    |     64                                  |
-----------------------------------------------------------



;---Secçao Data e Bss definindo variaives-e-constantes-----------------------------------
; DATA
;        voçe pode usar DQ para definir um quad-word
;        DD para definir um double-word
;		 DW para definir um word
;        DB para definir um byte

;****Exemplo******
; minhavar:      dd  65  ; minha var recebe 65 de valor
; minhastring:   db "Ola mundo assembly" , 13,10,0 ; "Ola mundo assembly"\r\n\0"

; BSS
  ;   Reserva   RESQ  - Quad Words
  ;   Reserva   RESD  - Double Word 
  ;   Reserva   RESW  - Word
  ;   Reserva   RESB  - Byte

;****Exemplo*******
;	meu_int:		 resd   1   ; recebe um  doubre word  , 2 bytes

;	minhastr:        resb  512  ; recebe 512 bytes para uma string
;Resumo
; Normalmente, as coisas que queremos inicialmente atribuir valores a (ou seja, "Hello World!", 65, etc.)
; são definidas na seção de dados, enquanto coisas que não sabemos o valor de, no entanto, definimos no BSS seção.
; além disso podemos incializar com valores da tabela ANSII
;
;Predefinições de tamanho de operando - quando são necessárias?
;Os prefixos de tamanho de operando são necessários quando os tamanhos de operando não podem ser inferidos 
;(isto é, a instrução PUSH).
;Mas os prefixos de tamanho de operando podem ser usados em outras situações, também, embora não sejam necessários



;/////////////////////////TABELAS DE OPERAÇÔES/////////////////////////////////////////
;     Memoconico        |   Descrição                            |     Exemplo                     |     Sintaxe          |
; |---------------------|----------------------------------------|---------------------------------|----------------------| 
; |     MOV             | Move um valor para outro local         | operador1 = operador2           |mov destino , origem  |
; |     PUSH			| Empurra um valor para o topo da pilha  | ESP =ESP-4;[ESP]=OPerando1      |
; |     POP				| Tira um valor do topo da pilha	     |Operador1=[ESP];ESP =  +4        |  
; |     CALL            | Chama um trexo de codigo				 |PUSH EIP; EIP= Operando;         |  call rotulo:
; |     RET             | Retorna um chamado                     | POP EIP                         |
; |     JMP             | pula para uma parte do codigo          | EIP = Operando1                 |
; |     AND             | Operador  E bit a bit                  |Operandor = operador1 & operador2|
; |     OR              | Operador OU bit a bit                  |Operador = Operador1 | Operador2 |
; |     XOR             | Operador OU exclusivo bit a bit        |Operador = Operador1 ^ Operador2 |
; |     NOT             | Operador NOT bit a bit                 |Operador != Operador1            | 
; |     ADD             | Soma matematica Decimal                |Operador = Operador1 + Operador2 |
; |     SUB             | Subratação matematica  Decimal         |Operador = Operador1 - Operador2 |
; |     MUL             | Mulplicador matematica Decimal         |Acumul = Acumul * Operandor      |
; |     DIV             | Divisor matametico decimal             |Acumul = Acumul / Operandor      |
; |     IMUL            | Multiplicador matematico com sinal     |Acumul = Acumul * Operandor      |
; |     IDIV            | Divisor matametico decimal com sinal   |Acumul = Acumul / Operandor      |
; |     INC             | Incremento mais um                     | Acumulador++ ; Acumulador +=1   |
; |     DEC				| descrementa menos 1                    | Acumulador--; Acumulador -=1    |  
; |     SHR             | desolcamento a direita >> multi por 2  | operador valor a direta         |        
; |     SHL             | Deslocamento a esquerda << divide por 2| operador valor a esquerda       |

;-----Registradores-----------------------------------------


Existem pelo menos  10 Registradores de 32 bits,  e 6 registradores de 16 bits.
Que estão divididos em 3 categorias, onde cada um também tem 3 subcategorias

--- Registradores de Proposito Geral
	---+ Registrador de Dados
	---+ Registrador de Ponteiro
	---+ Registrador de Indice
	
--- Registrador de Controle
	---+ Registrador de Dados
	---+ Registrador de Ponteiro
	---+ Registrador de Indice 

--- Registrador de Segmento
	---+ Registrador de Dados
	---+ Registrador de Ponteiro
	---+ Registrador de Indice 
----------------------------------------

Registradores de armazenamento e operações matematicas 32 bits 
 EAX , EBX , ECX, EDX

Registrador de 16 bits
AX , BX , CX , DX

Registrador de 8 bits
AH , AL, BH , CH , CL, DH, DL

   32                |     16    |     8      | proposito
  --------------------------------------------|----------------
 |   EAX             |    AH     |   AL | AX  |  Acumulador  
 |   EBX             |    BH     |   BL | BX  |  Base
 |   ECX             |    CH     |   CL | CX  |  Contador
 |   EDX             |    DH     |   DL | DX  |  Dados
----------------------------------------------------------------
 AX  Instruções de entrada e saida aritimetica
 BX  endereçamento indexado
 CX  Registrador de contador de loops
 DX  Registrador de dados, operações de entrada e saida usando o AX para operações aritimeticas
 
 
 ---Registrador de Ponteiros ---
 Os registros de ponteiro são registos EIP, ESP e EBP de 32 bits 
 e posições IP correspondentes de 16 bits, SP e BP. Existem três categorias de registradores de ponteiros 
 
 
		32 		|		16
 ---------------|------------------|
        EIP     |   IP usa com CS  |  Ponteiro de instrução
        ESP     |     SP           |  Ponteiro de Pilha
		EBP     |     BP           |  Ponteiro Base
 ----------------------------------|  

---Registador de Indice---
Fonte original SI - usado para indice fonte de uma operação com string
Index de Destino - usado como indie de destino de uma string

      32               16     
----------------|-------------------|
      ESI       |     SI            | Origem do destino 
      EDI       |     DI            | Destino do index
------------------------------------|


-----Registador  de controle-----

Overflow Flag (OF) 
- Indica o overflow de um bit de alta ordem 
(bit mais à esquerda) de dados 
após uma operação aritmética assinada.


Sinalizador de direção (DF) 
- determina a direção esquerda ou direita para mover
 ou comparar dados de seqüência de caracteres. Quando o valor de DF é 0,
 a operação de seqüência de caracteres leva a direção da esquerda para a 
 direita e quando o valor é definido como 1, a operação de seqüência leva
 direção da direita para a esquerda.
 
 
Interrupt Flag (IF) - Determina se as interrupções externas como entrada de teclado,
 etc., devem ser ignoradas ou processadas. Desativa a interrupção externa quando o valor é 0 
 e habilita interrupções quando definido como 1.
 
 
Trap Flag (TF) - Permite definir a operação do processador no modo de um único passo.
 O programa DEBUG que usamos define a bandeira de armadilha, para que possamos 
 passar pela execução uma instrução de cada vez.
 
Sign Flag (SF) - Mostra o sinal do resultado de uma operação aritmética.
Este sinalizador é definido de acordo com o sinal de um item de dados após
a operação aritmética. O sinal é indicado pela ordem superior do bit mais à esquerda. 
Um resultado positivo limpa o valor de SF para 0 eo resultado negativo o define como 1.

Zero Flag (ZF) - Indica o resultado de uma operação aritmética ou de comparação.
Um resultado diferente de zero limpa o sinalizador zero para 0 e um resultado zero define-o como 1.

Auxiliary Carry Flag (AF) - Contém o carry do bit 3 ao bit 4 após uma operação aritmética
Usado para aritmética especializada. O AF é ajustado quando uma operação aritmética de 1 byte 
faz com que o carry do bit 3 entre no bit 4.

Parity Flag (PF) - Indica o número total de 1-bits no resultado obtido de uma operação aritmética.
Um número par de 1-bits limpa a bandeira de paridade para 0 e um número ímpar de 1-bits define o 
sinalizador de paridade como 1.

Carry Flag (CF) - Contém o carregamento de 0 ou 1 a partir de um bit de alta ordem 
(mais à esquerda) após uma operação aritmética. Também armazena o conteúdo do último bit
 de uma operação de deslocamento ou rotação.
 
 

;------------------Arrays------------------------
;  - Array: sequência de bytes ou words consecutivos na memória
; armazenar dados relacionados
; armazenar caracteres ASCII organizados (ex: texto, sequencia de valores)
; 
; 
;
;
;
 
 ;---------Modelo de Segmento-----------------
   Modelos de memória
   O tamanho que os segmentos de código e de dados devem ter é especificado
   pelo modelo de memória por meio da diretiva

    segment: .modelo
   
   já de inico do programa, antes de qualquer declaração.
   Ao menos que haja muitas linhas de programa (muito código) ou muitos
   dados, o modelo apropriado é o SMALL.
· A diretiva segment .model  deve vir antes de qualquer definição de segmento do programa.
   
----------------------------------------
 Modelo       Descrição
-----------------------------------
  small    | Código em 1 segmento;
           | Dados em 1 segmento
-----------------------------------
  medium   | Código em mais de 1 segmento;
           | Dados em 1 segmento
-----------------------------------
  compact  | Código em 1 segmento;
           | Dados em mais de 1 segmento
------------------------------------
  large    | Código em mais de 1 segmento;
           | Dados em mais de 1 segmento;
		   | Nenhum array maior que 64 Kbytes
---------------------------------------------
  huge     |Código em mais de 1 segmento;
           |Dados em mais de 1 segmento;
           |Arrays maiores que 64 Kbytes       
-------------------------------------------

exemplo:

--------exemplo01.asm-------------------------------
 
 segment  .small  ;modelo se segmento da memoria
 
 section .data ; constantes
 
 section .bss  ; variavies
 
 section .text ; codigo do programa
 
  global _start ; declaração do main
  
  _start:  ; incio do programa
 ;-----incio do programa------------
 
 
 ;---fim do programa--------------
    mov eax , 1
    int 80h	
 -------------------------------------------------------
 
