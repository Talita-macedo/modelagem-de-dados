-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

-- COMANDOS PARA ELIMINAR O PROJETO FISICO

DROP TABLE t_sgv_categoria_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_chamado CASCADE CONSTRAINTS;

DROP TABLE t_sgv_classificacao_video CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente_pf CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente_pj CASCADE CONSTRAINTS;

DROP TABLE t_sgv_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_sgv_plataforma CASCADE CONSTRAINTS;

DROP TABLE t_sgv_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_video CASCADE CONSTRAINTS;

DROP TABLE t_sgv_visualizacao CASCADE CONSTRAINTS;

-- COMANDOS PARA CRIAR O PROJETO FISICO

CREATE TABLE t_sgv_categoria_produto (
    cod_categoria NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    des_categoria VARCHAR2(30) NOT NULL,
    sta_categoria CHAR(1) NOT NULL,
    dat_inicio    DATE NOT NULL,
    dat_termino   DATE
);

ALTER TABLE T_SGV_CATEGORIA_PRODUTO ADD CONSTRAINT UNIQUE_DES_CATEGORIA UNIQUE ( des_categoria);

ALTER TABLE T_SGV_CATEGORIA_PRODUTO ADD CONSTRAINT CHECK_STATUS_CATEGORIA_PRODUTO CHECK(STA_CATEGORIA IN ('A','I'));

ALTER TABLE t_sgv_categoria_produto ADD CONSTRAINT pk_categoria_produto PRIMARY KEY ( cod_categoria );

COMMENT ON TABLE t_sgv_categoria_produto IS 
    'Tabela que armazena as categorias de produtos';

COMMENT ON COLUMN t_sgv_categoria_produto.cod_categoria IS 
    'Código da categoria (chave primária gerada automaticamente - IDENTITY) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_categoria_produto.des_categoria IS 
    'Descrição da categoria de produto - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_categoria_produto.sta_categoria IS 
    'Status da categoria - formato: CHAR(1) - armazenamento em maiúsculo';

COMMENT ON COLUMN t_sgv_categoria_produto.dat_inicio IS 
    'Data de início de validade da categoria - formato: DATE';

COMMENT ON COLUMN t_sgv_categoria_produto.dat_termino IS 
    'Data de término de validade da categoria (opcional) - formato: DATE';

CREATE TABLE t_sgv_chamado (
    cod_chamado       NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    cod_cliente       NUMBER(10) NOT NULL,
    cod_produto       NUMBER(10) NOT NULL,
    cod_funcionario   NUMBER(10) NOT NULL,
    dat_abertura      DATE NOT NULL,
    dat_atendimento   DATE,
    sta_chamado       CHAR(1) NOT NULL,
    tempo_atendimento NUMBER(2, 1) NOT NULL,
    indice_satisfacao NUMBER(2),
    tipo_chamado      CHAR(1) NOT NULL,
    txt_avaliacao     VARCHAR2(4000) NOT NULL
);

ALTER TABLE t_sgv_chamado ADD CONSTRAINT check_tipo_chamado CHECK (tipo_chamado IN ('1','2'));

ALTER TABLE t_sgv_chamado ADD CONSTRAINT check_sta_chamo CHECK (sta_chamado IN ('A','E','C','F','X'));

ALTER TABLE t_sgv_chamado ADD CONSTRAINT chamado_pk PRIMARY KEY ( cod_chamado );

COMMENT ON TABLE t_sgv_chamado IS 
    'Tabela que armazena os chamados de suporte técnico';

COMMENT ON COLUMN t_sgv_chamado.cod_chamado IS 
    'Código do chamado (chave primária gerada automaticamente - IDENTITY) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_chamado.cod_cliente IS 
    'Código do cliente que abriu o chamado (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_chamado.cod_produto IS 
    'Código do produto relacionado ao chamado (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_chamado.cod_funcionario IS 
    'Código do funcionário responsável pelo atendimento (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_chamado.dat_abertura IS 
    'Data de abertura do chamado - formato: DATE';

COMMENT ON COLUMN t_sgv_chamado.dat_atendimento IS 
    'Data de atendimento do chamado (opcional) - formato: DATE';

COMMENT ON COLUMN t_sgv_chamado.sta_chamado IS 
    'Status do chamado - formato: CHAR(1) - armazenamento em maiúsculo';

COMMENT ON COLUMN t_sgv_chamado.tempo_atendimento IS 
    'Tempo de atendimento do chamado (em horas) - formato: NUMBER(2, 1)';

COMMENT ON COLUMN t_sgv_chamado.indice_satisfacao IS 
    'Índice de satisfação do cliente com o atendimento (opcional) - formato: NUMBER(2)';

COMMENT ON COLUMN t_sgv_chamado.tipo_chamado IS 
    'Tipo de chamado - formato: CHAR(1)';

COMMENT ON COLUMN t_sgv_chamado.txt_avaliacao IS 
    'Texto com a avaliação do cliente sobre o atendimento - formato: VARCHAR2(4000) - armazenamento em minúsculo';

CREATE TABLE t_sgv_classificacao_video (
    cod_classificacao NUMBER(10) NOT NULL,
    des_classificacao VARCHAR2(30)
);

ALTER TABLE t_sgv_classificacao_video ADD CONSTRAINT pk_categoria_video PRIMARY KEY ( cod_classificacao );

COMMENT ON TABLE t_sgv_classificacao_video IS 
    'Tabela que armazena as classificações dos vídeos';

COMMENT ON COLUMN t_sgv_classificacao_video.cod_classificacao IS 
    'Código da classificação (chave primária) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_classificacao_video.des_classificacao IS 
    'Descrição da classificação de vídeo - formato: VARCHAR2(30) - armazenamento em minúsculo (opcional)';

CREATE TABLE t_sgv_cliente (
    cod_cliente  NUMBER(10) NOT NULL,
    nom_cliente  VARCHAR2(30) NOT NULL,
    sta_cliente  CHAR(1) NOT NULL,
    qtd_estrela  NUMBER(1),
    login        VARCHAR2(30) NOT NULL,
    senha        VARCHAR2(10) NOT NULL,
    telefone     VARCHAR2(14),
    tipo_cliente CHAR(2) NOT NULL
);

ALTER TABLE t_sgv_cliente ADD CONSTRAINT pk_cliente PRIMARY KEY ( cod_cliente );

ALTER TABLE T_SGV_CLIENTE ADD CONSTRAINT CHECK_TIPO_CLIENTE CHECK (tipo_cliente IN('PF', 'PJ'));

COMMENT ON TABLE t_sgv_cliente IS 
    'Tabela que armazena os dados dos clientes cadastrados';

COMMENT ON COLUMN t_sgv_cliente.cod_cliente IS 
    'Código do cliente (chave primária) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_cliente.nom_cliente IS 
    'Nome do cliente - formato: VARCHAR2(30) - armazenamento em InitCap';

COMMENT ON COLUMN t_sgv_cliente.sta_cliente IS 
    'Status do cliente - formato: CHAR(1) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_cliente.qtd_estrela IS 
    'Quantidade de estrelas atribuídas ao cliente - formato: NUMBER(1)';

COMMENT ON COLUMN t_sgv_cliente.login IS 
    'Login do cliente para acesso ao sistema - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_cliente.senha IS 
    'Senha de acesso do cliente - formato: VARCHAR2(10) - armazenamento criptografado';

COMMENT ON COLUMN t_sgv_cliente.telefone IS 
    'Número de telefone do cliente - formato: VARCHAR2(14)';

COMMENT ON COLUMN t_sgv_cliente.tipo_cliente IS 
    'Tipo de cliente (PF - Pessoa Física ou PJ - Pessoa Jurídica) (coluna para identificar a tabela de destino na herança)- formato: CHAR(2) - armazenamento em maiúsculo';

CREATE TABLE t_sgv_cliente_pf (
    cod_cliente    NUMBER(10) NOT NULL,
    cpf            VARCHAR2(14) NOT NULL,
    dat_nascimento DATE NOT NULL,
    sexo_biologico CHAR(1) NOT NULL,
    genero         VARCHAR2(20)
);

ALTER TABLE t_sgv_cliente_pf ADD CONSTRAINT pk_cliente_pf PRIMARY KEY ( cod_cliente );


COMMENT ON TABLE t_sgv_cliente_pf IS 
    'Tabela que armazena os dados de clientes do tipo pessoa física (PF)';

COMMENT ON COLUMN t_sgv_cliente_pf.cod_cliente IS 
    'Código do cliente (chave primária e estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_cliente_pf.cpf IS 
    'Número do CPF do cliente - formato: VARCHAR2(14)';

COMMENT ON COLUMN t_sgv_cliente_pf.dat_nascimento IS 
    'Data de nascimento do cliente - formato: DATE';

COMMENT ON COLUMN t_sgv_cliente_pf.sexo_biologico IS 
    'Sexo biológico do cliente - formato: CHAR(1) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_cliente_pf.genero IS 
    'Gênero do cliente (opcional) - formato: VARCHAR2(20) - armazenamento em minúsculo';

CREATE TABLE t_sgv_cliente_pj (
    cod_cliente        NUMBER(10) NOT NULL,
    dat_fundacao       DATE,
    inscricao_estadual VARCHAR2(14),
    cnpj               VARCHAR2(18)
);

ALTER TABLE t_sgv_cliente_pj ADD CONSTRAINT pk_cliente_pj PRIMARY KEY ( cod_cliente );

COMMENT ON TABLE t_sgv_cliente_pj IS 
    'Tabela que armazena os dados de clientes do tipo pessoa jurídica (PJ)';

COMMENT ON COLUMN t_sgv_cliente_pj.cod_cliente IS 
    'Código do cliente (chave primária e estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_cliente_pj.dat_fundacao IS 
    'Data de fundação da empresa - formato: DATE';

COMMENT ON COLUMN t_sgv_cliente_pj.inscricao_estadual IS 
    'Número de inscrição estadual da empresa (opcional) - formato: VARCHAR2(14)';

COMMENT ON COLUMN t_sgv_cliente_pj.cnpj IS 
    'Número do CNPJ da empresa - formato: VARCHAR2(18)';

CREATE TABLE t_sgv_funcionario (
    cod_funcionario  NUMBER(10) NOT NULL,
    nom_funcionario  VARCHAR2(30) NOT NULL,
    cpf              VARCHAR2(14) NOT NULL,
    dat_nascimento   DATE NOT NULL,
    telefone         VARCHAR2(10) NOT NULL,
    email            VARCHAR2(30) NOT NULL,
    des_cargo        VARCHAR2(30) NOT NULL,
    nom_departamento VARCHAR2(30) NOT NULL,
    ddd              NUMBER(2) NOT NULL
);

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT UNIQUE_CPF_FUNCIONARIO UNIQUE ( cpf );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT pk_funcionario PRIMARY KEY ( cod_funcionario );

COMMENT ON TABLE t_sgv_funcionario IS 
    'Tabela que armazena os dados dos funcionários';

COMMENT ON COLUMN t_sgv_funcionario.cod_funcionario IS 
    'Código do funcionário (chave primária) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_funcionario.nom_funcionario IS 
    'Nome do funcionário - formato: VARCHAR2(30) - armazenamento em InitCap';

COMMENT ON COLUMN t_sgv_funcionario.cpf IS 
    'Número do CPF do funcionário - formato: VARCHAR2(14)';

COMMENT ON COLUMN t_sgv_funcionario.dat_nascimento IS 
    'Data de nascimento do funcionário - formato: DATE';

COMMENT ON COLUMN t_sgv_funcionario.telefone IS 
    'Número do telefone do funcionário - formato: VARCHAR2(10)';

COMMENT ON COLUMN t_sgv_funcionario.email IS 
    'Endereço de e-mail do funcionário - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_funcionario.des_cargo IS 
    'Descrição do cargo do funcionário - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_funcionario.nom_departamento IS 
    'Nome do departamento em que o funcionário trabalha - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_funcionario.ddd IS 
    'DDD do telefone do funcionário - formato: NUMBER(2)';

CREATE TABLE t_sgv_plataforma (
    cod_plataforma        NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    categoria_dispositivo VARCHAR2(20 CHAR),
    tipo_dispositivo      VARCHAR2(20),
    tipo_rede             VARCHAR2(20),
    cookie                CHAR(1)
);

ALTER TABLE t_sgv_plataforma ADD CONSTRAINT pk_plataforma PRIMARY KEY ( cod_plataforma );

COMMENT ON TABLE t_sgv_plataforma IS 
    'Tabela que armazena os dados das plataformas onde os clientes consomem os vídeos';

COMMENT ON COLUMN t_sgv_plataforma.cod_plataforma IS 
    'Código da plataforma (chave primária gerada automaticamente - IDENTITY) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_plataforma.categoria_dispositivo IS 
    'Categoria do dispositivo da plataforma (por exemplo, celular, tablet, computador, notebook, etc.) - formato: VARCHAR2(20 CHAR) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_plataforma.tipo_dispositivo IS 
    'Tipo do dispositivo da plataforma (por exemplo, movel, dispositivo de mesa, etc.) - formato: VARCHAR2(20) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_plataforma.tipo_rede IS 
    'Tipo de rede da plataforma (por exemplo, Wi-Fi, 5G, etc.) - formato: VARCHAR2(20) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_plataforma.cookie IS 
    'Indica se o usuário aceitou os cookies no momento de assitir o vídeo - formato: CHAR(1) - armazenamento em minúsculo';

CREATE TABLE t_sgv_produto (
    cod_produto          NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    cod_categoria        NUMBER(10) NOT NULL,
    des_produto          VARCHAR2(30) NOT NULL,
    des_completa_produto VARCHAR2(30) NOT NULL,
    val_preco_produto    NUMBER(10, 2) NOT NULL,
    cod_barras           NUMBER(13),
    sta_produto          CHAR(1) NOT NULL
);

ALTER TABLE T_SGV_PRODUTO ADD CONSTRAINT UNIQUE_DES_PRODUTO UNIQUE (des_produto);

ALTER TABLE T_SGV_PRODUTO ADD CONSTRAINT CHECK_STATUS_PRODUTO CHECK (STA_PRODUTO IN('A', 'I', 'P'));

ALTER TABLE t_sgv_produto ADD CONSTRAINT pk_produto PRIMARY KEY ( cod_produto );

COMMENT ON TABLE t_sgv_produto IS 
    'Tabela que armazena os dados dos produtos';

COMMENT ON COLUMN t_sgv_produto.cod_produto IS 
    'Código do produto (chave primária gerada automaticamente - IDENTITY) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_produto.cod_categoria IS 
    'Código da categoria de produto relacionada ao produto (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_produto.des_produto IS 
    'Descrição normal do produto - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_produto.des_completa_produto IS 
    'Descrição completa do produto - formato: VARCHAR2(30) - armazenamento em minúsculo';

COMMENT ON COLUMN t_sgv_produto.val_preco_produto IS 
    'Preço do produto - formato: NUMBER(10,2)';

COMMENT ON COLUMN t_sgv_produto.cod_barras IS 
    'Código de barras do produto - formato: NUMBER(13) - armazenamento no padrão EAN13';

COMMENT ON COLUMN t_sgv_produto.sta_produto IS 
    'Status do produto - formato: CHAR(1) - armazenamento em maiúsculo';

CREATE TABLE t_sgv_video (
    cod_video         NUMBER(10) NOT NULL,
    cod_produto       NUMBER(10) NOT NULL,
    cod_classificacao NUMBER(10) NOT NULL,
    sta_video         CHAR(1),
    dat_cadastro      DATE NOT NULL
);

ALTER TABLE T_SGV_VIDEO ADD CONSTRAINT CHECK_STATUS_VIDEO CHECK (STA_VIDEO IN ('A', 'I'));

ALTER TABLE t_sgv_video ADD CONSTRAINT pk_video PRIMARY KEY ( cod_video );

COMMENT ON TABLE t_sgv_video IS
    'Tabela que armazena os vídeos dos produtos comercializados na plataforma';

COMMENT ON COLUMN t_sgv_video.cod_video IS
    'Código do vídeo (chave primária) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_video.cod_produto IS
    'Código do produto relacionado ao vídeo (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_video.cod_classificacao IS
    'Código da classificação do vídeo (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_video.sta_video IS
    'Status do vídeo - formato: CHAR(1) - armazenamento em maiúsculo';

COMMENT ON COLUMN t_sgv_video.dat_cadastro IS
    'Data de cadastro do vídeo - formato: DATE';

CREATE TABLE t_sgv_visualizacao (
    cod_visualizacao NUMBER(10) NOT NULL,
    cod_video        NUMBER(10) NOT NULL,
    cod_cliente      NUMBER(10) NOT NULL,
    cod_plataforma   NUMBER(10) NOT NULL,
    cod_produto      NUMBER(10) NOT NULL,
    dat_visualizacao DATE NOT NULL
);

ALTER TABLE t_sgv_visualizacao ADD CONSTRAINT pk_visualizacao PRIMARY KEY ( cod_visualizacao );

COMMENT ON TABLE t_sgv_visualizacao IS
    'Tabela que armazena as visualizações dos vídeos dos produtos pelos clientes na plataforma';

COMMENT ON COLUMN t_sgv_visualizacao.cod_visualizacao IS
    'Código da visualização (chave primária) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_visualizacao.cod_video IS
    'Código do vídeo visualizado (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_visualizacao.cod_cliente IS
    'Código do cliente que visualizou o vídeo (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_visualizacao.cod_plataforma IS
    'Código da plataforma em que o vídeo foi visualizado (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_visualizacao.cod_produto IS
    'Código do produto relacionado ao vídeo visualizado (chave estrangeira) - formato: NUMBER(10)';

COMMENT ON COLUMN t_sgv_visualizacao.dat_visualizacao IS
    'Data da visualização do vídeo - formato: DATE';

ALTER TABLE t_sgv_video
    ADD CONSTRAINT fk_classificacao_video FOREIGN KEY ( cod_classificacao )
        REFERENCES t_sgv_classificacao_video ( cod_classificacao );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_cliente_chamado FOREIGN KEY ( cod_cliente )
        REFERENCES t_sgv_cliente ( cod_cliente );

ALTER TABLE t_sgv_cliente_pf
    ADD CONSTRAINT fk_cliente_pf FOREIGN KEY ( cod_cliente )
        REFERENCES t_sgv_cliente ( cod_cliente );

ALTER TABLE t_sgv_cliente_pj
    ADD CONSTRAINT fk_cliente_pj FOREIGN KEY ( cod_cliente )
        REFERENCES t_sgv_cliente ( cod_cliente );

ALTER TABLE t_sgv_visualizacao
    ADD CONSTRAINT fk_cliente_visualizacao FOREIGN KEY ( cod_cliente )
        REFERENCES t_sgv_cliente ( cod_cliente );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_funcionario_chamado FOREIGN KEY ( cod_funcionario )
        REFERENCES t_sgv_funcionario ( cod_funcionario );

ALTER TABLE t_sgv_visualizacao
    ADD CONSTRAINT fk_plataforma_visualizacao FOREIGN KEY ( cod_plataforma )
        REFERENCES t_sgv_plataforma ( cod_plataforma );

ALTER TABLE t_sgv_video
    ADD CONSTRAINT fk_produto FOREIGN KEY ( cod_produto )
        REFERENCES t_sgv_produto ( cod_produto );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT fk_produto_categoria FOREIGN KEY ( cod_categoria )
        REFERENCES t_sgv_categoria_produto ( cod_categoria );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_produto_chamado FOREIGN KEY ( cod_produto )
        REFERENCES t_sgv_produto ( cod_produto );

ALTER TABLE t_sgv_visualizacao
    ADD CONSTRAINT fk_produto_visualizacao FOREIGN KEY ( cod_produto )
        REFERENCES t_sgv_produto ( cod_produto );

ALTER TABLE t_sgv_visualizacao
    ADD CONSTRAINT fk_video_visualizacao FOREIGN KEY ( cod_video )
        REFERENCES t_sgv_video ( cod_video );

CREATE OR REPLACE TRIGGER arc_arc_1_t_sgv_cliente_pf BEFORE
    INSERT OR UPDATE OF cod_cliente ON t_sgv_cliente_pf
    FOR EACH ROW
DECLARE
    d CHAR(2);
BEGIN
    SELECT
        a.tipo_cliente
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cod_cliente = :new.cod_cliente;

    IF ( d IS NULL OR d <> 'PF' ) THEN
        raise_application_error(-20223, 'FK FK_CLIENTE_PF in Table T_SGV_CLIENTE_PF violates Arc constraint on Table T_SGV_CLIENTE - discriminator column tipo_cliente doesn''t have value ''PF'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
--/

CREATE OR REPLACE TRIGGER arc_arc_1_t_sgv_cliente_pj BEFORE
    INSERT OR UPDATE OF cod_cliente ON t_sgv_cliente_pj
    FOR EACH ROW
DECLARE
    d CHAR(2);
BEGIN
    SELECT
        a.tipo_cliente
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cod_cliente = :new.cod_cliente;

    IF ( d IS NULL OR d <> 'PJ' ) THEN
        raise_application_error(-20223, 'FK FK_CLIENTE_PJ in Table T_SGV_CLIENTE_PJ violates Arc constraint on Table T_SGV_CLIENTE - discriminator column tipo_cliente doesn''t have value ''PJ'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
--/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
