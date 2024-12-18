-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address)
       values ('Maria', 'M', 'Silva', '12346789', 'rua silva de prata 29, Carangola - Cidade das flores'),
              ('Matheus', 'O', 'Pimentel', '987654321', 'rua alameda 289, Centro - Cidade das flores'),
              ('Ricardo', 'F', 'Silva', '45678913', 'avenida alameda vinha 1009, Centro - Cidade das flores'),
              ('Julia', 'S', 'França', '789123456', 'rua laranjeiras 861, Centro - Cidade das flores'),
              ('Roberta', 'G', 'Assis', '98745631', 'avenida de koller, Centro - Cidade das flores'),
              ('Isabela', 'M', 'Cruz', '654789123', 'rua alameda das flores 28, Centro - Cidade das flores');
              
-- idProduct, Pname, classification_kids, Category('Eletrônico', ''Vestimenta, 'Brinquedos', 'Alimentos', 'Móveis'), avaliation,
-- Size, PPrice
insert into product (Pname, classification_kid, Category, Avaliation, Size, PPrice)
	   values ('Fone de ouvido', false, 'Eletrônico', '4', null, 25.0),
			  ('Barbie Elsa', true, 'Brinquedos', '3', null, 80.8),
              ('Body Carters', true, 'Vestimenta', '5', null, 119.9),
              ('Microfone Vedo - Youtuber', false, 'Eletrônico', '4', null, 140.9),
              ('Sofá retrátil', false, 'Móveis', '3', '3x57x80', 689.9),
              ('Farinha de arroz', false, 'Alimentos', '2', null, 9.38),
              ('Fire Stick Amazon', false, 'Eletrônico', '3', null, 90.0);

select * from clients;
select * from product;

-- idOrder, idOrderClient, orderStatus, orderDescription, freight
insert into orders (idOrderClient, orderStatus, orderDescription, freight) 
       values (1, default, 'compra via aplicativo', null),
			  (2, default, 'compra via aplicativo', 50),
              (3, 'Confirmado', null, null),
              (4, default, 'compra via web site', 150);
              
-- typePayment, limitAvailable
insert into payments (idClient, typePayment, limitAvailable)
       values (1, null, 1200.0),
              (2, null, 50.7),
              (3, 'Crédito', 3000.5),
              (4, null, 650.0);
              
              
select * from orders;
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
	values (1, 1, 2, null),
		   (2, 1, 1, null),
           (3, 2, 2, null);

-- storageLocation, quantity
insert into productStorage (storageLocation, quantity)
       values ('Rio de Janeiro', 1000),
              ('Rio de Janeiro', 500),
              ('São Paulo', 10),
              ('São Paulo', 100),
              ('São Paulo', 10),
              ('Brasília', 60);
              
-- idSupplier, SocialName, CNPJ, Contact
insert into supplier (SocialName, CNPJ, Contact) 
	   values ('Almeida e filhos', 123456789123456,'21985474'),
              ('Eletrônicos Silva', 854519649143457,'21985484'),
              ('Eletrônicos Valma', 934567893934695,'21975474');
              
select * from supplier;
-- idLproduct, idLstorage, Location
insert into storageLocation (idLproduct, idLstorage, Location)
       values (1, 2, 'RJ'),
			  (2, 6, 'GO');
              
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity)
	   values (1, 1, 500),
              (1, 2, 400),
              (2, 4, 633),
              (3, 3, 5),
              (2, 5, 10);
              
-- idSeller, SocialName, Absname, CNPJ, CPF, Location, Contact
insert into seller (SocialName, AbstName, CNPJ, CPF, Location, Contact)
       values ('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
              ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
              ('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);
              
select * from seller;
-- idPseller, isProduct, prodQuantity
insert into productSeller (idPseller, idProduct, prodQuantity)
       values (1, 6, 80),
			  (2, 7, 10);

-- consultas
select * from productSeller;
select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname, ' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, freight, paymentCash) 
       values (2, default, 'compra via aplicativo', null, 1);
       
select count(*) from clients c, orders o 
         where c.idClient = idOrderClient;
         
select * from clients left outer join orders ON idClient = idOrderClient;

-- recuperação de pedido com produto associado
select * from clients c inner join orders o ON c.idClient = o.idOrderClient
                        inner join productOrder p  on p.idPOorder = o.idOrder;

-- recuperar quantos pedidos foram realizados pelos clientes
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
                        inner join orders o ON c.idClient = o.idOrderClient
                        group by idClient;         

--                        
-- nome e endereço dos clientes que fizeram seus pedidos com base nos pagamentos efetuados
--

select concat(Fname, ' ', Lname) as NameClient, Address from clients c, payments p
       where(c.idClient = p.idClient)
       order by NameClient;
       
select concat(Fname, ' ', Lname) as NameClient, Address 
       from clients inner join payments using (idClient)
       order by NameClient;
	
-- Nome e CPF dos clientes que optam por pagamento via crédito

select concat(Fname, ' ',Lname) as Complete_name, CPF, typePayment from clients c, payments p 
having typePayment = 'Crédito';