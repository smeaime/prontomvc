

declare @c int
declare @peso int
declare @dest int
declare @comerc int
set @comerc=1098


set @dest=44
set @c=2046
set @peso=119060

select sum(netoproc) ,idfacturaimputada --,* 
from cartasdeporte 
where 
--netoproc=30820 and
(fechaingreso < '20111223' )
and  idfacturaimputada=30451 --idfacturaimputada>29189
and (vendedor=@c or cuentaorden1=@c or cuentaorden2=@c or entregador=@c)
and (vendedor=@comerc or cuentaorden1=@comerc or cuentaorden2=@comerc or entregador=@comerc)
and destino=@dest
group by idfacturaimputada
order by idfacturaimputada




/*
2046	30820
7991	174810
3745	30180
1691	61170
1072	92950
13348	30480
13176	30510
5066	30030
3070	31480
1098	123070
3693	58340
864	30120
4543	29850
5529	60620
4958	183030
1964	30760
4019	29450
4474	60630
429	61050
7963	30830
347	30060
3605	61950
5049	58440
5015	89670
4629	30350
	0
	0
1072	119060
3693	57760
2124	30100
3340	82360
4560	28940
4629	30520
347	88300
3605	61640
1051	114520
	0
	0
4159	28660
*/