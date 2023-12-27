SELECT name, location, bank, telephone_number FROM sclad.seller
WHERE YEAR(contract_signing) = $year AND MONTH(contract_signing) = $mounth;
