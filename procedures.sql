-- returns recommendations only with score higher than threshold
CREATE PROCEDURE get_recommendations_with_score_over_threshold(threshold FLOAT)
  BEGIN
    SELECT
      PName,
      Score
    FROM rec_prods_thresh_1
    GROUP BY PID
    HAVING Score > threshold;
  END;
-- CALL rec_prods_var_thresh(0.2);

-- ziskat doporuceni pro daneho uzivatele
CREATE PROCEDURE get_user_recommendation(user_id INT)
  BEGIN
    SELECT
      PName,
      PID
    FROM rec_prods_user as T WHERE T.UID=user_id;
  END;
-- CALL get_user_recommendation(251);

-- vymaze recommendations se score nizsi nez threshold
CREATE PROCEDURE delete_uncertain_recommendations(threshold FLOAT)
  BEGIN
    DELETE FROM Recommendation WHERE Recommendation.IDP IN (SELECT
      PID
    FROM rec_prods_thresh_1
    GROUP BY PID
    HAVING Score < threshold);
  END;
-- CALL delete_uncertain_recommendations(0.01);

-- vypise topn uzivatelu dle utracenych penez
CREATE PROCEDURE get_users_with_highest_invoices(topn INT)
  BEGIN
    SELECT * FROM show_user_prods ORDER BY TotalPrice LIMIT topn;
  END;
-- CALL get_users_with_highest_invoices(5)


-- spocita celkovy prijem
CREATE PROCEDURE compute_total_income()
  BEGIN
    SELECT SUM(TotalPrice) AS TotalIncome,
           SUM(TotalN) AS TotalProductsSold
    FROM number_sel;
  END;

-- CALL compute_total_income();