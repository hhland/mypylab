FROM ipython/ipython

ENV R_VERSION 3.1.2
ENV OCTAVE_VERSION 3.8.2

RUN mkdir -p /d/download && mkdir /d/program && /d/git 

RUN apt-get update && apt-get install -y cmake g++ gcc git vim gfortran xpdf  libbz2-dev libgdbm-dev liblzma-dev libreadline-dev libsqlite3-dev libssl-dev tcl-dev tk-dev dpkg-dev wget

WORKDIR /d/download
#R
RUN wget http://cran.rstudio.com/src/base/R-3/R-$R_VERSION.tar.gz && tar -xvf R-$R_VERSION.tar.gz && cd R-$R_VERSION && ./configure && make && make install 

#octave
RUN wget ftp://ftp.gnu.org/gnu/octave/octave-$OCTAVE_VERSION.tar.gz && tar -xvf octave-$OCTAVE_VERSION.tar.gz && cd octave-$OCTAVE_VERSION && ./configure && make && make install 

RUN pip install numpy scipy matplotlib sympy pandas oct2py rpy2 cython

RUN ipython profile create mypylab

CMD ipython notebook --ip 0.0.0.0 --profile mypylab
