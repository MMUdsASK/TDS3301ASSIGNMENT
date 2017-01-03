1	*****************************************************
2	CPE 466                  Alex Dekhtyar, Jacob Verburg
3	Cal Poly                  Computer Science Department
4	San Luis Obispo                College of Engineering
5	California                   dekhtyar@csc.calpoly.edu   
6	*****************************************************
7	                  EXTENDED BAKERY DATASET
8	               Version 1.0
9	             April 1, 2009
10	*****************************************************
11	Sources:  this is a synthesized dataset.
12	
13	******************************************************
14	
15	This file describes the contents of the  EXTENDED BAKERY
16	dataset developed for CPE 466, Knowledge Discovery in Data,
17	course at Cal Poly.
18	
19	The dataset contains information about one year worth
20	of sales information for a couple of small bakery shops.
21	The sales are made by employees. The dataset contains
22	information about the different store locations, the assortments of
23	baked goods offered for sale and the purchases made.
24	
25	
26	General Conventions.
27	
28	 1. Setup, insert, build, and cleanup scripts are provided.
29	
30	
31	  The dataset consists of the following files:
32	
33	   - EB-build-location.sql : information about the bakery's locations
34	   - EB-build-employee.sql : information about the bakery's employees
35	   - EB-build-goods.sql    : information about the baked goods offered
36	                             for sale by the bakery
37	   - EB-build-items.sql    : itemized reciept infromation for purchases
38	   - EB-build-reciepts.sql : general reciept information for purchases
39	
40	
41	 EB-build-reciepts.sql stores information about individual reciepts
42	(purchases by customers). Each purchase may contain from
43	one to eight items, items.sql contains itemized reciept information.
44	
45	
46	 Individual files have the following formats.
47	
48	**************************************************************************
49	
50	 EB-build-location.sql
51	
52	     City: City the store is located in
53	    State: State the store is located in
54	      Zip: Zip the store is located in
55	   Street: Street the store is located on
56	 StoreNum: unique identifier of the store
57	
58	**************************************************************************
59	
60	 EB-build-employee.sql
61	
62	     Last: last name of the employee
63	    First: first name of the employee
64	 HireDate: date employee was hired
65	 FireDate: date employee was fired
66	 Position: job title (e.g., Shift Manager, Barista, Cashier)
67	 FullTime: true for full time, false for part time
68	 StoreNum: store they work at (see location.StoreNum)
69	    EmpId: unique identifier for the employee
70	
71	
72	
73	**************************************************************************
74	
75	
76	 EB-build-goods.sql
77	
78	     Id : unique identifier of the baked good
79	  Flavor: flavor/type of the good (e.g., "chocolate", "lemon")
80	    Food: category of the good (e.g., "cake", "tart")
81	   Price: price (in dollars)
82	    Type: Food or Drink
83	
84	
85	
86	**************************************************************************
87	
88	 EB-build-items.sql
89	
90	    Reciept : reciept number (see reciepts.RecieptNumber)
91	   Quantity : amount of this item purchased, (e.g. 2 for two chocolate cakes)
92	    Item    : identifier of the item purchased (see goods.Id)
93	   
94	
95	
96	**************************************************************************
97	
98	 EB-build-receipts.sql
99	
100	RecieptNumber : unique identifier of the reciept
101	     SaleDate : date of the purchase. The date is
102	                in  DD-Mon-YYY format, which is the
103	                default Oracle's format for DATE data type.
104	      Weekend : true for if this was a saturday or sunday
105	            isCash: true they paid in cash, false they paid with credit
106	         EmpId: Employee who made the sale, (see employee.EmpId)
107	          StoreNum: Store this receipt came from, (see location.StoreNum)
108	
109	**************************************************************************
110	**************************************************************************
111	
112	Permission granted to use and distribute this dataset in its current form,
113	provided this file  is kept unchanged and is distributed together with the
114	data.
115	
116	Permission granted to modify and expand this dataset, provided this
117	file is updated accordingly with new information.
118	
119	**************************************************************************
120	**************************************************************************