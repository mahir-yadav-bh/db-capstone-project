CREATE VIEW OrdersView AS
SELECT ID, Quantity, Total_Amount
FROM orders
WHERE Quantity > 2;



SELECT customers.ID, customers.Name, orders.ID, orders.Total_Amount, menu.Name, menu.Course
FROM customers INNER JOIN orders 
ON customers.ID = orders.ID
INNER JOIN menu ON orders.Menu_ID = menu.ID 
WHERE Total_Amount > 1600  ORDER BY Total_Amount;



SELECT Name from menu
where ID= ANY (SELECT id from orders where quantity>2);




CREATE procedure GetMaxQuantity()
select max(quantity) as "Max Quantity in Order" from Orders;
call GetMaxQuantity();



prepare GetOrderDetail from 
"select ID, Total_Amount, Quantity from orders
where ID=?";
SET @ID=1;
execute GetOrderDetail using @ID;



delimiter //
CREATE procedure CancelOrder(order_id int)
begin
delete from orders where ID = order_id ;
select concat("Order", order_id, " deleted") AS "Confirmation";
end//
call CancelOrder(__)



delimiter //
CREATE procedure CheckBooking(booking_date DATE, TNo INT)
begin
declare bookingtable INT default 0;
    SELECT count(bookingtable)
    into bookingtable
    from booking 
    where Date=booking_date and Table_Number=TNo;
    if bookingtable > 0 then
        select concat("Table", TNo, " is already booked") as "Booking Status";
        else
        select concat("Table", TNo, " is not booked") as "Booking Status";
    end if;
end
call CheckBooking(___,__)



delimiter //
CREATE procedure AddValidBooking(booking_date DATE, TNo INT, CID INT)
begin
SET @bookingExists = (SELECT COUNT(ID) FROM booking WHERE Date = booking_date AND Table_Number = TNo);
start transaction;
INSERT INTO booking (ID, Date,Table_Number,customer_id1) VALUES 
(5, booking_date,TNo,CID);
IF @bookingExists < 1 THEN
	SELECT "Booking Added successfully" AS BookingStatus;
	COMMIT;
ELSE
	SELECT concat("Table ",TNo," is already booked - booking cancelled") AS BookingStatus;
	ROLLBACK;
END IF;
END //
DELIMITER ;
call AddValidBooking(__,__,__)



delimiter //
CREATE procedure AddBooking(bid INT, booking_date DATE, TNo INT, CID INT)
begin
INSERT INTO booking (ID, Date,Table_Number,customer_id1) VALUES 
(bid, booking_date,TNo,CID);
SELECT "Table booked successfully" AS "Booking Confirmation";
END //
DELIMITER ;



delimiter //
CREATE procedure UpdateBooking(bid int, bdate date)
begin
update booking 
set Date = bdate
where ID = bid;
SELECT concat("Booking ", bid, " updated successfully") AS "Confirmation";
end //
delimiter ;
call UpdateBooking(__,___)



delimiter //
CREATE procedure CancelBooking(bid int)
begin
delete from booking 
where ID = bid;
SELECT concat("Booking ", bid, " deleted successfully") AS "Confirmation";
end //
delimiter ;
call CancelBooking(__)