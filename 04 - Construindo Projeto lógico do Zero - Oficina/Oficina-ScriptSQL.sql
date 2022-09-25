create database IF NOT EXISTS oficina;
use oficina;

-- Criar tabela Clientes
create table clientes(
	idClientes int auto_increment primary key,
	Nome varchar(45) not null,
    CPF char(11) not null,
    Endereço varchar(45),
    Telefone varchar(11)
);

-- Criar tabela Veiculo
create table veiculo(
	idVeiculo int primary key auto_increment,
    PlacaVeiculo char(7) not null,
    constraint placa_id_veiculo unique (idVeiculo, PlacaVeiculo)
);

-- Criar tabela Conserto
create table conserto(
	idConserto int primary key auto_increment,
    Descrição varchar(45) not null
);

-- Criar tabela Revisão
create table revisao(
	idRevisao int primary key auto_increment,
    Descrição varchar(45) not null
);

-- Criar tabela Mecanico
create table mecanico(
	idMecanico int primary key auto_increment,
    NomeMecanico varchar(45) not null,
    Telefone char(11) not null,
    Especialidade varchar(45)
);

-- Criar tabela Equipe Mecanico
create table equipeMecanico(
	idEquipeMecanico int primary key auto_increment
);

-- Criar tabela Ordem de Serviço
create table ordemServico(
	idOrdemServico int primary key auto_increment,
    DataEmissao date,
    ValorServico decimal(5,2) not null,
    ValorPeca decimal(5,2) not null,
    ValorTotal decimal(5,2) not null,
    Status enum('A fazer', 'Fazendo', 'Concluido', 'Cancelado'),
    DataConclusao date
);

-- Criar tabela Tabela Referencia
create table tabelaReferencia(
	idTabelaReferencia int primary key auto_increment,
    constraint fk_os_tab_ref foreign key (idTabelaReferencia) references ordemServico(idOrdemServico)
);

-- Criar tabela Autorização Cliente
create table autorizacaoCliente(
	idAutorizacaoCliente int primary key auto_increment,
	Autorizado boolean,
    constraint fk_aut_cliente foreign key (idAutorizacaoCliente) references clientes(idClientes),
    constraint fk_aut_veiculo foreign key (idAutorizacaoCliente) references veiculo(idVeiculo),
    constraint fk_aut_OS foreign key (idAutorizacaoCliente) references ordemServico(idOrdemServico)
);

-- Criar tabela Peças
create table pecas(
	idPecas int primary key auto_increment,
    Descrição varchar(45),
    Valor decimal(5,2)
);
-- Criar tabela OSPeças
create table oSPecas(
	idOSPecas int primary key auto_increment,
    constraint fk_pecas foreign key (idOSPecas) references pecas(idPecas),
    constraint fk_os_pecas foreign key (idOSPecas) references ordemServico(idOrdemServico)
);

create table servicos(
	idServicos int primary key auto_increment,
    Descrição varchar(45),
    Valor decimal(5,2)
);
-- Criar tabela OSServiços
create table oSServicos(
	idOSServicos int primary key auto_increment,
    constraint fk_servicos foreign key (idOSServicos) references servicos(idServicos),
    constraint fk_os_servicos foreign key (idOSServicos) references ordemServico(idOrdemServico)
);