@echo off
rem Es para generar un instalador win32, debido a que usamos delphi32

rem Creacion del entorno virtual (opcional) para el proyecto PyAfipWs
rem 2021 (c) Mariano Reingart <reingart@gmail.com> - Licencia: GPLv3+

rem Nota: Es recomendable ejecutar este programa como Administrador
rem Ver https://code.google.com/p/pyafipws/wiki/InstalacionCodigoFuente

pip 1> NUL 2> NUL
if %ERRORLEVEL%==9009 (
   echo Python / PIP no puede ser ejecutado
   echo Por favor instale Python 3: https://www.python.org/downloads/
   echo Asegurese que el PATH contenga a C:\Python39 y C:\Python39\scripts
   pause
   start https://www.python.org/ftp/python/3.9.4/python-3.9.4.exe
   exit 1
)

echo *** Instalar utilidades de instalacion / entorno virtual:
python -m pip install --upgrade pip
python -m pip install --upgrade setuptools wheel
python -m pip install --upgrade cachetools pefile
rem pip install --upgrade wheel
pip install --upgrade virtualenv

pause
echo ** Descargar redist a la carpeta
curl -L https://aka.ms/vs/17/release/vc_redist.x86.exe -o vcredist.exe
curl -L https://sourceforge.net/projects/nsis/files/latest/download -o NSISInstaller.exe
pause

echo ***** Descargar fuentes
git clone https://github.com/reingart/pyafipws.git
cd pyafipws

echo *** Crear y activar el entorno virtual venv (en el directorio actual):
virtualenv venv
venv\Scripts\activate

rem echo *** Limpiando py2 anterior
rem python -c "import aenum, os; os.unlink(os.path.join(os.path.dirname(aenum.__file__), '_py2.py'))"

echo *** Instalando dependencias del proyecto:
pip install -r requirements.txt
pip install -r requirements-dev.txt

python setup.py bdist_wheel sdist
python setup.py install
python setup_win.py py2exe

echo *** Listo!, para salir del entorno ejecute deactivate
