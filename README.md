## About

This is an alternative way of assembling programs for the [PLC-14500](https://github.com/nicolacimmino/PLC-14500) trainer board 
that takes advantage  of the flexibility of the [cc65](https://cc65.github.io/) assembler.

The main advantage of this approach is that you get the full flexibility of cc65, with macros, repeat etc. I have
decided to take this out of the main PLC14500 repository as I found it confused people to have two separate assemblers.
The one shipped by the PLC14500 project is a simpler approach to get started as it doesn't require additional dependencies.

The magic here is done mostly in `plc14500-nano-*.inc`. This file is heavily based on work by Yaroslav Veremenko
([original](https://github.com/veremenko-y/mc14500-programs/blob/main/sbc1/system.inc)).  I modified it mostly to adapt to the board different I/O mapping and
opcode/param order.

## Example

An exceprt, out of context, from one of the examples you can find in this repo, showing how you can define labels and repeat blocks of code with an index.
````asm
.include "../plc14500-nano-b.inc"

GAME_BIT0=SPR1  ; Game bit 0

.segment "CODE"

    IEN  IN6
    OEN  IN6

.repeat 5,I
    LD   GAME_BIT0+I
    STO  GAME_LED0+I
.endrepeat

````


## Assemble

`build.cmd` contains all you need to assemble a `.asm` file. Just invoke it with:

`build.cmd test.asm`

and it will produce a `.bin` file in the `.build` folder.

You need to make sure you have downloaded and installed cc65 ( https://cc65.github.io/ ) and that its `bin` folder has
been added to the `PATH`.

Also, as expected, the syntax of the assembly code will be slightly different than the one from the examples provided
in the assembler folder. I have included here `examples\example6.asm` to get you started, I'll port also the others
in due time if this seems to pan out well.
