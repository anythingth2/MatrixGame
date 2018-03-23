#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>
#include <windows.h>

int WHITE = 0xF;
int GRAY = 0x8;
int GREEN = 0xA;
int DARK_GREEN = 0x2;
int BLACK = 0x0;

int matrixY[80];
const int numMatrix = 80;
const int matrixLength = 7;

const int START_MATRIX_Y = -150;

const int WINDOW_TOP = 0;
const int WINDOW_LEFT = 20;
const int WINDOW_RIGHT = 79;
const int WINDOW_BOTTOM = 20;

const int numBullet = 180;
int bulletX[numBullet];
int bulletY[numBullet];
int currentBullet = 0;

int shipX = 0;

int life = 9;
int score = 0;

const int DELAY_MATRIX = 10;
int count_delay_matrix = 0;

void gotoxy(int x, int y);
void setTextColor(int color);
void printCharAt(int x, int y);
void clearCharAt(int x, int y);
int randomNumber(int from, int to);

int matrixColorCode[] = {
    WHITE,
    GRAY,
    GREEN,
    DARK_GREEN,
    GREEN,
    GREEN,
    BLACK,
    BLACK,
    DARK_GREEN,
    GREEN,
    DARK_GREEN,
    GREEN,
    DARK_GREEN,
    DARK_GREEN,
    BLACK};


void clearFlowMatrix(int x)
{
       for (int i = 0; i < 25; i++)
    {
        setTextColor(BLACK);
        printCharAt(x, i);
    }
}
void printFlowMatrix(int x, int matrixY)
{
    for (int i = 0; i < matrixLength; i++)
    {
        int y = matrixY - i;
        if (y >= 0 && y < 25)
        {
            setTextColor(matrixColorCode[i]);
            printCharAt(x, matrixY - i);
        }
    }
}

void refreshLife()
{
    gotoxy(10,0);
    setTextColor(WHITE);
    printf("%d",life);
}
void onGotDamaged()
{
    life--;
    refreshLife();
}

void onGetScore() {}
void checkMatrixEnded(int _x, int *_matrixY)
{
    if ((*_matrixY) == WINDOW_BOTTOM)
    {
        onGotDamaged();
        *_matrixY = START_MATRIX_Y;
        clearFlowMatrix(_x);

    }
}
void checkBulletCollisMatrix()
{
    for (int x = 0; x < numMatrix; x++)
    {
        for (int y = 0; y < numBullet; y++)
        {
            if (bulletX[y] == x)
            {
                
                if (matrixY[x]>=1){
                    if (bulletY[y]-1 == matrixY[x])
                    {
                        onGetScore();
                        refreshLife();
                        matrixY[x] = START_MATRIX_Y;
                        clearFlowMatrix(x);
                    }
                }
            }
        }
    }
}

void updateMatrix()
{
    for (int x = WINDOW_LEFT; x < WINDOW_RIGHT; x++)
    {
        matrixY[x]++;
        checkMatrixEnded(x, &matrixY[x]);

        printFlowMatrix(x, matrixY[x]);
    }
}
void initMatrix()
{
    for (int i = WINDOW_LEFT; i < WINDOW_RIGHT; i++)
    {
        matrixY[i] = randomNumber(START_MATRIX_Y, 0);
    }
}

void printBullet(int x, int y)
{

    if (y > WINDOW_TOP - 1)
    {
        gotoxy(x, y);
        setTextColor(WHITE);
        printf("%c", 'B');

        gotoxy(x, y + 1);
        setTextColor(BLACK);
        printf("%c", 'B');
    }
    else if (y == WINDOW_TOP - 1)
    {
        gotoxy(x, y + 1);
        setTextColor(BLACK);
        printf("%c", 'B');
    }
}
void updateBullet()
{
    for (int i = 0; i < numBullet; i++)
    {

        bulletY[i]--;

        printBullet(bulletX[i], bulletY[i]);
    }
}

void shootBullet()
{
    currentBullet = (currentBullet + 1) % numBullet;
    bulletX[currentBullet] = shipX;
    bulletY[currentBullet] = WINDOW_BOTTOM;
}

void displayShip()
{
    setTextColor(GREEN);
    printCharAt(shipX, WINDOW_BOTTOM);
}

void clearShip()
{
    setTextColor(BLACK);
    printCharAt(shipX, WINDOW_BOTTOM);
}
void onControl()
{
    clearShip();
    char c = getch();
    if (c == 'a')
    {

        if (shipX > WINDOW_LEFT)
            shipX--;
    }
    else if (c == 'd')
    {

        if (shipX < WINDOW_RIGHT)
            shipX++;
    }
    else if (c == 'w')
    {
        setTextColor(WHITE);

        shootBullet();
    }

    displayShip();
}
int main()
{
    system("cls");
    refreshLife();
    initMatrix();
    for (;;)
    {
        count_delay_matrix++;
        if (count_delay_matrix == DELAY_MATRIX)
        {
            updateMatrix();
            updateBullet();
            checkBulletCollisMatrix();
            count_delay_matrix = 0;
        }

        
        if (kbhit())
            onControl();

        Sleep(20);
    }

    return 0;
}


void gotoxy(int x, int y)
{
    COORD coord;
    coord.X = x;
    coord.Y = y;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
}

void setTextColor(int color)
{
    HANDLE hConsole;
    hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

    SetConsoleTextAttribute(hConsole, color);
}
void printCharAt(int x, int y)
{
    gotoxy(x, y);
    printf("%c", randomNumber(33, 126));
}

int randomNumber(int from, int to)
{
    return rand() % (to - from) + from;
}