@echo off

REM Displaying a personalized welcome message to the user
echo.
echo   Welcome to Wi-Fi Password Retrieval Tool!
echo   ========================================
echo   We're glad to have you here. Sit back, relax,
echo   and let's retrieve those Wi-Fi passwords!
echo.

setlocal enabledelayedexpansion

REM Display header for the table
echo Wi-Fi Name                  Detected Password
echo ---------------------------------------------

REM Loop through each saved Wi-Fi profile
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile') do (
    REM Remove quotation marks from the Wi-Fi profile name
    set "ssid=%%~a"
    REM Call the subroutine to retrieve the password
    call :getpwd "%%ssid:~1%%"
)

REM Display footer for the table
echo.

REM Display your LinkedIn information
echo Thank you for using Wi-Fi Password Retrieval Tool.
echo If you have any questions or suggestions, feel free to contact:
echo - Zeeshan Mukhtar
echo - Connect with me on LinkedIn: https://www.linkedin.com/in/zeeshanmukhtar1/

REM Pause at the end of the script
pause

REM End of script
exit /b

:getpwd
set "ssid=%*"

REM Retrieve password for the specified Wi-Fi profile
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%ssid:"=%" key^=clear ^|findstr /C:"Key Content"') do (
    REM Print Wi-Fi name and password in customized format
    echo !ssid:~1!                        %%i
)

REM Return from subroutine
exit /b
