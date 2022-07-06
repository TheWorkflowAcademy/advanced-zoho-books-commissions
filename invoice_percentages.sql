SELECT
		 v."Invoice ID" 'Invoice ID',
		 v."Total (BCY)" 'Invoice Total',
		 sum(ii."Sub Total (BCY)") 'Items Subtotal',
		 sum(ii."Sub Total (BCY)") / v."Total (BCY)" 'Percent Commissionable',
		 v."Sales Person ID" 'Salesperson ID'
FROM  "Invoice Items (Zoho Books)" ii
JOIN "Invoices (Zoho Books)" v ON v."Invoice ID"  = ii."Invoice ID"  
GROUP BY v."Sales Person ID",
	 v."Invoice ID",
	  v."Total (BCY)" 
