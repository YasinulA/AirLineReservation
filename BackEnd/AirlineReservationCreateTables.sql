--Creating the Flight table
CREATE TABLE Flight (
  Flight_ID 	        varchar2(5)   NOT NULL,
  Flight_Destination  varchar2(25)  NOT NULL,
  Flight_Source       varchar2(25)  NOT NULL,
  Airline	            varchar2(15)  NOT NULL,
  Flight_Date	        date          NOT NULL,
  Flight_Cost	        number(7,2)	  NOT NULL,
  Flight_Capacity     number(3)	    NOT NULL,
  Flight_Departure    varchar2(20)  NOT NULL,
  Flight_Arrival      varchar2(20)  NOT NULL,
  Flight_Duration     varchar2(20)  NOT NULL,

  CONSTRAINT pk_flight_id PRIMARY KEY(Flight_ID)
);

CREATE SEQUENCE seq_flight START WITH 1000 INCREMENT BY 1;

--------------------------------------------------------------------------------
--Creating the Customer table
CREATE TABLE Customer (
  Cust_ID       varchar2(5)   NOT NULL,
  Cust_LName    varchar2(15)  NOT NULL,
  Cust_FName    varchar2(15)  NOT NULL,
  Cust_Email    varchar2(50)  NOT NULL,
  Cust_Phone    varchar2(12)  NOT NULL,
  Address       varchar2(20)  NOT NULL,
  City          varchar2(15)  NOT NULL,
  State         varchar2(2)   NOT NULL,
  Zip           varchar2(5)   NOT NULL,
  
  CONSTRAINT pk_cust_id PRIMARY KEY(Cust_ID)
);

CREATE SEQUENCE seq_customer START WITH 2000 INCREMENT BY 1;

--------------------------------------------------------------------------------
--Creating bridge table Reservations
CREATE TABLE Reservation (
  Reservation_ID  varchar2(5)  NOT NULL,
  Flight_ID       varchar2(5)  NOT NULL,
  Cust_ID         varchar2(5)  NOT NULL,
  
  CONSTRAINT pk_reservation_id PRIMARY KEY(Reservation_ID),
  
  CONSTRAINT fk_flight_id FOREIGN KEY(Flight_ID) 
  REFERENCES Flight(Flight_ID),
  
  CONSTRAINT fk_cust_id FOREIGN KEY(Cust_ID)
  REFERENCES Customer(Cust_ID)
);

CREATE SEQUENCE seq_reservation START WITH 3000 INCREMENT BY 1;

--------------------------------------------------------------------------------
--Alter table commands
ALTER TABLE reservation
  ADD Num_Of_Passengers number(2) NOT NULL;
--MODIFY airline varchar2(25);
DROP SEQUENCE seq_reservation;