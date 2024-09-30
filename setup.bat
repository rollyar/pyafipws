@echo off

rem Instalaci�n y registraci�n de las dependencias para el proyecto PyAfipWs
rem 2015 (c) Mariano Reingart <reingart@gmail.com> - Licencia: GPLv3+

rem Nota: Es recomendable ejecutar este programa como Administrador 
rem       o en un entorno virtual (venv.bat)
rem Ver https://code.google.com/p/pyafipws/wiki/InstalacionCodigoFuente

pip 1> NUL 2> NUL
if %ERRORLEVEL%==9009 (
   echo Python 2.7.9 / PIP no ha sido encontrdo
   echo Por favor instale: https://www.python.org/ftp/python/2.7.9/python-2.7.9.msi
   echo Asegurese que el PATH contenga a C:\Python27 y la carpeta C:\Python27\scripts
   pause
   start https://www.python.org/ftp/python/2.7.9/python-2.7.9.msi
   exit 1
)

pip install -r requirements.txt

echo *** Registrando componentes...

python wsaa.py --register
python wsfev1.py --register
rem python wsfexv1.py --register
rem python wsbfev1.py --register
rem python wsmtx.py --register

rem python wscdc.py --register

rem python pyfepdf.py --register
rem python pyi25.py --register
rem python pyemail.py --register

rem python padron.py --register

rem python cot.py --register

rem python wsctgv2.py --register
rem python wslpg.py --register

rem python trazamed.py --register
rem python trazarenpre.py --register
rem python trazafito.py --register
rem python trazavet.py --register

echo *** Listo!

echo Para generar el instalador debe descargar e instalar:
echo Nullsoft Scriptable Install System (NSIS): http://nsis.sourceforge.net/

pause
