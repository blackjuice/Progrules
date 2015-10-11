# README

Progrules
---------

Repositório contendo os códigos do projeto da disciplina MAC0242 dada por Fábio Kon.

* *Cliente: Colégio Miguel de Cervantes (Diretor de Atividades Extracurriculares, Antonio Abello Rovai. Orientadora Educacional Valéria Ribeiro da Silva Graziano)*
* *Integrantes: Antonio Augusto Abello, Leonardo Daneu, Lucas Sung Jun Hong e Pedro Rodrigues*

###O que é e para que serve?

O software desse projeto do Progrules é basicamente um organizador de grupos de alunos. Todo ano deve-se distribuir estudantes em salas de aulas e dividir grupos em casos de viagens escolares. Para facilitar essa distribuição, o software auxiliará os professores a fazer uma divisão que consiga satisfazer o maior número de pessoas envolvidas (professores e alunos).


###Instalação

Em um Terminal, entre com o comando:

    $ git clone https://github.com/blackjuice/Progrules
    $ cd Progrules
    $ rvm use ruby-2.2.2
    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rails server

Em seguida, em um browser como Google Chrome, entre com o link: [http://localhost:3000](http://localhost:3000)

###Quick links
* [PivotalTracker](https://www.pivotaltracker.com/n/projects/1423058)
