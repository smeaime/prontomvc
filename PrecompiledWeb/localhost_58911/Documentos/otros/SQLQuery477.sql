SELECT TOP 1 IdArticulo FROM Articulos WHERE Descripcion='CONEC. DIN 41612 TIPO C  (64) HEMB.RECTO P/IMP.   Codigo Conec Codigo: 122A10309X  ó 12-000022.    (ubicacion E20004)'
SELECT TOP 1 IdArticulo FROM Articulos WHERE Descripcion='CONEC. DIN 41612 TIPO C  (64) HEMB.RECTO P/IMP.   Codigo Conec Codigo: 122A10309X  ó 12-000022.    (ubicacion E20004)   '
														  CONEC. DIN 41612 TIPO C  (64) HEMB.RECTO P/IMP.   Codigo Conec Codigo: 122A10309X  ó 12-000022.    (ubicacion E20004)  
														  CONEC. DIN 41612 TIPO C  (64) HEMB.RECTO P/IMP.   Codigo Conec Codigo: 122A10309X  ó 12-000022.    (ubicacion E20004)  


SELECT TOP 1 Descripcion COLLATE latin1_general_ci_as  ,* FROM Articulos WHERE Codigo like '059104724'
SELECT TOP 1 * FROM Articulos WHERE Codigo like '059655656'


SELECT TOP 1 IdArticulo FROM Articulos WHERE isnull(Descripcion,'')='C. IMP. 5740026A2 Backplane Logico CT800XI (COMPACTO) - CODIGO DAI-ICHI 592290'
																	 C. IMP. 5740026A2 Backplane Logico -- CT800DMC -- CODIGO DAI-ICHI 592290  ( CC-2F-53 )
																	 C. IMP. 5740026A2 Backplane Logico CT800XI (COMPACTO) - CODIGO DAI-ICHI 592290
SELECT  IdArticulo FROM Articulos WHERE Descripcion  
COLLATE latin1_general_ci_as='CONEC. DIN 41612 TIPO C  (64) HEMB.RECTO P/IMP.   Codigo Conec Codigo: 122A10309X  ó 12-000022.    (ubicacion E20004)  '   



COLLATE latin1_general_ci_as
													
													
	SELECT Descripcion, IdArticulo,* FROM Articulos WHERE Descripcion  like 'C. IMP. 5740026A2 Backplane Logico CT8%'
																					   




SELECT TOP 500 IdArticulo,  
                         isnull(Descripcion,'') + '' COLLATE Modern_Spanish_ci_as as Descripcion  
               FROM Articulos 
                WHERE 
                			Descripcion  COLLATE Modern_Spanish_ci_as like '%[^A-z^0-9]' + 'C. IMP. 5740026A2 Backplane Logico CT8' + '%' 
                       OR Descripcion  COLLATE Modern_Spanish_ci_as like  'C. IMP. 5740026A2 Backplane Logico CT8' + '%'  
