-- 1) CADASTRO DE PESSOA FISICA
create procedure sp_CadPessoaFisica(
    @nome            varchar(100),
    @endereco        varchar(50),
    @cep             char(8),
    @numero          varchar(10),
    @cidade          varchar(50),
    @estado          char(2),
    @telefone        varchar(15),
    @cpf             char(11),
    @dataNascimento  date,
    @email           varchar(150) = null,
    @rg              char(15) = null
)
as
begin -- iniciando a procedure
    begin tran -- iniciando a transação
        begin try -- iniciando o try

            -- cadastrar os dados da pessoa
            insert into PESSOAS (ENDERECO, CEP, NUMERO, CIDADE, ESTADO, TELEFONE, NOME, EMAIL)
            values (@endereco, @cep, @numero, @cidade, @estado, @telefone, @nome, @email)

            -- declarar uma variavel para armazenar o id gerado
            declare @idPessoa int
            -- atribuir o valor do id
            set @idPessoa = SCOPE_IDENTITY() -- recupera o ultimo id gerado neste escopo

            -- cadastrar os dados da pessoa fisica
            insert into PESSOAS_FISICAS (PESSOA_FISICA_COD, CPF, RG, DATA_NASCIMENTO)
            values (@idPessoa, @cpf, @rg, @dataNascimento)

            -- deu tudo certo ==>> confirmar
            commit
            print 'Dados da pessoa fisica cadastrados com sucesso!'

        end try -- finaliza o try
        begin catch -- inicia o catch
            -- deu erro ===>> desfazer
            rollback
            print 'Dados da pessoa fisica não cadastrados! Erro: ' + ERROR_MESSAGE()
        end catch -- finaliza o catch
end
go


-- 2) CADASTRO DE PESSOA JURIDICA
create procedure sp_CadPessoaJuridica(
    @nome         varchar(100),
    @endereco     varchar(50),
    @cep          char(8),
    @numero       varchar(10),
    @cidade       varchar(50),
    @estado       char(2),
    @telefone     varchar(15),
    @cnpj         char(14),
    @razaoSocial  varchar(100),
    @email        varchar(150) = null
)
as
begin
    begin tran
        begin try

            -- cadastrar os dados da pessoa
            insert into PESSOAS (ENDERECO, CEP, NUMERO, CIDADE, ESTADO, TELEFONE, NOME, EMAIL)
            values (@endereco, @cep, @numero, @cidade, @estado, @telefone, @nome, @email)

            declare @idPessoa int
            set @idPessoa = SCOPE_IDENTITY()

            -- cadastrar os dados da pessoa juridica
            insert into PESSOAS_JURIDICAS (PESSOA_JURIDICA_COD, CNPJ, RAZAO_SOCIAL)
            values (@idPessoa, @cnpj, @razaoSocial)

            commit
            print 'Dados da pessoa juridica cadastrados com sucesso!'

        end try
        begin catch
            rollback
            print 'Dados da pessoa juridica não cadastrados! Erro: ' + ERROR_MESSAGE()
        end catch
end
go


-- 3) CADASTRO DE PRESTADOR DE SERVICOS (pessoa -> pessoa fisica -> prestador)
create procedure sp_CadPrestadorServico(
    @nome            varchar(100),
    @endereco        varchar(50),
    @cep             char(8),
    @numero          varchar(10),
    @cidade          varchar(50),
    @estado          char(2),
    @telefone        varchar(15),
    @cpf             char(11),
    @dataNascimento  date,
    @pagamento       decimal(10,2),
    @senha           varchar(255),
    @administrador   bit = 1,
    @email           varchar(150) = null,
    @rg              char(15) = null
)
as
begin
    begin tran
        begin try

            -- 1o: cadastrar os dados da pessoa
            insert into PESSOAS (ENDERECO, CEP, NUMERO, CIDADE, ESTADO, TELEFONE, NOME, EMAIL)
            values (@endereco, @cep, @numero, @cidade, @estado, @telefone, @nome, @email)

            declare @idPessoa int
            set @idPessoa = SCOPE_IDENTITY()

            -- 2o: cadastrar como pessoa fisica (usa o mesmo id)
            insert into PESSOAS_FISICAS (PESSOA_FISICA_COD, CPF, RG, DATA_NASCIMENTO)
            values (@idPessoa, @cpf, @rg, @dataNascimento)

            -- 3o: cadastrar como prestador de servicos (usa o mesmo id)
            insert into PRESTADOR_SERVICOS (PRESTADOR_COD, PAGAMENTO, ADMINISTRADOR, SENHA)
            values (@idPessoa, @pagamento, @administrador, @senha)

            commit
            print 'Dados do prestador de servicos cadastrados com sucesso!'

        end try
        begin catch
            rollback
            print 'Dados do prestador não cadastrados! Erro: ' + ERROR_MESSAGE()
        end catch
end
go


select * from PESSOAS

select *
from PESSOAS p	
inner join PESSOAS_FISICAS pf on p.COD_PESSOA = pf.PESSOA_FISICA_COD


select *
from PESSOAS p	
inner join PESSOAS_JURIDICAS pj on p.COD_PESSOA = pj.PESSOA_JURIDICA_COD

select *
from PESSOAS p
inner join PRESTADOR_SERVICOS ps on p.COD_PESSOA = ps.PRESTADOR_COD
inner join	PESSOAS_FISICAS pf on ps.PRESTADOR_COD = pf.PESSOA_FISICA_COD

-- pessoa fisica
exec sp_CadPessoaFisica
    @nome = 'Joao Silva', @endereco = 'Rua das Flores', @cep = '01001000',
    @numero = '100', @cidade = 'Sao Paulo', @estado = 'SP',
    @telefone = '11999998888', @cpf = '12345678901',
    @dataNascimento = '1990-05-20', @email = 'joao@email.com', @rg = '123456789'

-- pessoa juridica
exec sp_CadPessoaJuridica
    @nome = 'Climatiza Ar', @endereco = 'Av. Paulista', @cep = '01310100',
    @numero = '1500', @cidade = 'Sao Paulo', @estado = 'SP',
    @telefone = '1133334444', @cnpj = '12345678000199',
    @razaoSocial = 'Climatiza Ar Condicionado LTDA', @email = 'contato@climatiza.com'

-- prestador de servicos
exec sp_CadPrestadorServico
    @nome = 'Carlos Tecnico', @endereco = 'Rua B', @cep = '02002000',
    @numero = '45', @cidade = 'Sao Paulo', @estado = 'SP',
    @telefone = '11988887777', @cpf = '98765432100',
    @dataNascimento = '1985-03-10', @pagamento = 3500.00, @senha = 'minhaSenha123'
