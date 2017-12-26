--Inserting into Customer table
insert into customer values (seq_customer.NEXTVAL, 'Smith', 'John', 
  'jsmith87@yahoo.com', '212-568-1452', '300 Jay St', 'Brooklyn', 'NY', 
  '10012');

insert into customer values (seq_customer.NEXTVAL, 'Allen', 'Barry', 
  'damnitbarry@aol.com', '566-587-1125', '3720 Prince St', 'Queens', 'NY', 
  '11378');

insert into customer values (seq_customer.NEXTVAL, 'Queen', 'Oliver', 
  'shooters@hotmail.com', '367-985-1679', '99-41 E 80th St', 'New York', 'NY', 
  '10075');

insert into customer values (seq_customer.NEXTVAL, 'Denvers', 'Kara', 
  'kryptonian@hotmail.com', '718-468-6969', '130 Livingston Ave', 
  'New Burnswick', 'NJ', '08901');

insert into customer values (seq_customer.NEXTVAL, 'Steinfield', 'Haley', 
  'haleys@gmail.com', '555-681-8579', '322 La France Ave', 'Alhambra', 'CA', 
  '91801');
  
insert into customer values (seq_customer.NEXTVAL, 'Tucker', 'Chris', 
  'tuckerc@aol.com', '321-887-3594', '9333 W 3rd St', 'Beverly Hills', 'CA', 
  '90210');
  
insert into customer values (seq_customer.NEXTVAL, 'Lannister', 'Cersi', 
  'evillady@aol.com', '259-654-2252', '4140 Cesar Chavez St', 'San Francisco', 
  'CA', '94131');
  
insert into customer values (seq_customer.NEXTVAL, 'Stark', 'Rickon', 
  'raven3eye@hotmail.com', '877-658-1143', '4439 N Whipple St', 'Chicago',
  'IL', '60625');
  
insert into customer values (seq_customer.NEXTVAL, 'S.', 'Ashwin', 
  'asatya@citytech.cuny.edu', '929-585-6547', '300 Jay St', 'Brooklyn', 'NY', 
  '11201');

--------------------------------------------------------------------------------
--Inserting into Flight table
insert into flight values (seq_flight.NEXTVAL, 'Chicago', 'New York City', 
  'Delta', '05-JAN-2018', 225, 50, '16:00', '19:00', '3 Hours');

insert into flight values (seq_flight.NEXTVAL, 'Los Angeles', 'New York City', 
  'Virgin America', '08-JAN-2018', 335, 90, '11:00', '18:00', '7 Hours');
  
insert into flight values (seq_flight.NEXTVAL, 'Chicago', 'New York City', 
  'Delta', '05-JAN-2018', 200, 60, '20:00', '23:00', '3 Hours');

insert into flight values (seq_flight.NEXTVAL, 'Los Angeles', 'New York City', 
  'Jet Blue', '08-JAN-2018', 400, 80, '7:00', '13:20', '6 Hours 20 Minutes');
  
insert into flight values (seq_flight.NEXTVAL, 'Los Angeles', 'New York City', 
  'American Airlines', '08-JAN-2018', 360, 90, '9:40', '16:00', 
  '7 Hours 20 Minutes');
  
insert into flight values (seq_flight.NEXTVAL, 'Philadelphia', 'New York City', 
  'American Airlines', '08-JAN-2018', 150, 90, '9:40', '11:00', 
  '1 Hour 20 Minutes');
  
insert into flight values (seq_flight.NEXTVAL, 'Philadelphia', 'New York City', 
  'Jet Blue', '08-JAN-2018', 115, 60, '14:30', '16:00', '1 Hour 30 Minutes');

insert into flight values (seq_flight.NEXTVAL, 'Philadelphia', 'Chicago', 
  'Jet Blue', '15-JAN-2018', 330, 50, '13:30', '16:00', '2 Hours 30 Minutes');
  
insert into flight values (seq_flight.NEXTVAL, 'Los Angeles', 'Philadelphia', 
  'Delta', '15-JAN-2018', 385, 40, '12:00', '18:45', '6 Hours 45 Minutes');
  
insert into flight values (seq_flight.NEXTVAL, 'New York City', 'San Francisco', 
  'Delta', '05-JAN-2018', 420, 40, '11:00', '18:45', '7 Hours 45 Minutes');  
  
insert into flight values (seq_flight.NEXTVAL, 'New York City', 'Houston', 
  'American Airlines', '08-JAN-2018', 205, 80, '15:00', '18:15', 
  '3 Hours 15 Minutes');  
  
insert into flight values (seq_flight.NEXTVAL, 'Houston', 'Miami', 
  'Virgin America', '08-JAN-2018', 290, 50, '21:00', '23:30', 
  '2 Hours 30 Minutes'); 
  
insert into flight values (seq_flight.NEXTVAL, 'San Francisco', 'Chicago', 
  'Virgin America', '15-JAN-2018', 240, 70, '19:00', '24:00', '5 Hours'); 
  
insert into flight values (seq_flight.NEXTVAL, 'New York City', 'Miami', 
  'Jet Blue', '05-JAN-2018', 150, 50, '11:00', '14:00', '3 Hours'); 
  
insert into flight values (seq_flight.NEXTVAL, 'Philadelphia', 'Los Angeles', 
  'Jet Blue', '15-JAN-2018', 270, 70, '19:00', '24:00', '5 Hours 30 Minutes'); 

--------------------------------------------------------------------------------
--Inserting into the Reservation Table
insert into reservation values (seq_reservation.NEXTVAL, '1000', '2000', 2);

insert into reservation values (seq_reservation.NEXTVAL, '1000', '2001', 4);

insert into reservation values (seq_reservation.NEXTVAL, '1000', '2003', 5);

insert into reservation values (seq_reservation.NEXTVAL, '1000', '2007', 1);

insert into reservation values (seq_reservation.NEXTVAL, '1000', '2005', 3);

insert into reservation values (seq_reservation.NEXTVAL, '1013', '2000', 2);

insert into reservation values (seq_reservation.NEXTVAL, '1008', '2007', 1);

insert into reservation values (seq_reservation.NEXTVAL, '1010', '2000', 2);

insert into reservation values (seq_reservation.NEXTVAL, '1009', '2007', 1);

insert into reservation values (seq_reservation.NEXTVAL, '1015', '2007', 1);

insert into reservation values (seq_reservation.NEXTVAL, '1013', '2003', 5);

insert into reservation values (seq_reservation.NEXTVAL, '10', '20', );