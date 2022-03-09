-- 1. Найти самый дорогой товар. Вывести имя товара и его цену.
SELECT Gd.name AS goods_name, Pr.value AS goods_price FROM Goods Gd
	JOIN Prices Pr ON Gd.id = Pr.goods_id
WHERE value = (SELECT MAX(value) FROM Prices)

-- 2. Найти товары с нулевым остатком. Вывести имя товара и его цену.
SELECT Gd.name AS goods_name, Pr.value AS goods_price FROM Goods Gd
	JOIN Prices Pr ON Gd.id = Pr.goods_id
	JOIN Quantity Qa ON Gd.id = Qa.goods_id
WHERE Qa.value = (SELECT MIN(value) FROM Quantity)

-- 2.1. Это тоже что и второе задание только плюсом выводит столбик где видно, что кол-во товара равно 0.
SELECT Gd.name AS goods_name, Pr.value AS goods_price, Qa.value AS goods_quantity FROM Goods Gd
	JOIN Prices Pr ON Gd.id = Pr.goods_id
	JOIN Quantity Qa ON Gd.id = Qa.goods_id
WHERE Qa.value = (SELECT MIN(value) FROM Quantity)

-- 3. Найти производителя с самой большой средней ценой за товары. Вывести имя производителя и среднюю стоимость.
SELECT M.name AS manufacturer_name, Round (AVG(Pr.value), 2) AS avg_goods_price FROM Goods Gs
	JOIN Quantity Qa ON Gs.id = Qa.goods_id
	JOIN Prices Pr ON Gs.id = Pr.goods_id
	JOIN Suppliers S ON Gs.supplier_id = S.id
	JOIN Manufacturer M ON S.id = M.id
GROUP BY M.name