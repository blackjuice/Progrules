#Progrules

Repositório contendo os códigos do projeto da disciplina MAC0242 dada por Fábio Kon.

* *Cliente: Colégio Miguel de Cervantes (Diretor de Atividades Extracurriculares, Antonio Abello Rovai. Orientadora Educacional Valéria Ribeiro da Silva Graziano)*
* *Integrantes: Antonio Augusto Abello, Leonardo Daneu, Lucas Sung Jun Hong e Pedro Rodrigues*

###O que é e para que serve?

O software desse projeto do Progrules é basicamente um organizador de grupos de alunos. Todo ano deve-se distribuir estudantes em salas de aulas e dividir grupos em casos de viagens escolares. Para facilitar essa distribuição, o software auxiliará os professores a fazer uma divisão que consiga satisfazer o maior número de pessoas envolvidas (professores e alunos).


###Instalação

Em um Terminal, entre com o comando:

    $ git clone https://github.com/blackjuice/Progrules
    $ cd Progrules

Install bundler + Specify Ruby version

    $ gem install bundler
    $ rvm use ruby-1.9.3-p448
    
Mount app

    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rails server
    
###Compilação
Instale e configure o GNU Linear Programming Kit (GLPK)
    $ wget http://ftp.gnu.org/gnu/glpk/glpk-4.57.tar.gz
    $ tar -zxvf glpk-4.57.tar.gz
    $ cd glpk-4.57
    $ ./configure
    $ make
    $ make install
    $ sudo ldconfig
    
No diretório de scripts (Progrules/scripts)
    $ gcc -c first.c
    $ gcc first.o -lglpk -lm -o main
    $ mv main ../

Em seguida, em um browser como Google Chrome, entre com o link: [http://localhost:3000](http://localhost:3000)

###Quick links
* [PivotalTracker](https://www.pivotaltracker.com/n/projects/1423058)
