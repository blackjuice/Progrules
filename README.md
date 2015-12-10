#Progrules

Repositório contendo os códigos do projeto da disciplina MAC0242 dada por Fábio Kon.

* *Cliente: Colégio Miguel de Cervantes (Diretor de Atividades Extracurriculares, Antonio Abello Rovai. Orientadora Educacional Valéria Ribeiro da Silva Graziano)*
* *Integrantes: Antonio Augusto Abello, Leonardo Daneu, Lucas Sung Jun Hong e Pedro Rodrigues*

###O que é e para que serve?

O software desse projeto do Progrules é basicamente um organizador de grupos de alunos. Todo ano deve-se distribuir estudantes em salas de aulas e dividir grupos em casos de viagens escolares. Para facilitar essa distribuição, o software auxiliará os professores a fazer uma divisão que consiga satisfazer o maior número de pessoas envolvidas (professores e alunos).


## Instalação

Em um Terminal, entre com o comando:

    $ git clone https://github.com/blackjuice/Progrules
    $ cd Progrules

Install bundler + Specify Ruby version

    $ gem install bundler
    $ rvm use ruby-1.9.3-p448
    
###1) Compilação
Instale e configure o GNU Linear Programming Kit (GLPK) (provavelmente é melhor executar como superuser)

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
    
###2) Mount app

    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rails server

Em seguida, em um browser como Google Chrome, entre com o link: [http://localhost:3000](http://localhost:3000)


## Como se logar como professor/aluno

###Usuário: Professor

Para se logar como um professor:

* Clicar em **Novo cadastro**;
* Logar-se com o novo cadastro criado.

Para inserir a lista de alunos exemplo, entre em: ``Adicionar aluno via excel``. Importe o arquivo ``csv_example/listaExemplo.csv``.

Entrando em ``Lista de alunos``, podemos observar os nomes dos alunos com a senha correspondente.

###Usuário: Aluno

Para se logar como um aluno:

* Logar-se com a senha do aluno correspondente (senha armazenada na ``Lista de alunos``, visível somente se logado como professor).

###Quick links
* [PivotalTracker](https://www.pivotaltracker.com/n/projects/1423058)
