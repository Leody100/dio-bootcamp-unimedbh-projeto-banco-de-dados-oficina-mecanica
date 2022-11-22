use mecanica;
-- recuperar o numero de clientes que eu tenho cadastrados
 select count(*) from Cliente; 
 select * from cliente;
 select * from  servicoAutorizado;
 
  
  -- recuperando Clientes que autorizaram o serviço
   select c.idcliente, c.nome  as nome , v.modelo as Veiculo, a.clienteAutoriza as Servico_Autorizado from cliente c 
   inner join servicoAutorizado a on c.idCliente = a.idServicoAutorizado
   inner join veiculo v on v.idVeiculo= c.clienteVeiculo
  where clienteAutoriza = 'sim' ;
 
   -- recuperando Clientes que nao autorizaram o serviço
   select c.idcliente, c.nome  as nome , v.modelo as Veiculo, a.clienteAutoriza as Servico_Autorizado from cliente c 
   inner join servicoAutorizado a on c.idCliente = a.idServicoAutorizado
   inner join veiculo v on v.idVeiculo= c.clienteVeiculo
   where clienteAutoriza = 'nao' ;
  
  -- Recuperar duracao codigo ordem de Servico 
   select codigo, DATEDIFF  (dataEntrega, dataEmissao) as tempo_do_serviço_em_dias  FROM ordemServico;
   
   
  select*from cliente_mecanico;