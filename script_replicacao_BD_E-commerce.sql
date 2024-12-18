-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;
-- criar tabela cliente
create table clients(
         idClient int auto_increment primary key,
         Fname varchar(10),
         Minit varchar(3),
         Lname varchar (20),
         CPF char(11) not null,
         Address varchar(255),
         constraint unique_cpf_client unique (CPF)
);

desc clients;
alter table clients auto_increment = 1;
-- desc clients;         
-- criar tabela produto
create table product(
         idProduct int auto_increment primary key,
         Pname varchar(45) not null,
         Classification_kid boolean default false,
         Category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
         Avaliation float default 0,
         Size varchar(10),
         PPrice float
); 
            
alter table product auto_increment = 1;
-- para ser continuado no desafio: termine de impelmentar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no esquema relacional
-- criar constraints relacionadas ao pagamento
create table payments(
		 idClient int,
		 idPayment int auto_increment,
         typePayment enum('Boleto', 'Crédito', 'Débito'),
         limitAvailable float,
		 primary key (idClient, idPayment),
         constraint fk_payments_client foreign key (idPayment) references clients(idClient)
);

alter table payments auto_increment = 1; 
-- criar tabela pedido
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        freight float default 10,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
               on update cascade
);

desc orders;
alter table orders auto_increment = 1;
desc orders;
-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
        Storagelocation varchar(255) not null,
        Quantity int default 0 
);

alter table productStorage auto_increment = 1;
-- criar tabela fornecedor
create table supplier(
        idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        Contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

desc supplier;
alter table supplier auto_increment = 1;
desc supplier;
-- vendedor
 create table seller(
        idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        Location varchar(255),
        Contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);
      
alter table seller auto_increment = 1;
create table productSeller(
        idPseller int,
        idProduct int,
        prodQuantity int default 1,
        primary key (idPseller, idProduct),
        constraint fk_prodseller_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_prodseller_product foreign key (idProduct) references product(idProduct)
);

desc productSeller;
create table productOrder(
        idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_prodorder_product foreign key (idPOproduct) references product(idProduct),
        constraint fk_prodorder_orders foreign key (idPOorder) references orders(idOrder)
);
        
create table storageLocation(
        idLproduct int,
        idLstorage int,
        Location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storlocation_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storlocation_prodstor foreign key (idLstorage) references productStorage(idProdStorage)
);

show tables;
create table productSupplier(
        idPsSupplier int,
        idPsProduct int,
        Quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);


desc productSupplier;
show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

--
-- consultas SQL
--

	