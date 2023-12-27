select id_product, shifr, $table.idseller, seller.name, product_cost, product_amount, year_supply, mounth_supply from $table
JOIN product on id_product = idproduct
JOIN seller on seller.idseller = $table.idseller
where year_supply=$input1 and mounth_supply = $input2