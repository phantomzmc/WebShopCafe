SELECT --a.InvoiceID,
         f.ProductName,
         o.OrderQty,
         f.ProductPrice,
         d.PromotionName,
         d.PromotionDiscount,
         o.OrderTime,
         sum(f.ProductPrice *o.OrderQty) AS Total,
         sum(((f.ProductPrice *o.OrderQty)- d.PromotionDiscount) - (f.ProductPrice *o.OrderQty)) AS InvoiceDiscountAll,
        
    CASE d.PromotionType
    WHEN '2' THEN
    sum((f.ProductPrice *o.OrderQty) - d.PromotionDiscount)
    WHEN '1' THEN
    sum(((f.ProductPrice *o.OrderQty) *100)/(100+d.PromotionDiscount))
    END AS InvoicePrice
    
FROM Invoice AS a
INNER JOIN Promotion AS d
    ON d.PromotionID = a.PromotionID
INNER JOIN Orders AS o
    ON o.OrderID = a.OrderID
INNER JOIN Product AS f
    ON f.ProductID = o.ProductID
WHERE o.UserID = a.UserID
GROUP BY  a.InvoiceID,f.ProductName,o.OrderQty,f.ProductPrice,d.PromotionName,d.PromotionDiscount,d.PromotionType,o.OrderTime 