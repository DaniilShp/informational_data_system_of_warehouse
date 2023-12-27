SELECT seller.name, contract_signing
FROM seller LEFT JOIN invoice USING(idseller)
WHERE idinvoice IS NULL;