/*

Project name: Supply Chain Analysis
Created by  : Ajaikumar A
RDBMS       : Microsoft SQL Server


Description :- 
In this project, we will try to answer some business questions by analyzing the supply chain data of a company.
		
	
		
Note :-
In this SQL file, we will be analysing the data in order to answer some business questions.

Dataset is divided into 7 tables.

1) OrderList (orders that need to be assigned a route)
2) FreightRates (all available couriers, the weight gaps for each lane, and rates associated) 
3) PlantPorts (allowed links between the warehouses and shipping ports)
4) ProductsPerPlant (all supported warehouse-product combinations)
5) VmiCustomers (lists all special cases, where the warehouse is only allowed to support specific customers, while any other non-listed warehouse can supply any customer)
6) WhCapacities (warehouse capacities measured in the number of orders per day)
7) WhCosts (cost associated with storing the products in a given warehouse measured in dollars per unit)

We will be answering the following questions:

*/



-- Top 30 products that are ordered 
SELECT TOP 30
	Product_ID,
	COUNT(Order_ID) Total_orders
FROM 
	order_list
GROUP BY
	Product_ID
ORDER BY
	Total_orders DESC;



-- Total no.of orders that are arrived earlier than 3 days before the actual delivery date

SELECT
	COUNT(*) no_of_orders
FROM 
	order_list
WHERE 
	Ship_ahead_day_count > 3;



-- List of customers along with product id where the order has arrived earlier than 3 days

SELECT 
	DISTINCT 
	Customer,
	Product_ID
FROM 
	order_list
WHERE
	Ship_ahead_day_count > 3;




-- Plants that are operating under-capacity and over-capacity
WITH capacity AS
(
SELECT
	Plant_Code,
	SUM(Unit_quantity) total_units
FROM 
	order_list
GROUP BY
	Plant_Code
)

SELECT
	c.Plant_Code,
	CASE 
		WHEN c.total_units > pc.Daily_Capacity THEN 'Over capacity'
		WHEN c.total_units < pc.Daily_Capacity THEN 'Under capacity'
		ELSE 'Full capacity'
	END AS plant_capacity_range
		
FROM 
	plant_capacity pc 
	JOIN capacity c
	  ON pc.Plant_ID = c.Plant_Code;




-- Total cost incurred at each plant

SELECT
	o.Customer,
	plc.WH,
	plp.Port,
	ROUND(SUM(o.Unit_quantity *plc.Cost_unit), 2) total_cost
FROM	
	order_list o
	JOIN plant_cost plc
	  ON o.Plant_Code = plc.WH
	JOIN plant_ports plp
	  ON o.Plant_Code = plp.Plant_Code
GROUP BY
	o.Customer,
	plc.WH,
	plp.Port
ORDER BY
	total_cost DESC;






-- Total orders, quantity, and average weight per product

SELECT
	Product_ID,
	COUNT(Order_ID) Total_orders,
	SUM(Unit_quantity) Total_quantity,
	ROUND(AVG(Weight), 2) Avg_weight
FROM 
	order_list
GROUP BY
	Product_ID
ORDER BY
	Total_orders DESC;





-- The carriers and their assigned number of shipments

SELECT
	f.Carrier,
	COUNT(o.Order_ID) no_of_assigned_shipments
FROM 
	freight_rates f
	FULL JOIN order_list o
	  ON f.Carrier = o.Carrier
GROUP BY
	f.Carrier
ORDER BY 
	no_of_assigned_shipments DESC;





-- Number of shipments by mode of transportation 
SELECT
	mode_dsc AS transport_mode,
	COUNT(Order_ID) No_of_shipments
FROM 
(
	SELECT
		o.Order_ID,
		o.Origin_Port,
		o.Destination_Port,
		f.mode_dsc
	FROM 
		order_list o
		JOIN freight_rates f
		  ON o.Origin_Port = f.orig_port_cd
		 AND o.Destination_Port = f.dest_port_cd
) t
GROUP BY
	mode_dsc
ORDER BY
	No_of_shipments DESC;






-- Average transport day count per carrier
SELECT
	Carrier,
	AVG(tpt_day_cnt) avg_transport_days
FROM 
	freight_rates
GROUP BY
	Carrier
ORDER BY
	Carrier;



-- No.of orders per plant

SELECT
	Plant_Code,
	COUNT(Order_ID) no_of_orders
FROM 
	order_list
GROUP BY
	Plant_Code
ORDER BY
	no_of_orders DESC;


-- No.of orders by each customer

SELECT
	Customer,
	COUNT(Order_ID) no_of_orders
FROM 
	order_list
GROUP BY
	Customer
ORDER BY 
	no_of_orders DESC;




