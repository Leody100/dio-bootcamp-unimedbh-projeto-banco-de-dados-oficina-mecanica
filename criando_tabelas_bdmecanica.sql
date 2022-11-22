
create database mecanica;
use mecanica;
create table veiculo (
	idVeiculo int primary key auto_increment,
	placa varchar(45),
    modelo varchar(45),
    cor varchar(45),
	renavam varchar(45),
    anoFabricacao varchar(45),
	km_atual varchar(45)
);

insert into veiculo (placa, modelo, cor, renavam, anoFabricacao, km_atual) values
					 ('ABC0294','GOL','verde','010000000001', '2002','55400'),
                     ('ZXA1295','FUSCA','preto','012200000999', '1995','100400'),
                     ('ERT4294','POLO','azul','02000000444', '2012','20300'),
                     ('VBN5294','UNO','branco','33000005555', '1998','99200'),
                     ('UIO9234','COROLLA','cinza','078000123456','2019', '35700');
                     
   -- Acrescentado 2 carros para cliente que não aceitaram servico 
   insert into veiculo (placa, modelo, cor, renavam, anoFabricacao, km_atual) values
					 ('BBN5299','CIVIC','preto','33000005555', '2000','91200'),
                     ('JKO9331','POLO','verde','078011123456','2020', '25700');
                     
               select * from veiculo;  
               
create table equipeMecanico (
idequipeMecanico int primary key auto_increment,
nome varchar (150),
endereco varchar(150),
especialidade varchar(50)
);

insert into equipeMecanico (nome,endereco,especialidade)values
							('Leonardo Silva','Rua Jose Carvalho - Vila Barros- SP','mecânico'),
                            ('Amaral Figueiredo','Rua Cintra Lopes - Santa Clara - SP','mecânico'),
                             ('Carlos Souza','Av Lopes Coimbra - São Jorge - SP','eletrônica'),
                             ('Gustavo Machado','Av Andre Gomes- São Manuel - SP','eletrônica'),
                             ('Mario Prado','Rua Silveira - Vila Linda - SP','funilaria');  
select * from equipeMecanico ; 


create table cliente (
	idCliente int primary key auto_increment,
	nome varchar(150),
	endereco varchar(150),
	CPF_CNPJ varchar(45),
	telefone varchar(45),
    clienteVeiculo int,
    CONSTRAINT FK_clienteVeiculo_veiculo FOREIGN KEY (clienteVeiculo)
    REFERENCES veiculo(idVeiculo)
);

create table servicoAutorizado( 
	idServicoAutorizado int primary key auto_increment,
	mao_de_obra varchar (45),
	valor varchar(45),
	clienteAutoriza varchar(45),
	sAutorizadoCliente int,
	sAutorizadoMecanico int,
CONSTRAINT FK_sAutorizadoCliente_servicoAutorizado FOREIGN KEY (sAutorizadoCliente)
    REFERENCES cliente(idCliente),
    CONSTRAINT FK_sAutorizadoMecanico_AutorizadoMecanico FOREIGN KEY (sAutorizadoMecanico)
    REFERENCES equipeMecanico(idequipeMecanico)
);

insert into cliente (nome, endereco, CPF_CNPJ, telefone,clienteVeiculo)values
					('Jose Machado','Rua Carmelo - Parque Azul - SP','1234567891','99844882',1),
					('Maria Alcantra','Rua Azevedo Soarez - União - SP','987654321','89877892',2),
                    ('Leo Morais','Rua Mario Carvalho - Vila Nova- RJ','789123456','99974444',3),
                    ('Juca Silva','Av Conde Cardoso - Almirante - SP','789123456','99874892',4),
                     ('Marcela Prado','Av Esperança - Serra - RJ','99945631','21985474',5);
                    
-- inserindo 2 clientes não aceitando o servico,
insert into cliente (nome, endereco, CPF_CNPJ, telefone,clienteVeiculo)values
                      ('Leandro Queiroz','Av Brasil - Esperança - RJ','98945633','21985774',6),
                     ('Sergio Nogueira','Rua Nova Esperança -Gloria - SP','99945631','21985474',7);
   
   select * from cliente;


insert into servicoAutorizado (mao_de_obra, valor, clienteAutoriza,sAutorizadoCliente,sAutorizadoMecanico) values
					 ('troca de velas','500,00','sim',1,1),
                     ('troca amortecedor','400,00','sim',2,1),
                     ('troca altenador','600,00','sim',3,2),
                     ('troca embreagem','200,00','sim',4,2),
                     ('troca de motor de arranque','1100,00','sim',5,1);
     -- inserindo autorizacao negada  2 clientes              
insert into servicoAutorizado (mao_de_obra, valor, clienteAutoriza,sAutorizadoCliente,sAutorizadoMecanico) values 
						('troca de motor de arranque','1100,00','nao',6,1),
                        ('troca de velas','500,00','nao',7,2);
   
   
create table problemaInformado (
	idProblemaInformado int ,
	pIdescricao varchar(150),
	pIstatus varchar(150),
	pIcliente int,
    PRIMARY KEY (idProblemaInformado),
    CONSTRAINT FK_problema_informado_cliente FOREIGN KEY (pIcliente)
    REFERENCES cliente(idCliente)
);

insert into  problemaInformado(idProblemaInformado,pIdescricao,pIstatus,pIcliente ) values
					 (1, 'defeito de velas','aguardando teste',1),
                     (2, 'defeito amortecedor','aguardando peça',2),
                     (3, 'defeito altenador','testando',3),
                     (4, 'defeito embreagem','instação teste',4),
                     (5, 'defeito motor de arranque','aguardando peça',5);

                         
create table referenciaMaodeObra (
idreferenciaMaodeObra  int primary key auto_increment,
descricao_mao_de_obra varchar(70),
valor_mao_de_obra varchar(45)
);
insert into referenciaMaodeObra(descricao_mao_de_obra,valor_mao_de_obra)values
								('troca alternador','100'),
                                ('troca velas','80'),
                                ('troca embreagem','120'),
                                ('troca amortecedor','120'),
                                ('troca motor de arranque','300');
  select * from referenciaMaodeObra;      
  
  
create table ordemServico( 
	idOrdemServico int primary key auto_increment,
	codigo varchar (9),
	dataEmissao date,
	dataEntrega date,
	statusOrdem varchar(45),
	observacoes varchar(150),
	oscliente int,
	osreferencia_mao_de_obra int,
    CONSTRAINT FK_osreferencia_mao_de_obra_referenciaMaoObra FOREIGN KEY (osreferencia_mao_de_obra)
    REFERENCES referenciaMaodeObra (idreferenciaMaodeObra),
    CONSTRAINT FK_oscliente_servicoAutorizado FOREIGN KEY (oscliente)
    REFERENCES servicoAutorizado(idServicoAutorizado)
);

insert into ordemServico(codigo,dataEmissao,dataEntrega,statusOrdem,observacoes,oscliente,osreferencia_mao_de_obra) values
						('100200300','2002-10-24','2002-11-10','concluida',null,1,1),
                        ('100200301','2002-10-30','2002-11-15','concluida',null,2,2),
                        ('100200302','2002-11-05','2002-11-20','concluida',null,3,3),
						('100200303','2002-11-10','2002-11-30','concluida',null,4,4),
                        ('100200304','2002-12-04','2002-12-17','concluida',null,5,5);
select * from  ordemServico;   
    
create table produtoPeca (
idprodutoPeca  int primary key auto_increment,
nomeProduto varchar(45),
fornecedor varchar(70),
quantidade int,
valorProduto varchar(45)
);

insert into produtoPeca(nomeProduto, fornecedor,quantidade,valorProduto) values
						('amortecedor','Belo Amortecedores Ltda', 50 ,'1500'),
                        ('alternador','Morais Alternadores Ltda', 60 ,'1800'),
                        ('velas','Beto Velas S/A', 100, '2000'),
                        ('motor de arranque','Comercio Araujo Ltda', 100 ,'5000'),
                        ('embreagem','Comercio Araujo Ltda', 200,'3000');
                        
create table veiculoCliente (
	veiculoCliente int ,
	cliente_cliente int,
    CONSTRAINT FK_veiculoCliente_veiculo FOREIGN KEY (veiculoCliente)
    REFERENCES veiculo(idVeiculo),
    CONSTRAINT FK_Cliente_cliente FOREIGN KEY (cliente_cliente)
    REFERENCES cliente(idCliente)
);

insert into veiculoCliente (veiculoCliente, cliente_cliente) values
							(1, 1), (2, 2), (3, 3),(4, 4), 
                            (5, 5),(6, 6), (7, 7);
							
create table avaliaServico (
	avEquipeServico int ,
	avServico int,
    CONSTRAINT FK_avServico_Servico FOREIGN KEY (avServico)
    REFERENCES servicoAutorizado(idServicoAutorizado),
    CONSTRAINT FK_avEquipeServico_cliente FOREIGN KEY (avEquipeServico)
    REFERENCES equipeMecanico(idequipeMecanico)
);

insert into avaliaServico (avEquipeServico , avServico  ) values
										  (1, 8),(2,9),(3,10),(4,6),(5, 7);


create table cliente_mecanico (
	ofCliente int ,
    ofEquipemecanico int,
    CONSTRAINT FK_ofCliente_cliente FOREIGN KEY (ofCliente)
    REFERENCES cliente(idCliente),
    CONSTRAINT FK__cliente_equipeMecanico FOREIGN KEY (ofEquipemecanico)
    REFERENCES equipeMecanico(idequipeMecanico)
    
);

insert into cliente_mecanico ( ofCliente, ofEquipemecanico  ) values
								(1, 1),(2,1),(3,2),(4,2),(5, 1),(6,1),(7,2);

create table servicoAutorizado_ordemServico (
	sAServicoAutorizado int ,
	sAOrdemServico int ,
    CONSTRAINT FK_sAServicoAutorizado_Servico FOREIGN KEY (sAServicoAutorizado)
    REFERENCES ServicoAutorizado (idServicoAutorizado),
    CONSTRAINT FK_sAOrdemServico_ordemServico FOREIGN KEY (sAOrdemServico)
    REFERENCES ordemServico(idOrdemServico)
);

insert into servicoAutorizado_ordemServico (sAServicoAutorizado , sAOrdemServico ) values
										  (1, 1),(2,2),(3,3),(4,4),(5, 5);


create table produtoPeca_servicoAutorizado (
	pPecaProduto int ,
	pOrdemServicoAutorizado int ,
    CONSTRAINT FK_ppServicoAutorizado_produtoPecas FOREIGN KEY (pPecaProduto)
    REFERENCES produtoPeca (idprodutoPeca),
    CONSTRAINT FK_pOrdemServico_ordemServico FOREIGN KEY (pOrdemServicoAutorizado)
    REFERENCES ordemServico(idOrdemServico)
);
insert into produtoPeca_servicoAutorizado (pPecaProduto , pOrdemServicoAutorizado) values
										  (1, 1),(2,2),(3,3),(4,4),(5, 5);
                                         