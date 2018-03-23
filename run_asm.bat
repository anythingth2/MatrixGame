@echo off

del GAME.OBJ
del GAME.COM
del GAME.MAP

tasm GAME.asm

if EXIST "GAME.OBJ"  tlink GAME.OBJ /t
if EXIST "GAME.COM"  cls  
if EXIST "GAME.COM" GAME.COM
echo.
