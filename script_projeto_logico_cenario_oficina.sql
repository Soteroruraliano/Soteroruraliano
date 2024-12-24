create database workshop;
use workshop;

create table clients(
  idClient int auto_increment primary key,
  Pname varchar(45) not null,
  Minit char(1) not null,
  Lname varchar(45) not null,
  CPF char(11) not null,
  Street varchar(45),
  Complement varchar(5),
  Neighborhood varchar(20),
  City varchar(20),
  State char(2)
  );
  
 create table car(
  idCar int auto_increment primary key,
  Record varchar(45),
  MadeDate date,
  Model varchar(45) not null,
  Marking varchar(45) not null,
  constraint unique_car unique(Record)
  );
  
  create table carParts(
   idCarParts int auto_increment primary key,
   Type_s varchar(45) not null,
   Availability enum('Disponível', 'Indisponível') default 'Disponível'
   );
   
  create table mechanics(
  idMechanic int auto_increment primary key,
  MName varchar(45) not null,
  MCode int not null,
  Speciality varchar(45) not null,
  Street varchar(45) not null,
  Complement varchar(5) not null,
  Neighborhood varchar(20) not null,
  City varchar(20) not null,
  State char(2)
  );
  
 create table serviceOrder(
  idsOrder int auto_increment primary key,
  Type_sO varchar(45),
  sONumber int not null,
  LaborValue float not null,
  Status_sO enum('Solicitada','Em andamento', 'Liberada') default 'Solicitada'
  );
  
  create table services(
   idServices int auto_increment primary key,
   idsClient int,
   idsCar int,
   idsOrder int,
   Status_services enum('Aguardando ordem de serviço', 'Realizando', 'Concluído') default 'Aguardando ordem de serviço',
   Status_payment enum('Pago', 'Não pago') default 'Não pago',
   StartService date,
   EndService date,
   constraint fk_services_clients foreign key (idsClient) references clients(idClient),
   constraint fk_services_car foreign key (idsCar) references car(idCar),
   constraint fk_services_serviceOrder foreign key (idsOrder) references serviceOrder(idsOrder)
   );
   
  create table partsOrderServices(
   idPCarParts int,
   idPOrder int, 
   Quantity int,
   PriceParts float,
   primary key (idPCarParts, idPOrder),
   constraint fk_pos_carParts foreign key (idPCarParts) references carParts(idCarParts),
   constraint fk_pos_serviceOrder foreign key (idPOrder) references serviceOrder(idsOrder)
   );
   
   create table emission(
    idEMechanic int,
    idEOrder int,
    EDate Date, 
    primary key (idEMechanic, idEOrder),
    constraint fk_emission_mechanics foreign key (idEMechanic) references mechanics(idMechanic),
    constraint fk_emission_serviceOrder foreign key (idEOrder) references serviceOrder(idsOrder)
    );
    
    show tables;
    alter table clients auto_increment = 1;
    alter table car auto_increment = 1;
    alter table carParts auto_increment = 1;
    alter table mechanics auto_increment = 1;
    alter table serviceOrder auto_increment = 1;
    alter table services auto_increment = 1;
    
    
  
  
   
   
  
  