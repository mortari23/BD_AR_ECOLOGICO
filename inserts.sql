-- =====================================================================
-- INSERTS DE EXEMPLO
-- Pressupoe tabelas recem-criadas e VAZIAS: os codigos IDENTITY comecam
-- em 1 e os inserts abaixo usam esses numeros nas chaves estrangeiras.
-- Se ja inseriu algo antes, esvazie as tabelas e reinicie o IDENTITY:
--   DBCC CHECKIDENT ('NOME_DA_TABELA', RESEED, 0)
-- Todos os dados (CPF, CNPJ, telefones, e-mails) sao ficticios.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1) PESSOAS  (cod 1-7 = pessoas fisicas | cod 8-12 = pessoas juridicas)
-- ---------------------------------------------------------------------
INSERT INTO PESSOAS (ENDERECO, CEP, NUMERO, CIDADE, ESTADO, TELEFONE, NOME, EMAIL) VALUES
('Rua Bernardino de Campos', '15015100', '1200', 'Sao Jose do Rio Preto', 'SP', '17991110001', 'Carlos Eduardo Silva',   'carlos.silva@email.com'),   -- 1 (prestador)
('Av. Alberto Andalo',       '15015000', '3400', 'Sao Jose do Rio Preto', 'SP', '17991110002', 'Marcos Antonio Souza',   'marcos.souza@email.com'),   -- 2 (prestador)
('Rua Voluntarios de SP',    '15015200', '850',  'Sao Jose do Rio Preto', 'SP', '17991110003', 'Rafael Henrique Lima',   NULL),                       -- 3 (prestador)
('Rua Siqueira Campos',      '15010020', '77',   'Sao Jose do Rio Preto', 'SP', '17991110004', 'Joao Pedro Oliveira',    'joao.oliveira@email.com'),  -- 4 (prestador)
('Av. Brasil',               '15025000', '2100', 'Sao Jose do Rio Preto', 'SP', '17991110005', 'Fernando Costa Ribeiro', 'fernando.ribeiro@email.com'), -- 5 (prestador)
('Rua Gabriel Monteiro',     '15020030', '45',   'Sao Jose do Rio Preto', 'SP', '17991110006', 'Ana Paula Martins',      'ana.martins@email.com'),    -- 6 (cliente PF)
('Rua Pedro Amaral',         '15010100', '312',  'Sao Jose do Rio Preto', 'SP', '17991110007', 'Luciana Ferreira Alves', NULL),                       -- 7 (cliente PF)
('Av. Jose Munia',           '15090000', '5000', 'Sao Jose do Rio Preto', 'SP', '1732220008',  'Supermercado Bom Preco', 'contato@bompreco.com.br'),  -- 8
('Rua Presidente Prudente',  '15015300', '980',  'Sao Jose do Rio Preto', 'SP', '1732220009',  'Clinica Vida Saudavel',  'adm@vidasaudavel.com.br'),  -- 9
('Av. Philadelpho Gouveia',  '15020010', '1500', 'Sao Jose do Rio Preto', 'SP', '1732220010',  'Hotel Central Palace',   'reservas@centralpalace.com.br'), -- 10
('Rua General Glicerio',     '15015400', '620',  'Sao Jose do Rio Preto', 'SP', '1732220011',  'Escritorio Contabil Alfa','alfa@contabilalfa.com.br'), -- 11
('Av. Anisio Haddad',        '15093000', '7800', 'Sao Jose do Rio Preto', 'SP', '1732220012',  'Restaurante Sabor Caseiro', NULL);                     -- 12
GO

-- ---------------------------------------------------------------------
-- 2) PESSOAS_FISICAS  (pessoas 1 a 7)
-- ---------------------------------------------------------------------
INSERT INTO PESSOAS_FISICAS (PESSOA_FISICA_COD, CPF, RG, DATA_NASCIMENTO) VALUES
(1, '11111111111', '123456789',  '1985-03-12'),
(2, '22222222222', '234567890',  '1990-07-25'),
(3, '33333333333', NULL,         '1988-11-02'),
(4, '44444444444', '456789012',  '1995-01-30'),
(5, '55555555555', '567890123',  '1982-09-18'),
(6, '66666666666', '678901234',  '1979-05-08'),
(7, '77777777777', NULL,         '1992-12-21');
GO

-- ---------------------------------------------------------------------
-- 3) PESSOAS_JURIDICAS  (pessoas 8 a 12)
-- ---------------------------------------------------------------------
INSERT INTO PESSOAS_JURIDICAS (PESSOA_JURIDICA_COD, CNPJ, RAZAO_SOCIAL) VALUES
(8,  '10000000000101', 'Bom Preco Comercio de Alimentos Ltda'),
(9,  '20000000000102', 'Clinica Vida Saudavel S/S'),
(10, '30000000000103', 'Central Palace Hoteis e Turismo Ltda'),
(11, '40000000000104', 'Alfa Servicos Contabeis Ltda'),
(12, '50000000000105', 'Sabor Caseiro Restaurante Ltda');
GO

-- ---------------------------------------------------------------------
-- 4) PRESTADOR_SERVICOS  (pessoas fisicas 1 a 5)
-- ---------------------------------------------------------------------
INSERT INTO PRESTADOR_SERVICOS (PRESTADOR_COD, PAGAMENTO) VALUES
(1, 120.00),
(2, 150.00),
(3, 100.00),
(4, 130.00),
(5, 140.00);
GO

-- ---------------------------------------------------------------------
-- 5) EQUIPAMENTOS  (cod 1 a 5)
-- ---------------------------------------------------------------------
INSERT INTO EQUIPAMENTOS (BTUS, MODELO, MARCA, OBS) VALUES
(9000,  'Split Inverter Eco 9',     'Samsung', NULL),
(12000, 'Split Hi Wall Prime 12',   'LG',      'Modelo mais vendido'),
(18000, 'Split Inverter Gold 18',   'Midea',   NULL),
(24000, 'Split Piso Teto 24',       'Carrier', 'Indicado para ambientes comerciais'),
(30000, 'Cassete Comercial 30',     'Daikin',  'Instalacao em forro');
GO

-- ---------------------------------------------------------------------
-- 6) SERVICOS  (cod 1 a 5)
-- ---------------------------------------------------------------------
INSERT INTO SERVICOS (DATA_INICIO, DATA_FIM, VALOR_SERVICO, DESCRICAO, OBS) VALUES
('2026-01-05', '2026-01-05', 180.00, 'Limpeza completa do aparelho',            NULL),
('2026-01-05', '2026-01-05',  90.00, 'Troca de filtro',                         NULL),
('2026-02-10', '2026-02-11', 650.00, 'Instalacao de ar-condicionado split',     'Inclui suporte e tubulacao ate 3m'),
('2026-03-03', '2026-03-03', 320.00, 'Recarga de gas refrigerante',             NULL),
('2026-03-15', '2026-03-15', 210.00, 'Troca de capacitor',                      'Peca fornecida pela empresa');
GO

-- ---------------------------------------------------------------------
-- 7) CONTRATOS  (cada contrato tem pessoa fisica OU juridica)
--    1 a 4 = empresas | 5 = pessoa fisica
-- ---------------------------------------------------------------------
INSERT INTO CONTRATOS (DESCRICAO, DATA_INICIO, DATA_FIM, TIPO_CONTRATO, OBS, COD_PESSOA_FISICA, COD_PESSOA_JURIDICA) VALUES
('Manutencao preventiva mensal dos aparelhos do supermercado', '2026-01-01', '2026-12-31', 'Manutencao Mensal',   NULL,                      NULL, 8),
('Instalacao e manutencao dos aparelhos da clinica',           '2026-02-01', '2027-01-31', 'Instalacao e Manutencao', 'Atendimento prioritario', NULL, 9),
('Manutencao trimestral dos quartos e areas comuns do hotel',  '2026-01-15', '2026-12-15', 'Manutencao Trimestral', NULL,                      NULL, 10),
('Manutencao preventiva semestral do escritorio',              '2026-03-01', '2026-08-31', 'Manutencao Semestral', NULL,                      NULL, 11),
('Manutencao anual dos aparelhos da residencia',               '2026-04-01', '2027-03-31', 'Manutencao Anual',    'Cliente pessoa fisica',   6,    NULL);
GO

-- ---------------------------------------------------------------------
-- 8) CONTRATOS_EQUIPAMENTOS  (contrato, equipamento, quantidade)
-- ---------------------------------------------------------------------
INSERT INTO CONTRATOS_EQUIPAMENTOS (CONTRATO_COD, EQUIPAMENTO_COD, QTD) VALUES
(1, 4, 6),
(1, 5, 2),
(2, 2, 10),
(3, 3, 25),
(4, 1, 4),
(4, 2, 3),
(5, 2, 2);
GO

-- ---------------------------------------------------------------------
-- 9) ORDENS_SERVICOS
--    STATUS: 1 = aberta | 2 = em andamento | 3 = concluida
--    Cada OS tem pessoa fisica OU juridica; contrato e prestador sao opcionais
-- ---------------------------------------------------------------------
INSERT INTO ORDENS_SERVICOS
    (TIPO_OS, VALOR, OBS, DATA_ABERTURA, STATUS, DESCRICAO_PROBLEMA, DESCRICAO_EXECUTADO, DATA_EXECUCAO,
     PESSOA_F_COD, PESSOA_J_COD, CONTRATO_COD, PRESTADOR_SERVICO_COD) VALUES
-- 1: OS de contrato, concluida
('Preventiva', 270.00, NULL,                  '2026-01-05', 3, 'Manutencao mensal programada',
 'Limpeza completa e troca de filtro dos aparelhos', '2026-01-05', NULL, 8, 1, 1),
-- 2: OS de contrato, concluida
('Instalacao', 740.00, 'Sala de exames',      '2026-02-08', 3, 'Instalar novo aparelho na sala de exames',
 'Instalacao do split e teste de funcionamento',    '2026-02-10', NULL, 9, 2, 2),
-- 3: OS de contrato, em andamento
('Corretiva',  NULL,   'Aguardando peca',     '2026-03-20', 2, 'Aparelho do quarto 205 nao gela',
 NULL,                                               NULL,         NULL, 10, 3, 3),
-- 4: OS avulsa (sem contrato), pessoa fisica, aberta e ainda sem prestador
('Corretiva',  NULL,   NULL,                  '2026-04-02', 1, 'Aparelho pingando agua dentro de casa',
 NULL,                                               NULL,         7, NULL, NULL, NULL),
-- 5: OS avulsa (sem contrato), empresa, concluida
('Corretiva',  530.00, 'Cliente sem contrato','2026-03-14', 3, 'Aparelho desliga sozinho',
 'Troca de capacitor e recarga de gas',              '2026-03-15', NULL, 12, NULL, 5),
-- 6: OS de contrato de pessoa fisica, em andamento
('Preventiva', 180.00, NULL,                  '2026-04-05', 2, 'Manutencao anual programada',
 NULL,                                               NULL,         6, NULL, 5, 1);
GO

-- ---------------------------------------------------------------------
-- 10) SERVICOS_REALIZADOS  (OS, servico)
-- ---------------------------------------------------------------------
INSERT INTO SERVICOS_REALIZADOS (OS_COD, SERVICO_COD) VALUES
(1, 1),
(1, 2),
(2, 3),
(5, 4),
(5, 5),
(6, 1);
GO
