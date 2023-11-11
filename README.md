# Programming in MASM x86

This repository is dedicated to 16bit assembly language programming. The assembly language used is based on Intel x86 architecture for 16bit hardware systems and all assembly files have a *.asm* file extension. Since these systems are not easily available or supported by modern hardware, you have to use an emulator to run them. The two most common emulators are *emu8086* and *DOSBOX*.

## 1. emu8086

This is prehaps the simplest way to run these programs but *emu8086* is a proprietary emulator and is only supported on *Windows*-based operating systems. Running the software is really easy as explained below:

* Start *emu8086* and select a new and empty workspace.

* Copy the source code and paste it into the emulator.

* Press the **emulate** button at the top with green play icon to run the code.

The *emu8086* offers some excellent assisting features for assembly programming beginners such as observing real-time data inside *registers*, *variables*, *system flags* and *stack*. It also has a dedicated ASCII-table which shows both decimal and hexadecimal ASCII values.

## 2. DOSBOX

This is an open-source, cross-platform emulator which is true to the original 16bit DOS machines. It uses command-line based instructions to execute the programs. Since it is a DOS emulator, it requires DOS based instructions to operate. These instructions are still used today in the *Windows' **command-prompt***.

To run these source code on the *DOSBOX* you will need to include **MASM.EXE** and **LINK.EXE** files to your directory. These files are also present in this repo in the *DOSBOX Files* directory. Also, your source code needs to be in the same directory as well in order to allow *DOSBOX* to run the file. Steps and commands to run the code files are explained below:

The following instructions assume that the directory (folder) containing these files (*MASM*, *LINK* and assembly programs) is named **my programs** and is located in the **C** drive and the program file is titled **helloWorld.asm**. If the file name or directory name has spaces in it then put it in quotation marks like *"my programs"*. All of these DOS instructions mentioned below are case-insensitive.

1. Start the *DOSBOX* and use the command **mount C C:\"my programs"** to load the directory in the DOS.

2. Use the command **C:** to change the active directory to the location where all (MASM, LINK and source program) code files are located. Typing "my program" is not necessary, as this instruction loads the C drive and the previously specified drive into the DOS.

3. Type **masm helloWorld.asm** and press *Enter*-key three times. This will create an object file with *.obj* extension and will also notify for any errors/warnings in the code. Errors are fatal and the assembly file will fail to give output. Warnings are violations of proper DOS assembly code but **the program will run and give output**.

4. Now type **link helloWorld.obj** and press *Enter*-key three times. This will create an EXE file with *.exe* extension from the object file created in the previous step. Both EXE and OBJ files have same name as the source ASM file (helloWorld).

5. Finally type **helloWorld.exe** and press *Enter*-key to run the program. The output will be displayed in the next line.

6. If the code has fatal errors and fails to run then DOS will prompt you with the line number(s) containing the error. Type **edit helloWorld.asm** to open a code editor within DOSBOX to edit the source assembly file. Notice the *.asm* extension in this command because you are editing the original assembly file. After editing, exit the code editor and repeat the process from step 3.

The *DOSBOX* can also be used as a complete DOS replica and can even be used to run retro DOS-based video games. Check out [this video](https://www.youtube.com/watch?v=cH3nacbgx_o "DOSBOX as a retro video game emulator") for more info.
