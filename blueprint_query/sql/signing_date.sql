SELECT name, location, bank, contract_signing FROM sclad.seller
WHERE TO_DAYS(CURDATE())-TO_DAYS(contract_signing) < $days2
AND TO_DAYS(CURDATE())-TO_DAYS(contract_signing) > $days1;
