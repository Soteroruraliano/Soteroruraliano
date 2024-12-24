-- insercao dos dados
use workshop;

-- Pname, Minit, Lname, CPF, Street, Complement, Neighborhood , City, State
insert into clients (Pname, Minit, Lname, CPF, Street, Complement, Neighborhood , City, State)
       values ('Itamar', 'B', 'Santos', 07135724098, 'Recanto do Cisal', '45', 'Nova Olaria', 'Iguaraçuá', 'BA'),
			  ('Josyane', 'L', 'Prado', 75649123036, 'Riraleira', '219', 'Marva Branca', 'Iguaraçuá', 'BA'),
			  ('Heitor', 'R', 'Campos', 96847111279, 'Riraleira', '61', 'Marva Branca', 'Iguaraçuá', 'BA'),
			  ('Angie', 'A', 'Souza', 75347900973, 'Santa Tereza', '13', 'Alto da Ribeira', 'Celilândia', 'BA'),
			  ('Edcarlos', 'L', 'Santos', 00948576629, 'Recanto do Cisal', '107', 'Nova Olaria', 'Iguaraçuá', 'BA'),
			  ('Aloísio', 'B', 'Costa', 08932567018, null, null, null, 'Montes Claros',  'MG');

-- Record, MadeDate, Model, Marking
insert into car (Record, MadeDate, Model, Marking)
       values ('CSP 9F23', '1970-03-16', 'OpalaSS', 'Chrevrolet'),
			  ('WRK 5N18', '1976-12-02','Maverick', 'Ford'),
			  ('ALQ 2C11', '1980-07-23', 'Mustang', 'Ford'),
			  ('XRV 0I62', '1990-09-14', 'Caravan', 'Chevrolet'),
			  ('HFD 7J35', '1975-02-01', 'Fusca', 'Volkswagen'),
			  ('TBU 4Y69', '1973-05-25','Chevette', 'Chevrolet');
                       
-- Type_s, Availability
insert into carParts (Type_s, Availability)
       values ('Farol', 'Disponível'),
			  ('Parabrisa', 'Disponível'),
			  ('Vela', 'Disponível'),
			  ('Câmbio manual', 'Disponível'),
			  ('Bomba de combustível', 'Disponível'),
			  ('Junta do cabeçote', 'Indisponível');
                            
 -- MName, MCode, Speciality, Street, Complement, Neighborhood, City, State
insert into mechanics (MName, MCode, Speciality, Street, Complement, Neighborhood, City, State)
       values ('Armandio', 13, 'Mecânica geral', 'Canta Galo', 11, 'Morada das Raposas', 'Jaburiú', 'BA' ),
			  ('Jota', 03, 'Funilaria', 'Terraceamento dos Tatus', 220, 'Paz das caças', 'Atirador Dalí', 'AL'),
			  ('Joicinho', 09, 'Motor e transmissão', 'Lagoa dos sapos', 136, 'Cantadeira', 'Rio Vermelho', 'SE'),
			  ('Fubá', 11, 'Elétrico e eletrônico', 'Miguel Calmon', 02, 'Primavera', 'Itabuna', 'BA');
                             
-- Type_sO, sONumber, LaborValue, Status_sO
insert into serviceOrder (Type_sO, sONumber, LaborValue, Status_sO)
       values ('Troca e farol', 1, 87.0, 'Solicitada'),
			  ('Troca do parabrisa', 2, 360.0, 'Em andamento'),
			  ('Troca de velas', 3, 50.0, 'Liberada'),
			  ('Reparo do câmbio', 4, 140.0, 'Liberada'),
			  ('Troca da bomba de combustível', 5, 60.0, 'Liberada'),
			  ('Troca da junta', 6, 480.0, 'Em andamento');
                                
-- idsClient, idsCar, idsOrder, Status_services, Status_payment, StartService, EndService
insert into services (idsClient, idsCar, idsOrder, Status_services, Status_payment, StartService, EndService)
       values (1, 1, 1, 'Aguardando ordem de serviço', 'Não pago', null, null),
			  (2, 2, 2, 'Realizando', 'Não pago', '2024-05-13', null),
			  (3, 3, 3, 'Concluído', 'Pago', '2024-03-01', '2024-03-01'),
			  (4, 4, 4, 'Concluído', 'Pago', '2024-03-17', '2024-03-25'),
			  (5, 5, 5, 'Concluído', 'Pago', '2024-03-31', '2024-04-04'),
			  (6, 6, 6, 'Realizando', 'Não pago', '2024-06-14', null);
                            
-- idPCarParts, idPOrder, Quantity, PriceParts
insert into partsOrderServices (idPCarParts, idPOrder, Quantity, PriceParts)
       values (4, 4, null, null),
			  (3, 3, 2, 35.6),
			  (5, 5, 1, 87.6),
			  (1, 1, 2, 2000),
			  (6, 6, 1, 3250),
			  (2, 2, 1, 919.9);
                                      
-- idEMechanic, idEOrder, EDate
insert into emission (idEMechanic, idEOrder, EDate)
       values (1, 1, null),
			  (2, 2, '2024-05-13'),
			  (3, 3, '2024-03-01'),
			  (3, 4, '2024-03-17'),
			  (4, 5, '2024-03-31'),
			  (3, 6, '2024-06-14');
              
select * from clients;
select * from car;
select * from carParts;
select * from mechanics;
select * from serviceOrder;
select * from services;
select * from partsOrderServices;
select * from emission;

--
--
-- consultas
--
--
-- Qual o nome, o código e a especialidade dos mecânicos que concluíram os serviços designados?
select MName, MCode, Speciality, Status_services 
from mechanics, services
where idMechanic = idsOrder and Status_services = 'Concluído'
order by Mcode;

-- Qual a placa e o nome completo do proprietário do Chevette?
select concat(Pname, ' ', Minit, ' ',Lname) as CompleteName, Record, Model
from clients, car
where idClient = idCar and Model = 'Chevette';

-- Quais os valores da mão-de-obra e o tipo de serviço para os clientes que gastaram entre 1000 e 2000 reais em peças
select concat(Pname, ' ', Minit, ' ',Lname) as CompleteName, Type_sO, LaborValue, PriceParts
from serviceOrder inner join partsOrderServices
inner join clients
on idsOrder = idPCarParts and idPOrder = idClient
having PriceParts between 1000 and 2000;


