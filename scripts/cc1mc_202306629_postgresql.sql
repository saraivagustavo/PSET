------------------------------------------------------------------------------------
-- FASE DE PREPARAÇÃO DO PSET --
------------------------------------------------------------------------------------
DROP DATABASE IF EXISTS uvv;

DROP ROLE IF EXISTS gustavo;

DROP USER IF EXISTS gustavo;

------------------------------------------------------------------------------------
-- CRIAÇÃO DO USUÁRIO --
------------------------------------------------------------------------------------
CREATE USER gustavo WITH
  CREATEDB
  CREATEROLE
  ENCRYPTED PASSWORD '202306629';
------------------------------------------------------------------------------------
-- CRIAÇÃO DO BANCO DE DADOS --
------------------------------------------------------------------------------------
SET ROLE gustavo;
CREATE DATABASE uvv
    WITH
    OWNER = gustavo
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;

COMMENT ON DATABASE uvv IS 'Banco de Dados UVV que será inserido os dados';
------------------------------------------------------------------------------------
-- TROCA DE CONEXÃO --
------------------------------------------------------------------------------------
\setenv PGPASSWORD '202306629'
\c uvv gustavo
------------------------------------------------------------------------------------
-- CRIAÇÃO DO SCHEMA --
------------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS lojas;
CREATE SCHEMA IF NOT EXISTS lojas
    AUTHORIZATION gustavo;
ALTER DATABASE uvv SET search_path TO "lojas", public;
SET search_path TO lojas, "gustavo", public;
------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA PRODUTOS --
------------------------------------------------------------------------------------
CREATE TABLE lojas.produtos (
                produto_id                  NUMERIC(38) NOT NULL,
                nome                        VARCHAR(255) NOT NULL,
                preco_unitario              NUMERIC(10,2) NOT NULL,
                detalhe                     BYTEA NOT NULL,
                imagem                      BYTEA NOT NULL,
                imagem_mime_type            VARCHAR(512) NOT NULL,
                imagem_arquivo              VARCHAR(512) NOT NULL,
                imagem_charset              VARCHAR(512) NOT NULL,
                imagem_ultima_atualizacao   DATE NOT NULL,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

ALTER TABLE lojas.produtos OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA PRODUTOS --
COMMENT ON TABLE lojas.produtos IS 'Tabela com informações de cada produto comercializado.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Chave primária da tabela.
ID único de cada produto.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome de cada produto comercializado.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço unitário de cada produto comercializado.';
COMMENT ON COLUMN lojas.produtos.detalhe IS 'Descrição do produto comercializado.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto comercializado.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Identificação do tipo de documento da imagem do produto. (PNG, IMG...)';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Charset utilizado para informar o tipo de formato de codificação do documento.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Última atualização realizada sobre a imagem do produto.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA LOJAS --
------------------------------------------------------------------------------------
CREATE TABLE lojas.lojas (
                loja_id                   NUMERIC(38) NOT NULL,
                nome                      VARCHAR(255) NOT NULL,
                endereco_web              VARCHAR(100) NOT NULL,
                endereco_fisico           VARCHAR(512),
                latitude                  NUMERIC,
                longitude                 NUMERIC,
                logo                      BYTEA NOT NULL,
                logo_mime_type            VARCHAR(512) NOT NULL,
                logo_arquivo              VARCHAR(512) NOT NULL,
                logo_charset              VARCHAR(512) NOT NULL,
                logo_ultima_atualizacao   DATE NOT NULL,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

ALTER TABLE lojas.lojas OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA LOJAS --
COMMENT ON TABLE lojas.lojas IS 'Tabela das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Chave primária da tabela. 
ID de cada loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço da página web da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço físico da loja, se houver.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude do endereço físico da loja, se houver.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude do endereço físico da loja, se houver.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Identificação do tipo de documento da logo. (PNG, IMG...)';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo da logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Charset utilizado para informar o tipo de formato de codificação do documento.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Última atualização realizada sobre a logo da loja.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA ESTOQUES --
------------------------------------------------------------------------------------
CREATE TABLE lojas.estoques (
                estoque_id   NUMERIC(38) NOT NULL,
                loja_id      NUMERIC(38) NOT NULL,
                produto_id   NUMERIC(38) NOT NULL,
                quantidade   NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

ALTER TABLE lojas.estoques OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA ESTOQUES --
COMMENT ON TABLE lojas.estoques IS 'Tabela para controlar o estoque de produtos de cada loja.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Chave primária da tabela.
ID único de cada estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Chave estrangeira para a tabela lojas. 
ID de cada loja.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Chave estrangeira para a tabela produtos.
ID único de cada produto.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de cada produto, em cada estoque, de cada loja.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA CLIENTES --
------------------------------------------------------------------------------------
CREATE TABLE lojas.clientes (
                cliente_id   NUMERIC(38) NOT NULL,
                email        VARCHAR(255) NOT NULL,
                nome         VARCHAR(255) NOT NULL,
                telefone1    VARCHAR(20) NOT NULL,
                telefone3    VARCHAR(20),
                telefone2    VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

ALTER TABLE lojas.clientes OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA CLIENTES --
COMMENT ON TABLE lojas.clientes IS 'Tabela com as informações do cliente.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Chave primária da tabela. 
ID único do cliente.';
COMMENT ON COLUMN lojas.clientes.email IS 'Email do cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome inteiro do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Número de telefone primário do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Número de telefone terciário do cliente, se houver.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Número de telefone secundário do cliente, se houver.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA ENVIOS --
------------------------------------------------------------------------------------
CREATE TABLE lojas.envios (
                envio_id           NUMERIC(38) NOT NULL,
                loja_id            NUMERIC(38) NOT NULL,
                cliente_id         NUMERIC(38) NOT NULL,
                endereco_entrega   VARCHAR(512) NOT NULL,
                status             VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

ALTER TABLE lojas.envios OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA ENVIOS --
COMMENT ON TABLE lojas.envios IS 'Tabela para controlar os envios de cada produto, de cada loja, de cada cliente.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Chave primária da tabela. 
ID único do envio de cada pedido.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Chave estrangeira para a tabela lojas.
ID de cada loja.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Chave estrangeira para a tabela clientes.
ID único do cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço de entrega dos pedidos realizados.';
COMMENT ON COLUMN lojas.envios.status IS 'Situação em que se encontra cada envio.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA PEDIDOS --
------------------------------------------------------------------------------------
CREATE TABLE lojas.pedidos (
                pedido_id    NUMERIC(38) NOT NULL,
                cliente_id   NUMERIC(38) NOT NULL,
                data_hora    TIMESTAMP NOT NULL,
                status       VARCHAR(15) NOT NULL,
                loja_id      NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

ALTER TABLE lojas.pedidos OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA PEDIDOS --
COMMENT ON TABLE lojas.pedidos IS 'Tabela com os pedidos feitos pelos clientes em cada loja.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Chave primária da tabela. 
ID do pedido feito pelo cliente.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Chave estrangeira para a tabela clientes. 
ID único do cliente.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora do pedido realizado pelo cliente.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Situação do pedido realizado pelo cliente.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Chave estrangeira para a tabela lojas.
ID de cada loja.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DA TABELA PEDIDOS_ITENS --
------------------------------------------------------------------------------------
CREATE TABLE lojas.pedidos_itens (
                produto_id         NUMERIC(38) NOT NULL,
                pedido_id          NUMERIC(38) NOT NULL,
                envio_id           NUMERIC(38) NOT NULL,
                numero_da_linha    NUMERIC(38) NOT NULL,
                preco_unitario     NUMERIC(10,2) NOT NULL,
                quantidade         NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (produto_id, pedido_id)
);

ALTER TABLE lojas.pedidos_itens OWNER TO gustavo;

-- CRIAÇÃO DOS COMENTÁRIOS DA TABELA PEDIDOS_ITENS --
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela para controlar todos os pedidos feitos, com a quantidade de cada produto e seus respectivos valores e destino.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Chave primária composta da tabela.
ID único de cada produto.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Chave primária composta da tabela. 
ID do pedido feito pelo cliente.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Chave estrangeira para a tabela envios. 
ID único do envio de cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço unitário de cada produto comercializado.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de produtos desejados no pedido.';

------------------------------------------------------------------------------------
-- CRIAÇÃO DAS CHAVES ESTRANGEIRAS --
------------------------------------------------------------------------------------
-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA ESTOQUES REFERENCIANDO A TABELA PRODUTOS --
ALTER TABLE lojas.estoques 
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA PEDIDOS_ITENS REFERENCIANDO A TABELA PRODUTOS --
ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA PEDIDOS REFERENCIANDO A TABELA LOJAS --
ALTER TABLE lojas.pedidos 
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA ENVIOS REFERENCIANDO A TABELA LOJAS --
ALTER TABLE lojas.envios 
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA ESTOQUES REFERENCIANDO A TABELA LOJAS --
ALTER TABLE lojas.estoques 
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA PEDIDOS REFERENCIANDO A TABELA CLIENTES --
ALTER TABLE lojas.pedidos 
ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA ENVIOS REFERENCIANDO A TABELA CLIENTES --
ALTER TABLE lojas.envios 
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA PEDIDOS_ITENS REFERENCIANDO A TABELA ENVIOS --
ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- CRIAÇÃO DA CHAVE ESTRANGEIRA DA TABELA PEDIDOS_ITENS REFERENCIANDO A TABELA PEDIDOS --
ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

------------------------------------------------------------------------------------
-- CRIAÇÃO DAS RESTRIÇÕES DAS COLUNAS
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA PEDIDOS --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DA COLUNA STATUS --
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA ENVIOS --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DA COLUNA STATUS --
ALTER TABLE lojas.envios 
ADD CONSTRAINT check_status_envios 
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA PRODUTOS --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DA COLUNA STATUS --
ALTER TABLE lojas.produtos 
ADD CONSTRAINT check_preco_unitario_produtos 
CHECK (preco_unitario >= 0);
-- RESTRIÇÃO DA COLUNA NOME --
ALTER TABLE lojas.produtos
ADD CONSTRAINT unico_nome_produtos 
UNIQUE (nome);

------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA ESTOQUES --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DA COLUNA QUANTIDADE --
ALTER TABLE lojas.estoques 
ADD CONSTRAINT check_quantidade_estoques 
CHECK (quantidade >= 0);

------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA LOJAS --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DAS COLUNAS ENDERECO_WEB E ENDERECO_FISICO --
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_endereco_lojas
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);
-- RESTRIÇÃO DA COLUNA NOME --
ALTER TABLE lojas.lojas
ADD CONSTRAINT unico_nome_lojas 
UNIQUE (nome);
-- RESTRIÇÃO DA COLUNA LATITUDE --
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_latitude_lojas
CHECK (latitude >= -90 AND latitude <= 90);
-- RESTRIÇÃO DA COLUNA LONGITUDE --
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_longitude_lojas
CHECK (longitude >= -180 AND longitude <= 180);

------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA CLIENTES --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DA COLUNA EMAIL --
ALTER TABLE lojas.clientes
ADD CONSTRAINT check_email_clientes
CHECK (email ~* '^[A-Za-z0-9._]+@[A-Za-z0-9]+\\.[A-Za-z]{2,}$');
-- RESTRIÇÃO DA COLUNA TELEFONE1 --
ALTER TABLE lojas.clientes
ADD CONSTRAINT check_telefone1_clientes
CHECK (LENGTH(telefone1) >= 5 AND LENGTH(telefone1) <= 20);

------------------------------------------------------------------------------------
-- RESTRIÇÕES DA TABELA PEDIDOS_ITENS --
------------------------------------------------------------------------------------
-- RESTRIÇÃO DA COLUNA QUANTIDADE --
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_quantidade_pedidos_itens
CHECK (quantidade >= 0);
-- RESTRIÇÃO DA COLUNA PRECO_UNITARIO --
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_preco_unitario_pedidos_itens
CHECK (preco_unitario >= 0);