SELECT
		 c."Payment Date" 'Date Paid',
		 c."Amount (BCY)" 'Payment Amount',
		 p."Percent Commissionable" '% Commissionable',
		 p."Percent Commissionable" * c."Amount (BCY)" * .05 'Commission',
		 s."Name" 'Salesperson',
		 'Invoice Payments' 'Category'
FROM  "Customer Payments (Zoho Books)" c
JOIN "Invoice Payments (Zoho Books)" i ON i."Payment ID"  = c."Payment ID" 
JOIN invoice_percentages p ON p."Invoice ID"  = i."Invoice ID" 
JOIN "Sales Persons (Zoho Books)" s ON p."Salesperson ID"  = s."Sales Person ID"  
UNION ALL
 SELECT
		 r."Refund Date" 'Date Paid',
		 r."Amount (BCY)" 'Payment Amount',
		 p."Percent Commissionable" '% Commissionable',
		 p."Percent Commissionable" * r."Amount (BCY)" * -.05 'Commission',
		 s."Name" 'Salesperson',
		 'Refunds' 'Category'
FROM  "Credit Notes Refund (Zoho Books)" r
JOIN "Credit Notes (Zoho Books)" c
JOIN invoice_percentages p ON p."Invoice ID"  = c."Invoice ID" 
JOIN "Sales Persons (Zoho Books)" s ON s."Sales Person ID"  = p."Salesperson ID"  
