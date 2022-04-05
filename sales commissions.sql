SELECT
		 ip."Invoice ID" 'Invoice ID',
		 ci."Invoice Number" 'Invoice Number',
		 ci."Customer" 'Customer',
		 ci."Sales Rep" 'Rep',
			CASE
				 WHEN ci."Sales Rep"  = 'SZN' THEN .03
				 WHEN ci."Sales Rep"  = 'SZE' THEN .02
				 ELSE 0.00
			 END AS 'Rep Commission % ',
		 (ci."Commissionable %") 'Commissionable % of Payment',
		 (ci."Commissionable %" / 100) * ip."Amount (BCY)" * (
			CASE
				 WHEN ci."Sales Rep"  = 'SZN' THEN .03
				 WHEN ci."Sales Rep"  = 'SZE' THEN .02
				 ELSE 0.00
			 END) 'Commission',
		 ci."Invoice Total" 'Invoice Total',
		 ip."Amount (BCY)" 'Amount Paid',
		 ci."Commissionable Invoice Total" 'Commissionable Invoice Total',
		 ip."Payment ID" 'Payment ID',
		 cp."Payment Date" 'Date Paid',
		 'Invoice' 'Category'
FROM  "Customer Payments (Zoho Finance)" AS  cp
JOIN "Invoice Payments (Zoho Finance)" AS  ip ON ip."Payment ID"  = cp."Payment ID" 
LEFT JOIN "commission_invoices" ci ON ip."Invoice ID"  = ci."Invoice ID"  
UNION ALL
 SELECT
		 ci."Invoice ID" 'Invoice ID',
		 ci."Invoice Number" 'Invoice Number',
		 ci."Customer" 'Customer',
		 ci."Sales Rep" 'Rep',
			CASE
				 WHEN ci."Sales Rep"  = 'SZN' THEN .03
				 WHEN ci."Sales Rep"  = 'SZE' THEN .02
				 ELSE 0.00
			 END AS 'Rep Commission % ',
		 (ci."Commissionable %") 'Commissionable % of Payment',
		 -1 * (ci."Commissionable %" / 100) * cn."Total (BCY)" * (
			CASE
				 WHEN ci."Sales Rep"  = 'SZN' THEN .03
				 WHEN ci."Sales Rep"  = 'SZE' THEN .02
				 ELSE 0.00
			 END) 'Commission',
		 ci."Invoice Total" 'Invoice Total',
		 cn."Total (BCY)" 'Amount Paid',
		 ci."Commissionable Invoice Total" 'Commissionable Invoice Total',
		 cn."CreditNotes ID" 'Payment ID',
		 cn."Credit Note Date" 'Date Paid',
		 'Refund' 'Category'
FROM  "Credit Notes Refund (Zoho Finance)" c
JOIN "Credit Notes (Zoho Finance)" cn ON cn."CreditNotes ID"  = c."CreditNotes ID" 
JOIN commission_invoices ci ON ci."Invoice ID"  = cn."Invoice ID"  
WHERE	 cn."Invoice ID"  is not null
 
