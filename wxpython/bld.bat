:: LOTS more to do here!

cd wxPython
call "%HOMEPATH%\AppData\Local\Programs\Common\\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" amd64
"%PYTHON%" build-wxpython.py --prefix=$PREFIX --build_dir=../bld  --install

