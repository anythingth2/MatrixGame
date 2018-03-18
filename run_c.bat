@echo off
del matrixGame.exe
g++ matrixGame.c -o matrixGame.exe

if EXIST matrixGame.exe (
    cls
    matrixGame.exe
)