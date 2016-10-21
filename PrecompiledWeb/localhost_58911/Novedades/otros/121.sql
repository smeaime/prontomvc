select top 10 a.NumeroInventario,* from Articulos A where  NumeroInventario is not null

update articulos
set NumeroInventario='addd'
where IdArticulo=100



SELECT TOP 500 IdArticulo,   isnull(NumeroInventario,'') COLLATE Modern_Spanish_ci_as + ' ' +
                  isnull(Descripcion,'') + '' COLLATE Modern_Spanish_ci_as as Descripcion   
                 FROM Articulos