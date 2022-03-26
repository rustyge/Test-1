-- 1. Найти самый дорогой товар. Вывести имя товара и его цену.
SELECT gd.name AS goods_name, pr.value AS goods_price FROM goods gd
	JOIN prices pr ON gd.id = pr.goods_id
WHERE value = (SELECT MAX(value) FROM prices)

-- 2. Найти товары с нулевым остатком. Вывести имя товара и его цену.
SELECT gd.name AS goods_name, pr.value AS goods_price, qa.value AS goods_quantity FROM goods gd
	JOIN prices pr ON gd.id = pr.goods_id
	JOIN quantity qa ON gd.id = qa.goods_id
WHERE qa.value = (SELECT MIN(value) FROM quantity)

-- 3. Найти производителя с самой большой средней ценой за товары. Вывести имя производителя и среднюю стоимость.
SELECT m.name AS manufacturer_name, Round(AVG(pr.value), 2) AS avg_goods_price FROM prices pr
	JOIN goods gd ON pr.goods_id = gd.id
	JOIN suppliers s ON gd.supplier_id = s.id
	JOIN manufacturer m ON s.id = m.id
GROUP BY m.name
HAVING AVG(pr.value) >= ALL(SELECT AVG(pr.value) FROM prices pr
	JOIN goods gd ON pr.goods_id = gd.id
	JOIN suppliers s ON gd.supplier_id = s.id
	JOIN manufacturer m ON s.id = m.id
GROUP BY m.name)

-- 4. Найти все товары производителей из Москвы. Вывести имена товаров, их цены и имена производителей.
SELECT m.location AS manufacturer_location, gd.name AS goods_name, pr.value AS price, m.name AS manufacturer_name FROM goods gd
	JOIN quantity qa ON gd.id = qa.goods_id
	JOIN prices pr ON gd.id = pr.goods_id
	JOIN suppliers s ON gd.supplier_id = s.id
	JOIN manufacturer m ON s.id = m.id
WHERE m.location = 'Moscow'
ORDER BY m.name