# Supply_Chain_Analysis

In this project, we will try to answer some business questions by analyzing the supply chain data of a company.

Link to the data source 👉 https://bit.ly/3eDorUa

Dataset is divided into 7 tables.

1) _**OrderList**_ (orders that need to be assigned a route)

2) _**FreightRates**_ (all available couriers, the weight gaps for each lane, and rates associated) 

3) **_PlantPorts_** (allowed links between the warehouses and shipping ports)

4) _**ProductsPerPlant**_ (all supported warehouse-product combinations)

5) _**VmiCustomers**_ (lists all special cases, where the warehouse is only allowed to support specific customers, while any other non-listed warehouse can supply any customer)

6) _**WhCapacities**_ (warehouse capacities measured in the number of orders per day)

7) _**WhCosts**_ (cost associated with storing the products in a given warehouse measured in dollars per unit)


## The business questions we will try to answer are:

1. Top 30 products that are ordered
2. Total no.of orders that arrived earlier than 3 days before the actual delivery date
3. List of customers along with product id where the order has arrived earlier than 3 days
4. Plants that are operating under-capacity and over-capacity
5. The total cost incurred at each plant
6. Total orders, quantity, and average weight per product
7. The carriers and their number of shipments
8. Number of shipments by mode of transportation
9. Average transport day count per carrier
10. No.of orders fulfilled by each plant
