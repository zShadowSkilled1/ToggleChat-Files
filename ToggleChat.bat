@echo off
title ToggleChait - Machine Learning ChatBot
setlocal enabledelayedexpansion

REM Get the directory of the batch script
set "scriptDir=%~dp0"

REM Define the relative paths for folders and files
set "questionsFile=%scriptDir%Config\Questions\LearnedQuestions.txt"
set "configFolder=%scriptDir%Config\Questions"

REM Create the necessary folders if they don't exist
if not exist "%configFolder%" (
    mkdir "%configFolder%"
)

REM Create the learned questions file if it doesn't exist
if not exist "%questionsFile%" (
    echo. > "%questionsFile%"
)

:loading
echo Loading...
ping -n 2 127.0.0.1 > nul
cls

:main
set "input="
set /p "input=You: "
echo.

REM Trim leading and trailing spaces from the input
set "input=%input: =%"
set "input=%input:"=%"

REM Convert the input to lowercase for case-insensitive matching
set "input=!input:HI=hi!"
set "input=!input:HELLO=hi!"
set "input=!input:Hi=hi!"
set "input=!input:Hello=hi!"

REM Check if the input matches any learned question
set "found="
for /f "tokens=1,* delims=: " %%a in ('type "%questionsFile%"') do (
    set "question=%%a"
    set "answer=%%b"
    if /i "!question!"=="!input!" (
        set "found=1"
        echo Chatbot: !answer!
        echo.
        goto :main
    )
)

REM If the question is new, ask the user to provide an answer
echo Chatbot: Can you teach me a good answer to this ?
echo.
set "answer="
set /p "answer=You: "

REM Display loading screen while saving the answer
echo Chatbot: Saving the answer...
echo Please wait...

REM Save the answer to the questions file
echo !input!:!answer! >> "%questionsFile%"

REM Delay to simulate saving process (replace with actual saving process if needed)
ping -n 2 127.0.0.1 > nul

REM Clear loading screen
REM cls

REM Display success message
echo.
echo Answer saved successfully!
echo Chatbot: Thank you for teaching me!
echo.

goto :main