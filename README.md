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
    $ rvm use ruby-2.2.2
    
Mount app

    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rails server

Em seguida, em um browser como Google Chrome, entre com o link: [http://localhost:3000](http://localhost:3000)

###Quick links
* [PivotalTracker](https://www.pivotaltracker.com/n/projects/1423058)

##Record: Erros na instalação

####Issue: json-1.8.3 Gem::Ext::BuildError: ERROR: Failed to build gem native extension

Após ``bundle install --without production``, recebi o seguinte warning:

    Gem::InstallError: rack-cache requires Ruby version >= 2.0.0.
    An error occurred while installing rack-cache (1.3.0), and Bundler cannot continue.
    Make sure that `gem install rack-cache -v '1.3.0'` succeeds before bundling.

O comando ``rvm use ruby-2.2.2`` não resolveu. Chequei versão: ``bundle -v`` e recebi:

    /usr/local/rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- bundler (LoadError)
    from /usr/local/rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
    from /usr/bin/bundle:7:in `<main>'

Para isso, executei ``gem install bundler`` e em seguida ``bundle install --without production``, e recebi:

    An error occurred while installing json (1.8.3), and Bundler cannot continue.
    Make sure that `gem install json -v '1.8.3'` succeeds before bundling.
    
Comando ``gem install json -v '1.8.3'`` não resolveu. Chequei ``gem list`` e confirmei que de fato ``json (1.8.1)`` ainda não foi atualizado.

Por fim, neste [forum](https://github.com/flori/json/issues/253), foi recomendado executar: ``sudo apt-get install libgmp3-dev``, o que resolveu o problema.

