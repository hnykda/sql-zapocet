-- VIEW #1
-- 1. Kolik kusu za jaku částku si uživatel koupil jakých produktů
CREATE OR REPLACE VIEW show_user_prods_1 AS
  SELECT *
  FROM User
    INNER JOIN Invoice ON User.UID = Invoice.IDU;
-- SELECT * FROM show_user_prods_1

CREATE OR REPLACE VIEW show_user_prods_2 AS
  SELECT *
  FROM show_user_prods_1 AS T1 INNER JOIN `Order` ON T1.IID = `Order`.IDI;
-- SELECT * FROM show_user_prods_2

CREATE OR REPLACE VIEW show_user_prods_3 AS
  SELECT *
  FROM (show_user_prods_2 AS T2 INNER JOIN Product ON T2.DIP = Product.PID);
-- SELECT * FROM show_user_prods_3

CREATE OR REPLACE VIEW show_user_prods AS
  SELECT
    UName,
    PName,
    SUM(N)         AS TotalOrders,
    SUM(N * Price) AS TotalPrice
  FROM show_user_prods_3
  GROUP BY UID, PID;

-- SELECT * FROM show_user_prods;

-- VIEW #2 Ziskat prumernou cenu a prodanych kusu pro dany produkt
CREATE OR REPLACE VIEW number_sel_1 AS
  SELECT *
  FROM `Order`
    INNER JOIN Product ON `Order`.DIP = Product.PID;

CREATE OR REPLACE VIEW number_sel AS
  SELECT
    PName,
    PID,
    SUM(N)         AS TotalN,
    SUM(N * Price) AS TotalPrice,
    AVG(Price)     AS AVGPrice
  FROM number_sel_1
  GROUP BY PID;
SELECT *
FROM number_sel;

-- VIEW #3 - ziska doporucene produkty pro uzivatele
CREATE OR REPLACE VIEW rec_prods_user_1 AS
  SELECT *
  FROM Recommendation
    INNER JOIN User ON Recommendation.IDU = User.UID;

CREATE OR REPLACE VIEW rec_prods_user_2 AS
  SELECT *
  FROM rec_prods_user_1 AS T1 INNER JOIN Product ON T1.IDP = Product.PID;

CREATE OR REPLACE VIEW rec_prods_user AS
  SELECT
    UID,
    UName,
    PID,
    PName,
    Price
  FROM rec_prods_user_2
SELECT *
FROM rec_prods_user;

-- VIEW #4 - ziskat doporuceni jen s tresholdem vetsim nez 0.5
CREATE OR REPLACE VIEW rec_prods_thresh_1 AS
  SELECT *
  FROM Recommendation
    INNER JOIN Product ON Recommendation.IDP = Product.PID;
-- SELECT * FROM rec_prods_thresh_1

CREATE OR REPLACE VIEW rec_prods_thresh AS
  SELECT
    PName,
    Score
  FROM rec_prods_thresh_1
  GROUP BY PID
  HAVING Score > 0.5;
-- SELECT  * FROM rec_prods_thresh;

-- VIEW #5 - vypise produkty koupene uzivatelem a celkove sumy
CREATE OR REPLACE VIEW bought_prods AS
  SELECT
    UName,
    number_sel.PName,
    number_sel.TotalN,
    AVG(Price) AS AVGPrice
  FROM number_sel
    INNER JOIN rec_prods_user
  GROUP BY UID;
-- SELECT * FROM bought_prods;
