Select TOP 100 IdObra ,           NumeroObra + ' - ' + Descripcion AS Nombre 
                         FROM Obras  WHERE Obras.FechaFinalizacion Is NULL   
                        AND ( NumeroObra LIKE 'a%'
                         OR Descripcion LIKE 'a%'  )
                         ORDER BY NumeroObra   



						 select * from obras where obras.Jerarquia is 