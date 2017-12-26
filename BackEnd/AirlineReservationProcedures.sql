--Procedure: Customers#1
CREATE OR REPLACE PROCEDURE new_customer (
  v_Lname   IN customer.cust_lname%TYPE, 
  v_Fname   IN customer.cust_fname%TYPE,
  v_email   IN customer.cust_email%TYPE,
  v_phone   IN customer.cust_phone%TYPE,
  v_address IN customer.address%TYPE,
  v_city    IN customer.city%TYPE,
  v_state   IN customer.state%TYPE,
  v_zip     IN customer.zip%TYPE
)
IS
  v_id customer.cust_id%TYPE;
BEGIN
  v_id := seq_customer.NEXTVAL;
  
  INSERT INTO customer (cust_id, cust_lname, cust_fname, cust_email, cust_phone, 
    address, city, state, zip)
  VALUES(v_id, v_Lname, v_Fname, v_email, 
    v_phone, v_address, v_city, v_state, v_zip);
   
  DBMS_OUTPUT.PUT_LINE('Congratulations you have successfully registered.');
  DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_id);
  DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_Lname);
  DBMS_OUTPUT.PUT_LINE('First Name: ' || v_Fname);
  DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
  DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
  DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
  DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
  DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
  DBMS_OUTPUT.PUT_LINE('Zip: ' || v_zip);
END;

SET serveroutput ON;
EXECUTE new_customer ('S.', 'A', 'asatya@citytech.cuny.edu', '929-585-6547', '300 Jay St', 'Brooklyn', 'NY', '11201');

--------------------------------------------------------------------------------
--Procedure: Customer#2
CREATE OR REPLACE PROCEDURE flight_search (
  v_destination IN flight.flight_destination%TYPE,
  v_source      IN flight.flight_source%TYPE,
  v_date        IN flight.flight_date%TYPE
)
IS
  v_flight_id         flight.flight_id%TYPE;
  v_airline           flight.airline%TYPE;
  v_flight_cost       flight.flight_cost%TYPE;
  v_flight_capacity   flight.flight_capacity%TYPE;
  v_flight_departure  flight.flight_departure%TYPE;
  v_flight_arrival    flight.flight_arrival%TYPE;
  v_flight_duration   flight.flight_duration%TYPE;
  
  CURSOR search_flight IS 
    SELECT flight_id, airline, flight_cost, flight_capacity, flight_departure, 
      flight_arrival, flight_duration 
    FROM flight
    WHERE flight_destination = v_destination
    AND flight_source = v_source
    AND flight_date = v_date;
BEGIN
  OPEN search_flight;
    LOOP
      FETCH search_flight INTO v_flight_id, v_airline, v_flight_cost, 
        v_flight_capacity, v_flight_departure, v_flight_arrival, 
        v_flight_duration;
      EXIT WHEN search_flight%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Flight No: ' || v_flight_id || ' '); 
        DBMS_OUTPUT.PUT_LINE('To: ' || v_destination || ' ');
        DBMS_OUTPUT.PUT_LINE('From: ' || v_source || ' ');
        DBMS_OUTPUT.PUT_LINE('Airline: ' || v_airline || ' ');
        DBMS_OUTPUT.PUT_LINE('Date of Flight: ' || v_date || ' ');
        DBMS_OUTPUT.PUT_LINE('Price: $' || v_flight_cost || ' ');
        DBMS_OUTPUT.PUT_LINE('Total Seats: ' || v_flight_capacity || ' ');
        DBMS_OUTPUT.PUT_LINE('Departure: ' || v_flight_departure || ' ');
        DBMS_OUTPUT.PUT_LINE('Arrival: ' || v_flight_arrival || ' ');
        DBMS_OUTPUT.PUT_LINE('Duration of Flight: ' ||v_flight_duration || ' ');
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
  CLOSE search_flight;
END;

SET serveroutput ON;
EXECUTE flight_search ('Houston', 'Miami', '08-JAN-2018');

--------------------------------------------------------------------------------
--Trigger#1 for extra credit.
CREATE OR REPLACE TRIGGER seat_subtract 
  AFTER
  INSERT or UPDATE
  OF num_of_passengers
  ON reservation 
  FOR EACH ROW
DECLARE
  v_passengers  reservation.num_of_passengers%TYPE;
  v_flight_id   reservation.flight_id%TYPE;
BEGIN
  v_passengers  := :NEW.num_of_passengers;
  v_flight_id   := :NEW.flight_id;

  UPDATE flight
  SET flight_capacity = flight_capacity - v_passengers
  WHERE flight.flight_id = v_flight_id;
END;

--Trigger#2 for extra credit.
CREATE OR REPLACE TRIGGER seat_add 
  AFTER
  DELETE or UPDATE
  OF num_of_passengers
  ON reservation 
  FOR EACH ROW
DECLARE
  v_passengers  reservation.num_of_passengers%TYPE;
  v_flight_id   reservation.flight_id%TYPE;
BEGIN
  v_passengers  := :OLD.num_of_passengers;
  v_flight_id   := :OLD.flight_id;

  UPDATE flight
  SET flight_capacity = flight_capacity + v_passengers
  WHERE flight.flight_id = v_flight_id;
END;

--------------------------------------------------------------------------------
--Procedure: Customer#3
CREATE OR REPLACE PROCEDURE book_flight (
  v_f_id  flight.flight_id%TYPE,  
  v_c_id  customer.cust_id%TYPE,
  v_seats reservation.num_of_passengers%TYPE
) 
IS
  v_reservation reservation.reservation_id%TYPE;
  v_capacity    flight.flight_capacity%TYPE;
BEGIN
  v_reservation := seq_reservation.NEXTVAL;
  
  SELECT flight_capacity
  INTO v_capacity
  FROM flight
  WHERE flight_id = v_f_id;
  
  IF (v_capacity = 0) then
    DBMS_OUTPUT.PUT_LINE('Flight capacity is at max. We apologize for the inconvinience.');
  ELSIF (v_seats > v_capacity) then
    DBMS_OUTPUT.PUT_LINE('You are trying to book more than the total seat available at this flight.');
  ELSE  
    INSERT INTO reservation (reservation_id, flight_id, cust_id, 
      num_of_passengers)
    VALUES (v_reservation, v_f_id, v_c_id, v_seats);
    
    DBMS_OUTPUT.PUT_LINE('Congratulations! Customer ' || v_c_id || 
      ' Your booking for flight ' || v_f_id || ' for ' || v_seats || 
      ' person is now confirmed.');
    DBMS_OUTPUT.PUT_LINE('Your reservation number is ' || v_reservation || '.');
    DBMS_OUTPUT.PUT_LINE(' ');
  END IF;
END;

SET serveroutput ON;
EXECUTE book_flight('1012', '2015', 26);

DELETE FROM reservation 
WHERE reservation_id = '';

--------------------------------------------------------------------------------
--Procedure: Customer#4
CREATE OR REPLACE PROCEDURE list_booking (
  v_c_id customer.cust_id%TYPE
)
IS
  v_reservation reservation.reservation_id%TYPE;
  v_f_id        reservation.flight_id%TYPE;
  v_seats       reservation.num_of_passengers%TYPE;
  
  CURSOR all_reservation IS
    SELECT reservation_id, flight_id, num_of_passengers
    FROM reservation
    WHERE cust_id = v_c_id;
BEGIN
  OPEN all_reservation;
    LOOP 
      FETCH all_reservation into v_reservation, v_f_id, v_seats;
      EXIT WHEN all_reservation%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Scheduled reservations of ' || v_c_id);
        DBMS_OUTPUT.PUT_LINE('Reservation No. ' || v_reservation);
        DBMS_OUTPUT.PUT_LINE('Flight No. ' || v_f_id);
        DBMS_OUTPUT.PUT_LINE('Seats booked: ' || v_seats);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
  CLOSE all_reservation;
END;

SET SERVEROUTPUT ON;
EXECUTE list_booking ('2015');

--------------------------------------------------------------------------------
--Procedure: Admin #1
CREATE OR REPLACE PROCEDURE flight_details 
(
  v_source IN flight.flight_source%TYPE
)
IS
  v_flight_id         flight.flight_id%TYPE;
  v_destination       flight.flight_destination%TYPE;
  v_airline           flight.airline%TYPE;
  v_date              flight.flight_date%TYPE;
  v_flight_cost       flight.flight_cost%TYPE;
  v_flight_capacity   flight.flight_capacity%TYPE;
  v_flight_departure  flight.flight_departure%TYPE;
  v_flight_arrival    flight.flight_arrival%TYPE;
  v_flight_duration   flight.flight_duration%TYPE;
  
  CURSOR cur_flight_details IS
    SELECT flight_id, flight_destination, airline, flight_date, flight_cost, 
      flight_capacity, flight_departure, flight_arrival, flight_duration 
    FROM flight
    WHERE flight_source = v_source;
BEGIN
  OPEN cur_flight_details;
    LOOP
      FETCH cur_flight_details INTO v_flight_id, v_destination, v_airline, 
        v_date, v_flight_cost, v_flight_capacity, v_flight_departure, 
        v_flight_arrival, v_flight_duration;
      EXIT WHEN cur_flight_details%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Flight No: ' || v_flight_id); 
        DBMS_OUTPUT.PUT_LINE('To: ' || v_destination);
        DBMS_OUTPUT.PUT_LINE('From: ' || v_source);
        DBMS_OUTPUT.PUT_LINE('Airline: ' || v_airline);
        DBMS_OUTPUT.PUT_LINE('Date of Flight: ' || v_date);
        DBMS_OUTPUT.PUT_LINE('Price: $' || v_flight_cost);
        DBMS_OUTPUT.PUT_LINE('Total Available Seats: ' || v_flight_capacity);
        DBMS_OUTPUT.PUT_LINE('Departure: ' || v_flight_departure);
        DBMS_OUTPUT.PUT_LINE('Arrival: ' || v_flight_arrival);
        DBMS_OUTPUT.PUT_LINE('Duration of Flight: ' ||v_flight_duration);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
  CLOSE cur_flight_details;
END;

SET serveroutput ON;
EXECUTE flight_details('New York City');

--------------------------------------------------------------------------------
--Procedure: Admin#2
CREATE OR REPLACE PROCEDURE change_cost (
  v_flight_id IN flight.flight_id%TYPE,
  v_new_cost  IN flight.flight_cost%TYPE
)
IS
BEGIN
  UPDATE flight
  SET flight_cost = v_new_cost
  WHERE flight_id = v_flight_id;
  DBMS_OUTPUT.PUT_LINE('Fare for flight ' || v_flight_id || 
    ' has been updated to $' || v_new_cost || '.');
END;

SET serveroutput ON;
EXECUTE change_cost('1012', 250);

--------------------------------------------------------------------------------
--Procedure: Admin#3
CREATE OR REPLACE PROCEDURE reservation_details (
  v_flight_id IN reservation.flight_id%TYPE
)
IS
  v_reservation_id    reservation.reservation_id%TYPE;
  v_cust_id           reservation.cust_id%TYPE;
  v_num_of_passengers reservation.num_of_passengers%TYPE;
  
  CURSOR cur_reservation_details IS
    SELECT reservation_id, cust_id, num_of_passengers
    FROM reservation
    WHERE flight_id = v_flight_id;
BEGIN
  OPEN cur_reservation_details;
    LOOP
      FETCH cur_reservation_details into v_reservation_id, v_cust_id, 
        v_num_of_passengers;
      EXIT WHEN cur_reservation_details%notfound;
        DBMS_OUTPUT.PUT_LINE('Reservations for flight: ' ||v_flight_id);
        DBMS_OUTPUT.PUT_LINE('Reservation ID: ' ||v_reservation_id);
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' ||v_cust_id);
        DBMS_OUTPUT.PUT_LINE('Number of Passengers: ' ||v_num_of_passengers);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
  CLOSE cur_reservation_details;
END;

SET serveroutput ON;
EXECUTE reservation_details('1000');

--------------------------------------------------------------------------------
--Procedure: Admin#4
CREATE OR REPLACE PROCEDURE cust_details (
 v_cust_id IN customer.cust_id%TYPE
)
IS
  v_lname   customer.cust_lname%TYPE;
  v_fname   customer.cust_fname%TYPE;
  v_email   customer.cust_email%TYPE;
  v_phone   customer.cust_phone%TYPE;
  v_address customer.address%TYPE;
  v_city    customer.city%TYPE;
  v_state   customer.state%TYPE;
  v_zip     customer.zip%TYPE;
BEGIN
  SELECT cust_lname, cust_fname, cust_email, cust_phone, address, city, state, 
    zip
  INTO v_lname, v_fname, v_email, v_phone, v_address, v_city, v_state, v_zip
  FROM customer
  WHERE cust_id = v_cust_id;
  
  DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_cust_id);
  DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_lname);
  DBMS_OUTPUT.PUT_LINE('First Name: ' || v_fname);
  DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
  DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
  DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
  DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
  DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
  DBMS_OUTPUT.PUT_LINE('Zip Code: ' || v_zip);
END;

SET serveroutput ON;
EXECUTE cust_details('2015');

--------------------------------------------------------------------------------
--Procedure: Admin#5
CREATE OR REPLACE PROCEDURE new_flight (
  v_country_to        IN flight.flight_destination%TYPE,
  v_country_from      IN flight.flight_source%TYPE,
  v_airline           IN flight.airline%TYPE,
  v_flight_date       IN flight.flight_date%TYPE,
  v_flight_cost       IN flight.flight_cost%TYPE,
  v_flight_capacity   IN flight.flight_cost%TYPE,
  v_flight_departure  IN flight.flight_departure%TYPE,
  v_flight_arrival    IN flight.flight_arrival%TYPE,
  v_flight_duration   IN flight.flight_duration%TYPE
)
IS
  v_flight_id flight.flight_id%TYPE;
BEGIN
  v_flight_id := seq_flight.NEXTVAL;
  
  INSERT INTO flight VALUES(v_flight_id, v_country_to, v_country_from, 
    v_airline, v_flight_date, v_flight_cost, v_flight_capacity, 
    v_flight_departure, v_flight_arrival, v_flight_duration);
    
  DBMS_OUTPUT.PUT_LINE('New flight added.');
  DBMS_OUTPUT.PUT_LINE('Flight ID: ' || v_flight_id);
  DBMS_OUTPUT.PUT_LINE('Destination: ' || v_country_to);
  DBMS_OUTPUT.PUT_LINE('Source: ' || v_country_from);
  DBMS_OUTPUT.PUT_LINE('Airline: ' || v_airline);
  DBMS_OUTPUT.PUT_LINE('Date: ' || v_flight_date);
  DBMS_OUTPUT.PUT_LINE('Cost: $' || v_flight_cost);
  DBMS_OUTPUT.PUT_LINE('Capacity: ' || v_flight_capacity);
  DBMS_OUTPUT.PUT_LINE('Departure: ' || v_flight_departure);
  DBMS_OUTPUT.PUT_LINE('Arrival: ' || v_flight_arrival);
  DBMS_OUTPUT.PUT_LINE('Duration: ' || v_flight_duration);
END;

SET serveroutput ON;
EXECUTE new_flight('New York City', 'LA', 'American Airlines', '08-JAN-2018', 205, 80, '15:00', '18:15', '3 Hours 15 Minutes');

commit;