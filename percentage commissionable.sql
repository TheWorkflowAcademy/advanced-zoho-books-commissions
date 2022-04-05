SELECT
		 i."Invoice Number" 'Invoice Number',
		 i."Invoice ID" 'Invoice ID',
		 i."Sales Rep" 'Sales Rep',
		 i."Customer ID" 'Customer ID',
		 c."Customer Name" 'Customer',
		 sum(ii."Total (BCY)") 'Commissionable Invoice Total',
		 i."Total (BCY)" 'Invoice Total',
		 100 * (sum(ii."Total (BCY)") / i."Total (BCY)") 'Commissionable %',
		 i."Last Payment Date" 'Last Payment Date'
FROM  "Invoice Items (Zoho Finance)" AS  ii
JOIN "Invoices (Zoho Finance)" AS  i ON ii."Invoice ID"  = i."Invoice ID" 
JOIN "Items (Zoho Finance)" AS  it ON ii."Product ID"  = it."Item ID" 
LEFT JOIN "Customers (Zoho Finance)" c ON c."Customer ID"  = i."Customer ID"  
WHERE	 it."Exclude from Commissions"  NOT LIKE 'Yes'
GROUP BY i."Invoice Number",
	 i."Sales Rep",
	 i."Customer ID",
	 i."Last Payment Date",
	 i."Total (BCY)",
	 c."Customer Name",
	  i."Invoice ID" 
