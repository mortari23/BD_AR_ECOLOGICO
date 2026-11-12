---------------------------------------------------
-- Table-valued function
---------------------------------------------------
-- Table-valued function : retorna uma tabela
---------------------------------------------------

---------------------------------------------------
--
--




use Vendas_INFOM262
go








create function fc_CaclEstoqueMinimo(@min int)
RETURNS table
as
	return (
				select idProduto, descricao, qtd, valor
				from Produtos
				where qtd <= @min
		   )
go

-- testar a função
-- o mínimo de 10 qtds de Produtos
select * from dbo.fc_CaclEstoqueMinimo(10)
go

------------------------------------------------------------------------------------
-- 2) O gerente deseja saber todos os pedidos feitos em um determinado mês.
-- Para isso solicitou ao DBA que fizesse uma função para trazer os dados desejados.
-- Criar uma função para atender as necessidades do gerente.
-- Saída de dados: id, data, valor, status
------------------------------------------------------------------------------------

create function fc_ConsultaPedidos(@mes int, @ano int)
RETURNS table
as
	RETURN  (
				select idPedido, data, valor, status
				from Pedidos
				where MONTH(data) = @mes      and YEAR(data) = @ano
			)
go


-- testar a função
-- consultar os pedidos de fevereiro de 2026
select * from dbo.fc_ConsultaPedidos(2,2026)
go

------------------------------------------------------------------------------------
-- FUNCTION
------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- Multi-statement Table-valued function: retorna uma variável do tipo tabela com 
-- colunas definidas pelo DBA.
-- Vantagem: o DBA pode definir as colunas que ele deseja consultar e trazer resultados
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- 1) Criar uma função que retorne todos os produtos com preço acima de um valor recebido
-- por parâmetro.
-- Saída de Dados: id, descrição, valor, quantidade dos produtos
-- Os dados devem ser retornados em uma variável tipo tabela
-----------------------------------------------------------------------------------------

create function fc_ConsultaProdutos(@valor decimal(10,2))
RETURNS @TbProd table    (
							  idProd      int,
							  descr		  varchar(100),
							  qtd		  int,
							  valor		  decimal(10,2)
						 )
as
begin
			-- inserir os dados na variável do tipo table
			insert into @TbProd
				select idProduto, descricao, qtd, valor
				from Produtos
				where valor > @valor
			return
end

-- testar a função
select * from fc_ConsultaProdutos(1500.00)
go

------------------------------------------------------------------------------------
-- 2) Criar uma função que retorna toos os pedidos feitos por um vendedor.
-- Saída de Dados: id, data, valor, status do pedido, id e nome do vendedor
-- Usar as Tabelas: Pessoas e Pedidos
------------------------------------------------------------------------------------

create function fc_ConsultaPedidoVendedor(@idVend int)
RETURNS @TB_PedVend  table(	idPad		int,
							data		datetime,
							valor		decimal(10,2),
							status		int,
							idVend		int,
							Vendedor	varchar(50)
						  )
as 
begin
	-- inserir os dados na variável do tipo tabela
	insert into @TB_PedVend
		select Pe.idPedido, Pe.data, Pe.valor, Pe.status, Pe.vendedorId, P.nome
		from   Pedidos Pe		INNER JOIN		Pessoas P
		ON	   Pe.vendedorId = P.idPessoa
		where  Pe.vendedorId = @idVend
	return
end
go

-- testar a função
-- consultar todos os pedidos do vendedor 20
select * from dbo.fc_ConsultaPedidoVendedor(20)
go