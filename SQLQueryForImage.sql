USE FlowerDB

UPDATE Flower
SET Image = REPLACE(Image, 'C:\Users\Olya\Desktop\', '')
WHERE Image LIKE 'C:\Users\Olya\Desktop\%';

UPDATE Flower
SET Image = CONCAT('C:\Users\Olya\Desktop\', Image);

UPDATE Ikebana
SET Image = REPLACE(Image, 'C:\Users\Olya\Desktop\', '')
WHERE Image LIKE 'C:\Users\Olya\Desktop\%';

UPDATE Ikebana
SET Image = CONCAT('C:\Users\Olya\Desktop\', Image);