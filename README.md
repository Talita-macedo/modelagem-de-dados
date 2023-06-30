# Modelagem de Dados
A modelagem de dados não precisa ser complexa e cheia de elementos elaborados. Pelo contrário, precisa ser simples e com uma arquitetura bem embasada, para assim Fornecer os devidos benefícios de uma modelagem de dados relacional.


# Pré requisitos
1. Faça o download e instale o [BRModelo](http://www.sis4.com/brModelo/download.html), ferramenta open source para a criação dos Modelo Conceitual e o [Oracle Data Modeler](https://www.oracle.com/database/sqldeveloper/technologies/sql-data-modeler/download/) para os Modelos Lógico e Físico do projeto.

# Modelo Conceitual

1. Instale o JAVA na máquina para iniciar o BrModelo e extraia o arquivo zip do software
2. Abra um terminal CMD e execute o BrModelo

       cd dist
       java -jar "brModelo.jar"

3. Realize a coleta das informações necessárias para a construção da modelagem. Em seguida, abstrair e construir a modelagem conceitual (MER) com as entidades e regras de negócio, e com isso, criar a represetação gráfica do MER, sendo então o DER Diagrama Entidade Relacionamento, dentro do BrModelo

4. Separe entidade fraca e forte:
   Colocque im quadradinho dentro do outro para essa representação, ou seja, 1 quadrado = forte, 1 quadrado dentro do outro = fraca
   Realizar os tipos de relacionamentos entre as entidades, por meio de uma palavra de ação dentro da forma Losango

   Exemplo:
   
       Colaborador  - trabalha em -  Função | binário
   
       Colaborador  - trabalha em - função - projeto 1 | ternário
   
       Colaborador  - trabalha em - função - projeto 1 - projeto 2 | n-ário
   
   Observação: Entidades associativas - associar 2 entidades entre si quando ela possui relacionamentos com entidades diferentes

6. Elenque os tipos de atributos
   
   Exemplo:
      
       Pessoa física ou jurídica | Atributos de especialização
   
   Exemplo:
   
       Telefone | Composto
   
   Exemplo:
   
       Endereço | atributo multivalorado - destrinchar o atributo ou 1,2 cardinalidade
   
   Exemplo:
   
       Vazio | Null


# Modelo Lógico

1. Evolua a base do modelo conceitual para modelo lógico
   
2. Defina a cardinalidade diante da relação das entidades
   
3. Insira os atributos (características) das entidades
   
4. Implemente recursos como adequação de padrão e nomenclatura, as chaves primárias e estrangeiras, normalização, integridade referencial...


# Modelo Físico

1. Após as primeiras etapas de modelagem de dados, inicia-se a modelagem física
   
2. Definir qual será o SGBD que será utilizado para receber esse novo banco de dados
   
3. Transcrever o desenho para uma ferramenta CASE (Oracle SQL DataModeler, MySQL Workbench entre outras). Exemplo no arquivo [script-ddl](https://github.com/Talita-macedo/modelagem-de-dados/blob/main/implanta%C3%A7%C3%A3o-modelagem).


