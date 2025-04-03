# Architecture

![Architecture Diagram](https://github.com/trannam02/TKVM_Assignment/blob/main/assets/images/architecture.png?raw=true)

## How to run

1.  Change directory to the `assembler` folder:

    ```bash

    cd assembler
    ```
2.  Run the `make` command to build your program:

    ```bash

    make
    ```
3.  Change directory to the `build` folder and assemble your code in the `code.asm` file:

    ```bash
    
    ./cpu.exe ../code.asm
    ```

## Example code in code.asm

```assembly
lda 0x1A            ; load value at 0x1A address to Accumulator Register
jmp 0x04            ; jump to command at address 0x04
hlt                 ; stop program
skz                 ; skip if previous ALU's result is zero
add 0x1e            ; add value in address 0x1E with value in Accumulator Register
add 0x1d            ; add value in address 0x1E with value in Accumulator Register
```